From: Steve Sakoman <sakoman@gmail.com>
Subject: [PATCH] ARM:OMAP: Enable MADC on Overo
Date: Sat, 30 May 2009 06:43:12 -0700
Message-ID: <5e088bd90905300643r5e2f6ef7wc789937995d243bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:64737 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbZE3NnL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 May 2009 09:43:11 -0400
Received: by qw-out-2122.google.com with SMTP id 5so4386589qwd.37
        for <linux-omap@vger.kernel.org>; Sat, 30 May 2009 06:43:12 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

diff --git a/arch/arm/mach-omap2/board-overo.c
b/arch/arm/mach-omap2/board-overo.c
index 48f9932..ce84ee7 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -340,10 +340,15 @@ static struct regulator_init_data overo_vmmc1 = {

 /* mmc2 (WLAN) and Bluetooth don't use twl4030 regulators */

+static struct twl4030_madc_platform_data overo_madc_data = {
+	.irq_line	= 1,
+};
+
 static struct twl4030_platform_data overo_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 	.gpio		= &overo_gpio_data,
+	.madc		= &overo_madc_data,
 	.usb		= &overo_usb_data,
 	.power		= GENERIC3430_T2SCRIPTS_DATA,
 	.vmmc1		= &overo_vmmc1,
