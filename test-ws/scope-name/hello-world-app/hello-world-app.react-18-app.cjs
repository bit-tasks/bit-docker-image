/**
 * this is the app's plugin file.
 * @see https://bit.dev/docs/apps/create-react-apps
 * */ 

/** @type {import("@teambit/react.apps.react-app-types").ReactAppOptions} */

const HelloWorldApp = {
  name: 'hello-world-app',
  entry: [require.resolve('./hello-world-app.app-root')],
};

module.exports.default = HelloWorldApp;
