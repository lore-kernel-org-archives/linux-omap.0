From: "James Selvam" <james.iisc@gmail.com>
Subject: Problem compiling hello world for OPIE on OMAP 1510 Innovator.
Date: Wed, 7 Jun 2006 15:37:00 +0530
Message-ID: <fd1e34b0606070307g54ff9578r71ccfb98d5d4e447@mail.gmail.com>
References: <fd1e34b0606070303j2a30c09dw29ad404796662041@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <fd1e34b0606070303j2a30c09dw29ad404796662041@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: OMAP-Linux <Linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hello All,

I have built qte and OPIE with a 2.95.3 cross tool for ARM (as specified in
http://people.via.ecp.fr/~clem/nist/qt-notes.php<http://people.via.ecp.fr/%7Eclem/nist/qt-notes.php>).
I am trying to make a hello world application for the familiar
0.8.4-rc1root file system for iPaq 6300 and use it with the OMAP 1510
Innovator.

But it complains that :

myhello: symbol lookup error: myhello: undefined symbol:
_7QString.shared_null

This is perhaps because of the toolchain being used. The later familiar
versions perhaps use the later cross-tool chains. But the build process
fails with the 3.4.1 toolchain.

I have tried putting the older libraries from Familiar 0.7.X also.
It then complains (from the new libraries) that

./myhello: symbol lookup error: /opt/QtPalmtop/lib/libqpe.so.1: undefined
symbol: _ZN12QApplication13active_windowE

Has someone worked on OPIE and faced a similar problem? If yes how do we
circumvent this problem?
Can I download a precompiled qte and OPIE from somewhere?

Regards,
 James Selvam.
