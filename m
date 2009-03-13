From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Clean-up for rx51
Date: Fri, 13 Mar 2009 15:47:26 -0700
Message-ID: <20090313224725.GT19229@atomide.com>
References: <20090313180123.1548.1188.stgit@localhost> <20090313180707.GQ19229@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9ADF8FXzFeE7X4jE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:65523 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbZCMWrZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2009 18:47:25 -0400
Received: from c-69-181-40-92.hsd1.ca.comcast.net ([69.181.40.92] helo=localhost.localdomain)
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1LiG9y-000BLi-NZ
	for linux-omap@vger.kernel.org; Fri, 13 Mar 2009 22:47:23 +0000
Content-Disposition: inline
In-Reply-To: <20090313180707.GQ19229@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's one more patch to fix checkpatch.pl warnings.

Tony

--9ADF8FXzFeE7X4jE
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="rx51-checkpatch.patch"
Content-Transfer-Encoding: quoted-printable

=46rom f1d42da50bfdb9e952882f32e2e95f9e9621ce00 Mon Sep 17 00:00:00 2001
=46rom: Tony Lindgren <tony@atomide.com>
Date: Fri, 13 Mar 2009 15:30:06 -0700
Subject: [PATCH] rx51: Clean-up for checkpatch.pl

rx51: Clean-up for checkpatch.pl

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defcon=
fig
index 53f6a79..2672a70 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -43,7 +43,7 @@ CONFIG_BSD_PROCESS_ACCT=3Dy
 # CONFIG_TASKSTATS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
-CONFIG_LOG_BUF_SHIFT=14
+CONFIG_LOG_BUF_SHIFT
 CONFIG_GROUP_SCHED=3Dy
 CONFIG_FAIR_GROUP_SCHED=3Dy
 # CONFIG_RT_GROUP_SCHED is not set
@@ -194,7 +194,7 @@ CONFIG_OMAP_MCBSP=3Dy
 # CONFIG_OMAP_MBOX_FWK is not set
 # CONFIG_OMAP_MPU_TIMER is not set
 CONFIG_OMAP_32K_TIMER=3Dy
-CONFIG_OMAP_32K_TIMER_HZ=128
+CONFIG_OMAP_32K_TIMER_HZ=3D128
 CONFIG_OMAP_TICK_GPTIMER=3D1
 CONFIG_OMAP_DM_TIMER=3Dy
 # CONFIG_OMAP_LL_DEBUG_UART1 is not set
@@ -262,7 +262,7 @@ CONFIG_VMSPLIT_3G=3Dy
 # CONFIG_VMSPLIT_1G is not set
 CONFIG_PAGE_OFFSET=3D0xC0000000
 # CONFIG_PREEMPT is not set
-CONFIG_HZ=128
+CONFIG_HZ=3D128
 CONFIG_AEABI=3Dy
 # CONFIG_OABI_COMPAT is not set
 CONFIG_ARCH_FLATMEM_HAS_HOLES=3Dy
@@ -639,8 +639,8 @@ CONFIG_BLK_DEV_LOOP=3Dy
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=3Dy
-CONFIG_BLK_DEV_RAM_COUNT=16
-CONFIG_BLK_DEV_RAM_SIZE=16384
+CONFIG_BLK_DEV_RAM_COUNT=3D16
+CONFIG_BLK_DEV_RAM_SIZE=3D16384
 # CONFIG_BLK_DEV_XIP is not set
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
@@ -1686,7 +1686,7 @@ CONFIG_NLS_ISO8859_1=3Dy
 CONFIG_PRINTK_TIME=3Dy
 CONFIG_ENABLE_WARN_DEPRECATED=3Dy
 CONFIG_ENABLE_MUST_CHECK=3Dy
-CONFIG_FRAME_WARN=1024
+CONFIG_FRAME_WARN=3D1024
 CONFIG_MAGIC_SYSRQ=3Dy
 # CONFIG_UNUSED_SYMBOLS is not set
 CONFIG_DEBUG_FS=3Dy
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-o=
map2/board-rx51-peripherals.c
index b86e94d..6e23587 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -98,19 +98,19 @@ static int rx51_keymap[] =3D {
 	KEY(0, 7, KEY_I),
 	KEY(1, 0, KEY_O),
 	KEY(1, 1, KEY_D),
-	KEY(1, 2, KEY_DOT ),
+	KEY(1, 2, KEY_DOT),
 	KEY(1, 3, KEY_V),
-	KEY(1, 4, KEY_DOWN ),
+	KEY(1, 4, KEY_DOWN),
 	KEY(2, 0, KEY_P),
 	KEY(2, 1, KEY_F),
-	KEY(2, 2, KEY_UP ),
+	KEY(2, 2, KEY_UP),
 	KEY(2, 3, KEY_B),
-	KEY(2, 4, KEY_RIGHT ),
-	KEY(3, 0, KEY_COMMA ),
+	KEY(2, 4, KEY_RIGHT),
+	KEY(3, 0, KEY_COMMA),
 	KEY(3, 1, KEY_G),
-	KEY(3, 2, KEY_ENTER ),
+	KEY(3, 2, KEY_ENTER),
 	KEY(3, 3, KEY_N),
-	KEY(4, 0, KEY_BACKSPACE ),
+	KEY(4, 0, KEY_BACKSPACE),
 	KEY(4, 1, KEY_H),
 	KEY(4, 3, KEY_M),
 	KEY(4, 4, KEY_LEFTCTRL),
@@ -122,7 +122,7 @@ static int rx51_keymap[] =3D {
 	KEY(6, 1, KEY_K),
 	KEY(6, 2, KEY_X),
 	KEY(6, 3, KEY_SPACE),
-	KEY(6, 4, KEY_FN ),
+	KEY(6, 4, KEY_FN),
 	KEY(7, 0, KEY_S),
 	KEY(7, 1, KEY_L),
 	KEY(7, 2, KEY_C),
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-r=
x51.c
index 98dfde1..c90120c 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -14,6 +14,8 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/delay.h>
=20
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -30,10 +32,6 @@
 #include <mach/gpmc.h>
 #include <mach/usb.h>
=20
-#include <asm/io.h>
-#include <asm/delay.h>
-
-
 static struct omap_uart_config rx51_uart_config =3D {
 	.enabled_uarts	=3D ((1 << 0) | (1 << 1) | (1 << 2)),
 };

--9ADF8FXzFeE7X4jE--
