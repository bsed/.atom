'use babel';

import Thinkphp5SnippetsView from './thinkphp5-snippets-view';
import { CompositeDisposable } from 'atom';

export default {

  thinkphp5SnippetsView: null,
  modalPanel: null,
  subscriptions: null,

  activate(state) {
    this.thinkphp5SnippetsView = new Thinkphp5SnippetsView(state.thinkphp5SnippetsViewState);
    this.modalPanel = atom.workspace.addModalPanel({
      item: this.thinkphp5SnippetsView.getElement(),
      visible: false
    });

    // Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    this.subscriptions = new CompositeDisposable();

    // Register command that toggles this view
    this.subscriptions.add(atom.commands.add('atom-workspace', {
      'thinkphp5-snippets:toggle': () => this.toggle()
    }));
  },

  deactivate() {
    this.modalPanel.destroy();
    this.subscriptions.dispose();
    this.thinkphp5SnippetsView.destroy();
  },

  serialize() {
    return {
      thinkphp5SnippetsViewState: this.thinkphp5SnippetsView.serialize()
    };
  },

  toggle() {
    console.log('Thinkphp5Snippets was toggled!');
    return (
      this.modalPanel.isVisible() ?
      this.modalPanel.hide() :
      this.modalPanel.show()
    );
  }

};
