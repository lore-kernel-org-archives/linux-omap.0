From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH] omap1: amsdelta: defconfig updates
Date: Wed, 7 Apr 2010 18:16:04 +0200
Message-ID: <201004071816.09538.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:39845 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932539Ab0DGQRz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Apr 2010 12:17:55 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, e3-hacking@earth.li

The patch provides the following ams_delta_defconfig updates:
- explicitly select preemptable RCU,
- replace outdated CONFIG_LBD and CONFIG_LSF options with CONFIG_LBDAF,
- activate support for LCD contrast setting (new in 2.6.34),
- turn off verbose bug reporting for smaller kernel.

Created and tested against linux-2.6.34-rc3.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
--- git/arch/arm/configs/ams_delta_defconfig.orig	2010-04-01 17:54:09.000000000 +0200
+++ git/arch/arm/configs/ams_delta_defconfig	2010-04-07 17:17:25.000000000 +0200
@@ -47,6 +47,7 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_TASKSTATS is not set
 # CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
+CONFIG_TREE_PREEMPT_RCU=y
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED=y
@@ -95,9 +96,8 @@ CONFIG_KMOD=y
 # Block layer
 #
 CONFIG_BLOCK=y
-# CONFIG_LBD is not set
+# CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
 
 #
 # IO Schedulers
@@ -835,7 +835,8 @@ CONFIG_DAB=y
 #
 # Graphics support
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_LCD_CLASS_DEVICE=y
 
 #
 # Display device support
@@ -1283,7 +1284,7 @@ CONFIG_DEBUG_PREEMPT=y
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
-CONFIG_DEBUG_BUGVERBOSE=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
