From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH (for-next-vol2)] [OMAP] htcherald: Update defconfig to include mux support
Date: Sat,  5 Dec 2009 12:51:31 -0800
Message-ID: <1260046291-14717-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:33169 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191AbZLEUvl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Dec 2009 15:51:41 -0500
Received: by pwj9 with SMTP id 9so233866pwj.21
        for <linux-omap@vger.kernel.org>; Sat, 05 Dec 2009 12:51:48 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Cory Maccarrone <darkstar6262@gmail.com>

The existing htcherald_defconfig did not include mux support, which
prevented USB and other functionality from working out of the box.
This change updates the defconfig to add it in.  It also aligns the
defconfig to the -rc8 kernel config.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/configs/htcherald_defconfig |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/htcherald_defconfig b/arch/arm/configs/htcherald_defconfig
index 3382676..1b39691 100644
--- a/arch/arm/configs/htcherald_defconfig
+++ b/arch/arm/configs/htcherald_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.32-rc6
-# Sat Nov 14 10:56:01 2009
+# Linux kernel version: 2.6.32-rc8
+# Sat Dec  5 12:16:24 2009
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -198,7 +198,9 @@ CONFIG_ARCH_OMAP1=y
 # OMAP Feature Selections
 #
 # CONFIG_OMAP_RESET_CLOCKS is not set
-# CONFIG_OMAP_MUX is not set
+CONFIG_OMAP_MUX=y
+# CONFIG_OMAP_MUX_DEBUG is not set
+CONFIG_OMAP_MUX_WARNINGS=y
 CONFIG_OMAP_MCBSP=y
 # CONFIG_OMAP_MBOX_FWK is not set
 CONFIG_OMAP_MPU_TIMER=y
@@ -207,6 +209,7 @@ CONFIG_OMAP_LL_DEBUG_UART1=y
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
 # CONFIG_OMAP_LL_DEBUG_UART3 is not set
 # CONFIG_OMAP_LL_DEBUG_NONE is not set
+CONFIG_OMAP_SERIAL_WAKE=y
 # CONFIG_OMAP_PM_NONE is not set
 CONFIG_OMAP_PM_NOOP=y
 
-- 
1.6.3.3

