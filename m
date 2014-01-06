From: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Problems with double, qreal and float porting an application - Help
 please!
Date: Mon, 06 Jan 2014 01:54:02 +0000
Message-ID: <52CA0CBA.8070503@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from know-smtprelay-omc-3.server.virginmedia.net ([80.0.253.67]:45239
	"EHLO know-smtprelay-omc-3.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbaAFB7r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 5 Jan 2014 20:59:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

System is an ODROID-X.
root@odroid:/1/cuSDR32# uname -a
Linux odroid 3.8.13.14 #1 SMP PREEMPT Sat Dec 21 22:14:31 UTC 2013=20
armv7l armv7l armv7l GNU/Linux

root@odroid:/1/cuSDR32# cat /etc/os-release
NAME=3D"Ubuntu"
VERSION=3D"13.10, Saucy Salamander"
ID=3Dubuntu
ID_LIKE=3Ddebian
PRETTY_NAME=3D"Ubuntu 13.10"
VERSION_ID=3D"13.10"
HOME_URL=3D"http://www.ubuntu.com/"
SUPPORT_URL=3D"http://help.ubuntu.com/"
BUG_REPORT_URL=3D"http://bugs.launchpad.net/ubuntu/"

The failures and the offending lines below.
-------------------------------------------------------
g++ -c -pipe -g -Wall -W -D_REENTRANT -DQT_MULTIMEDIA_LIB=20
-DQT_OPENGL_LIB -DQT_GUI_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB -DQT_SHARED=
=20
-I/usr/share/qt4/mkspecs/linux-g++ -I. -I/usr/include/qt4/QtCore=20
-I/usr/include/qt4/QtNetwork -I/usr/include/qt4/QtGui=20
-I/usr/include/qt4/QtOpenGL -I/usr/include/qt4/QtMultimedia=20
-I/usr/include/qt4 -I/usr/include/QtMultimediaKit=20
-I/usr/include/QtMobility -I. -Isrc -Isrc/AudioEngine -Isrc/CL=20
-Isrc/DataEngine -Isrc/GL -Isrc/QtDSP -Isrc/Util -I/usr/X11R6/include=20
-Ibld/moc -o bld/o/qtdsp_wpagc.o src/QtDSP/qtdsp_wpagc.cpp
src/QtDSP/qtdsp_wpagc.cpp: In member function =91void=20
QWPAGC::ProcessAGC(CPX&, CPX&, int)=92:
src/QtDSP/qtdsp_wpagc.cpp:290:88: error: no matching function for call=20
to =91qMin(double, float)=92
mult =3D (m_out_target - m_slope_constant * qMin(0.0, log10=20
(m_inv_max_input * m_volts))) / m_volts;
^
src/QtDSP/qtdsp_wpagc.cpp:290:88: note: candidate is:
In file included from /usr/include/qt4/QtCore/qiterator.h:45:0,
from /usr/include/qt4/QtCore/qvector.h:45,
from /usr/include/qt4/QtCore/QVector:1,
from src/QtDSP/qtdsp_qComplex.h:34,
from src/QtDSP/qtdsp_wpagc.h:36,
from src/QtDSP/qtdsp_wpagc.cpp:34:
/usr/include/qt4/QtCore/qglobal.h:1213:34: note: template<class T> cons=
t=20
T& qMin(const T&, const T&)
Q_DECL_CONSTEXPR inline const T &qMin(const T &a, const T &b) { return=20
(a < b) ? a : b; }
^
/usr/include/qt4/QtCore/qglobal.h:1213:34: note: template argument=20
deduction/substitution failed:
src/QtDSP/qtdsp_wpagc.cpp:290:88: note: deduced conflicting types for=20
parameter =91const T=92 (=91double=92 and =91float=92)
mult =3D (m_out_target - m_slope_constant * qMin(0.0, log10=20
(m_inv_max_input * m_volts))) / m_volts;
^
src/QtDSP/qtdsp_wpagc.cpp: In member function =91void=20
QWPAGC::setHangLevelDb(qreal)=92:
src/QtDSP/qtdsp_wpagc.cpp:588:78: error: no matching function for call=20
to =91qMax(double, qreal)=92
qreal tmp =3D qMax(1.0e-8, (convert - m_minVolts) / (m_maxInput -=20
m_minVolts));
^
src/QtDSP/qtdsp_wpagc.cpp:588:78: note: candidate is:
In file included from /usr/include/qt4/QtCore/qiterator.h:45:0,
from /usr/include/qt4/QtCore/qvector.h:45,
from /usr/include/qt4/QtCore/QVector:1,
from src/QtDSP/qtdsp_qComplex.h:34,
from src/QtDSP/qtdsp_wpagc.h:36,
from src/QtDSP/qtdsp_wpagc.cpp:34:
/usr/include/qt4/QtCore/qglobal.h:1215:34: note: template<class T> cons=
t=20
T& qMax(const T&, const T&)
Q_DECL_CONSTEXPR inline const T &qMax(const T &a, const T &b) { return=20
(a < b) ? b : a; }
^
/usr/include/qt4/QtCore/qglobal.h:1215:34: note: template argument=20
deduction/substitution failed:
src/QtDSP/qtdsp_wpagc.cpp:588:78: note: deduced conflicting types for=20
parameter =91const T=92 (=91double=92 and =91qreal {aka float}=92)
qreal tmp =3D qMax(1.0e-8, (convert - m_minVolts) / (m_maxInput -=20
m_minVolts));
^
make: *** [bld/o/qtdsp_wpagc.o] Error 1
root@odroid:/1/cuSDR32#
svn co http://svn.tapr.org/repos_sdr_hpsdr/trunk/DL3HVH/cuSDR32/ for th=
e=20
source.
Regards
Sid.

--=20
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support
Senior Staff Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
