From: Mircea Gherzan <mgherzan@gmail.com>
Subject: [PATCH RESEND] ARM: OMAP: enable Bluetooth on the PandaBoard
Date: Thu, 23 Feb 2012 18:52:57 +0100
Message-ID: <1330019577-2106-1-git-send-email-mgherzan@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61958 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223Ab2BWRxF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 12:53:05 -0500
Received: by eekc4 with SMTP id c4so559376eek.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 09:53:04 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mgherzan@gmail.com

The PandaBoard features a Texas Instruments WiLink7 Bluetooth
chip, supported by the "btwilink" driver.

Signed-off-by: Mircea Gherzan <mgherzan@gmail.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 28fc271..b1d74d6 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -91,9 +91,15 @@ static struct platform_device leds_gpio = {
 	},
 };
 
+static struct platform_device btwilink_device = {
+	.name	= "btwilink",
+	.id	= -1,
+};
+
 static struct platform_device *panda_devices[] __initdata = {
 	&leds_gpio,
 	&wl1271_device,
+	&btwilink_device,
 };
 
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
-- 
1.7.9.1

