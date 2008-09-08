From: "A NAVEEN" <anaveen@mistralsolutions.com>
Subject: [PATCH] Patch for Touch Screen noise on OMAP3EVM.
Date: Mon, 8 Sep 2008 11:41:57 +0530
Message-ID: <6B5159045A3A48F9831070C42A927DE7@mistral.in>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx04.mailboxcop.com ([206.125.223.74]:47060 "EHLO
	mx04.mailboxcop.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbYIHGI6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 02:08:58 -0400
Received: from secure3.apollohosting.com (secure3.apollohosting.com [206.125.215.253])
	by mx04.mailboxcop.com (8.13.8/8.13.8) with ESMTP id m8868v4l003833
	for <linux-omap@vger.kernel.org>; Mon, 8 Sep 2008 01:08:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Samyeer Metrani' <samyeer@mistralsoftware.com>



When git kernel tree is used on a OMAP3EVM board file for touch screen
testing, it shows lot of jitter. With this patch the jitter can be
reduced.

Signed-off-by: Naveen Atmakuri <anaveen@mistralsolutions.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c
b/arch/arm/mach-omap2/board-omap3evm.c
index 4963f0f..9a4784e 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -27,6 +27,8 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
+#include <linux/io.h>
+#include <linux/delay.h>
 
 #include <mach/gpio.h>
 #include <mach/keypad.h>
@@ -132,8 +134,16 @@ static int ads7846_get_pendown_state(void)
 }
 
 struct ads7846_platform_data ads7846_config = {
+	.x_max                  = 0x0fff,
+	.y_max                  = 0x0fff,
+	.x_plate_ohms           = 180,
+	.pressure_max           = 255,
+	.debounce_max           = 10,
+	.debounce_tol           = 3,
+	.debounce_rep           = 1,
 	.get_pendown_state	= ads7846_get_pendown_state,
 	.keep_vref_on		= 1,
+	.settle_delay_usecs     = 150,
 };
 
 static struct omap2_mcspi_device_config ads7846_mcspi_config = {
-- 
1.5.6


Warm Regards,
Naveen Atmakuri.


