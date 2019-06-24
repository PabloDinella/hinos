import React from "react";
import { ScrollView, StyleSheet } from "react-native";
import HymnsList from "../components/HymnsList";

export default class HymnsScreen extends React.Component {
  static navigationOptions = {
    title: "Hymns"
  };

  render() {
    return (
      <ScrollView style={styles.container}>
        {/* Go ahead and delete ExpoHymnsView and replace it with your
         * content, we just wanted to provide you with some helpful links */}
        <HymnsList />
      </ScrollView>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 15,
    backgroundColor: "#fff"
  }
});
