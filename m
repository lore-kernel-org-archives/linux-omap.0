From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC] [PATCH 2/3] TTY: Add definition of a new line
	discipline required by Amstrad E3 (Delta) ASoC driver
Date: Wed, 22 Jul 2009 05:22:37 +0200
Message-ID: <200907220522.39272.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jkrzyszt@tis.icnet.pl, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: alsa-devel@alsa-project.org, Jonathan McDowell <noodles@earth.li>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, e3-hacking@earth.li, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arun KS <arunks@mistralsolutions.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

This patch adds new line discipline name an number to include/linux/tty.h. The
line discipline will be used by the Amstrad E3 (Delta) sound driver that will
come next in this series of patches.

Created against linux-2.6.31-rc3.
Applies to linux-omap-2.6 commit 7c5cb7862d32cb344be7831d466535d5255e35ac as
well.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
The line discipline is named after the board name as its code will be board
specific.

--- linux-2.6.31-rc1/include/linux/tty.h.orig	2009-07-04 16:39:56.000000000 +0200
+++ linux-2.6.31-rc1/include/linux/tty.h	2009-07-06 16:14:31.000000000 +0200
@@ -23,7 +23,7 @@
  */
 #define NR_UNIX98_PTY_DEFAULT	4096      /* Default maximum for Unix98 ptys */
 #define NR_UNIX98_PTY_MAX	(1 << MINORBITS) /* Absolute limit */
-#define NR_LDISCS		19
+#define NR_LDISCS		20
 
 /* line disciplines */
 #define N_TTY		0
@@ -47,6 +47,8 @@
 #define N_SLCAN		17	/* Serial / USB serial CAN Adaptors */
 #define N_PPS		18	/* Pulse per Second */
 
+#define N_AMSDELTA	19	/* codec control over modem, board specific */
+
 /*
  * This character is the same as _POSIX_VDISABLE: it cannot be used as
  * a c_cc[] character, but indicates that a particular special character
