From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/2] omap: rx51: Cleanup vdds_sdi supply construction
Date: Tue, 21 Dec 2010 19:25:34 +0200
Message-ID: <1292952335-21314-2-git-send-email-jhnikula@gmail.com>
References: <1292952335-21314-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f45.google.com ([209.85.214.45]:51969 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab0LUR0B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 12:26:01 -0500
Received: by mail-bw0-f45.google.com with SMTP id 16so4816310bwz.4
        for <linux-omap@vger.kernel.org>; Tue, 21 Dec 2010 09:26:00 -0800 (PST)
In-Reply-To: <1292952335-21314-1-git-send-email-jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>

It is much more cleaner to use REGULATOR_SUPPLY macro and a device name
instead of having a reference to rx51_display_device.dev with #if defined()
guards.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index fd95ccf..768f0dc 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -359,17 +359,8 @@ static struct regulator_consumer_supply rx51_vio_supplies[] = {
 	REGULATOR_SUPPLY("DVDD", "2-0019"),
 };
 
-#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
-extern struct platform_device rx51_display_device;
-#endif
-
 static struct regulator_consumer_supply rx51_vaux1_consumers[] = {
-#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
-	{
-		.supply	= "vdds_sdi",
-		.dev	= &rx51_display_device.dev,
-	},
-#endif
+	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
 };
 
 static struct regulator_init_data rx51_vaux1 = {
-- 
1.7.2.3

