
int getReferenceTime() {
    int ms = new DateTime.now().millisecondsSinceEpoch;
    return (ms / 1000).round();
}