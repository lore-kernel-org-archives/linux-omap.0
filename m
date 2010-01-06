From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] OMAP3: add missing parentheses
Date: Wed, 06 Jan 2010 23:22:12 +0100
Message-ID: <4B450D14.5060308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:52118 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932266Ab0AFWS0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 17:18:26 -0500
Received: by ewy19 with SMTP id 19so10139793ewy.21
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 14:18:24 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

`!' has a higher precedence than `&' so parentheses are required.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 arch/arm/mach-omap2/pm34xx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 81ed252..c6cc809 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -124,8 +124,8 @@ static void omap3_core_save_context(void)
 	control_padconf_off |= START_PADCONF_SAVE;
 	omap_ctrl_writel(control_padconf_off, OMAP343X_CONTROL_PADCONF_OFF);
 	/* wait for the save to complete */
-	while (!omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
-			& PADCONF_SAVE_DONE)
+	while (!(omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
+			& PADCONF_SAVE_DONE))
 		;
 	/* Save the Interrupt controller context */
 	omap_intc_save_context();
