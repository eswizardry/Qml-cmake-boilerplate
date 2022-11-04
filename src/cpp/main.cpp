#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QDir>

#include <spdlog/spdlog.h>
#include <spdlog/sinks/basic_file_sink.h>

#include <platform/fileio.h>
#include <platform/platform.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    app.setApplicationName("Qml-Cmake-Boilerplate");
    app.setOrganizationName("esWizardry");
    app.setOrganizationDomain("eswizardry.com");

    QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;
    Platform              platform(&engine);
    FileIO                fileio;

    spdlog::info("Welcome to spdlog!");
    spdlog::debug("This message should be displayed..");

    // expose C++ classes to QML
    engine.rootContext()->setContextProperty("__fileio", &fileio);
    engine.rootContext()->setContextProperty("__platform", &platform);

    // load main file
    engine.load(QUrl(QStringLiteral("qrc:/qml/loader.qml")));

    // set debug mode as QML property
#ifdef DEBUG
    auto rootObect = engine.rootObjects();
    rootObect.first()->setProperty("_DEBUG_MODE", true);
#else
    engine.rootObjects().first()->setProperty("_DEBUG_MODE", false);
#endif

    return app.exec();
}
