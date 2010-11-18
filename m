From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] arm: omap1: add missing includes
Date: Thu, 18 Nov 2010 19:59:46 +0200
Message-ID: <1290103191-360-2-git-send-email-aaro.koskinen@nokia.com>
References: <1290103191-360-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:44839 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760006Ab0KRR7v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 12:59:51 -0500
In-Reply-To: <1290103191-360-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

Add missing includes to get rid of the following sparse warnings:

	arch/arm/mach-omap1/devices.c:225:13: warning: symbol 'omap1_camera_init' was not declared. Should it be static?
	arch/arm/mach-omap1/flash.c:15:6: warning: symbol 'omap1_set_vpp' was not declared. Should it be static?
	arch/arm/mach-omap1/serial.c:190:6: warning: symbol 'omap_serial_wake_trigger' was not declared. Should it be static?
	arch/arm/mach-omap1/time.c:252:18: warning: symbol 'omap_timer' was not declared. Should it be static?

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap1/devices.c |    1 +
 arch/arm/mach-omap1/flash.c   |    1 +
 arch/arm/mach-omap1/serial.c  |    2 ++
 arch/arm/mach-omap1/time.c    |    1 +
 4 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index e7f9ee6..86ad38a 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/spi/spi.h>
 
+#include <mach/camera.h>
 #include <mach/hardware.h>
 #include <asm/mach/map.h>
 
diff --git a/arch/arm/mach-omap1/flash.c b/arch/arm/mach-omap1/flash.c
index 0b07a78..acd1616 100644
--- a/arch/arm/mach-omap1/flash.c
+++ b/arch/arm/mach-omap1/flash.c
@@ -11,6 +11,7 @@
 
 #include <plat/io.h>
 #include <plat/tc.h>
+#include <plat/flash.h>
 
 void omap1_set_vpp(struct map_info *map, int enable)
 {
diff --git a/arch/arm/mach-omap1/serial.c b/arch/arm/mach-omap1/serial.c
index b78d074..0845fbb 100644
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -27,6 +27,8 @@
 #include <mach/gpio.h>
 #include <plat/fpga.h>
 
+#include "pm.h"
+
 static struct clk * uart1_ck;
 static struct clk * uart2_ck;
 static struct clk * uart3_ck;
diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index 1be6a21..7f75bc6 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -52,6 +52,7 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
+#include <plat/common.h>
 
 #define OMAP_MPU_TIMER_BASE		OMAP_MPU_TIMER1_BASE
 #define OMAP_MPU_TIMER_OFFSET		0x100
-- 
1.5.6.5

