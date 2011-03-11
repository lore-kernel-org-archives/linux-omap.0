From: Denis Karpov <ext-denis.2.karpov@nokia.com>
Subject: [PATCH 2/2] omap: rx51: initialize platform data for twl4030 powerbutton
Date: Fri, 11 Mar 2011 18:37:30 +0200
Message-ID: <0aaadf1ebe1864fa310a8b1330dd688079983f8d.1299860654.git.ext-denis.2.karpov@nokia.com>
References: <1299861450-19914-1-git-send-email-ext-denis.2.karpov@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:25732 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753576Ab1CKQhm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 11:37:42 -0500
In-Reply-To: <1299861450-19914-1-git-send-email-ext-denis.2.karpov@nokia.com>
In-Reply-To: <078f4a01fa523a0f9e0033c52f52413d60cc5431.1299860654.git.ext-denis.2.karpov@nokia.com>
References: <078f4a01fa523a0f9e0033c52f52413d60cc5431.1299860654.git.ext-denis.2.karpov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

From: Denis Karpov <ext-denis.2.karpov@nokia.com>

Adds and initializes platform data for TWL4030 powerbutton.
Disable repeat input events from a button press (default behaviour).

Signed-off-by: Denis Karpov <ext-denis.2.karpov@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 5f1900c..c9a21ef 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -264,6 +264,10 @@ static struct twl4030_keypad_data rx51_kp_data = {
 	.rep		= 1,
 };
 
+static struct twl4030_pwrbutton_data rx51_pwrbutton_data = {
+	.rep		= 1,
+};
+
 static struct twl4030_madc_platform_data rx51_madc_data = {
 	.irq_line		= 1,
 };
@@ -758,6 +762,7 @@ static struct twl4030_platform_data rx51_twldata __initdata = {
 	/* platform_data for children goes here */
 	.gpio			= &rx51_gpio_data,
 	.keypad			= &rx51_kp_data,
+	.pwrbutton		= &rx51_pwrbutton_data,
 	.madc			= &rx51_madc_data,
 	.usb			= &rx51_usb_data,
 	.power			= &rx51_t2scripts_data,
-- 
1.7.1

