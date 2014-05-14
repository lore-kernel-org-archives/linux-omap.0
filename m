From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH 1/1] ARM: OMAP2+: enable LEDS class support
Date: Wed, 14 May 2014 13:45:05 +0200
Message-ID: <1400067905-20786-1-git-send-email-javier@dowhile0.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33402 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261AbaENLpX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 07:45:23 -0400
Received: by mail-wi0-f171.google.com with SMTP id hm4so7838770wib.10
        for <linux-omap@vger.kernel.org>; Wed, 14 May 2014 04:45:21 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: AnilKumar Ch <anilkumar@ti.com>, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier@dowhile0.org>

Commit 5610b8ede ("ARM: OMAP2+: AM33XX: omap2plus_defconfig:
Add support for few drivers") added support for different
drivers including GPIO based leds.

But LEDS_GPIO config option depends on LEDS_CLASS which was
not included so GPIO leds option is not selected. Adding as
built-in option since the related options are built-in too.

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a4e8d01..0a70170 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -239,6 +239,7 @@ CONFIG_SDIO_UART=y
 CONFIG_MMC_OMAP=y
 CONFIG_MMC_OMAP_HS=y
 CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
-- 
2.0.0.rc0

