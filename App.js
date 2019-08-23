import React from 'react';
import { Image, View } from 'react-native';
import EsriMapView, { setLicenseKey } from './EsriMapView';

const graphics = {
  pointGraphics: [
    {
      graphicId: 'point',
      graphic: Image.resolveAssetSource(require('./marker.png'))
    }
  ],
  referenceId: 'graphicsOverlay',
  points: [
    {
      latitude: 45.51223,
      longitude: -122.658722,
      rotation: 0,
      graphicId: 'point'
    },
    {
      latitude: 38.907192,
      longitude: -77.036873,
      rotation: 0,
      referenceId: '2',
      graphicId: 'point'
    },
    {
      latitude: 39.739235,
      longitude: -104.99025,
      rotation: 0,
      referenceId: '3',
      graphicId: 'point'
    }
  ],

  lines: [
    {
      points: [
        { latitude: 109.6875, longitude: 11.523087506868514 },
        { latitude: 69.9609375, longitude: 68.13885164925573 }
      ],
      outline: '#00FF00'
    }
  ],
  polygons: [
    {
      points: [
        { latitude: -64.68751, longitude: 12.89748 },
        { latitude: 46.40625, longitude: 38.82259 },
        { latitude: 7.03125, longitude: 62.10388 },
        { latitude: -64.68751, longitude: 12.89748 }
      ],
      color: '#0000FF',
      outline: '#FF0000'
    }
  ]
};

class App extends React.Component {
  constructor(props) {
    super(props);
    setLicenseKey('');
  }
  componentDidMount() {
    this.mapView.addGraphicsOverlay(graphics);
  }
  render() {
    return (
      <View style={{ flex: 1 }}>
        <EsriMapView
          ref={mapView => (this.mapView = mapView)}
          style={{ width: '100%', height: '100%' }}
          initialMapCenter={[{ latitude: 34.055561, longitude: -117.182602 }]}
          recenterIfGraphicTapped={true}
          rotationEnabled={false}
          mapBasemap={{ type: 'normal' }}
          maxZoom={0.1}
        />
      </View>
    );
  }
}

export default App;
