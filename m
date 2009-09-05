From: Angelo Arrifano <miknix@gmail.com>
Subject: [PATCH 2/3] [ARM] omap850: Fix a OMAP_MPUIO_VBASE typo.
Date: Sat, 05 Sep 2009 01:02:14 +0100
Message-ID: <4AA1AA86.9060508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:51573 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934011AbZIDX5j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 19:57:39 -0400
Received: by fxm17 with SMTP id 17so1001181fxm.37
        for <linux-omap@vger.kernel.org>; Fri, 04 Sep 2009 16:57:41 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Zebediah C. McClure" <zmc@lurian.net>

This was crashing omap850 devices.

Reported-by:
  Alistair Buxton <a.j.buxton@gmail.com>

Signed-off-by: Angelo Arrifano <miknix@gmail.com>
---
 arch/arm/plat-omap/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 7c70a6a..66c7006 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -224,7 +224,7 @@ static struct gpio_bank gpio_bank_730[7] = {

 #ifdef CONFIG_ARCH_OMAP850
 static struct gpio_bank gpio_bank_850[7] = {
-	{ OMAP1_MPUIO_BASE,     INT_850_MPUIO,	    IH_MPUIO_BASE,	METHOD_MPUIO },
+	{ OMAP1_MPUIO_VBASE,     INT_850_MPUIO,	    IH_MPUIO_BASE,	METHOD_MPUIO },
 	{ OMAP850_GPIO1_BASE,  INT_850_GPIO_BANK1,  IH_GPIO_BASE,
METHOD_GPIO_850 },
 	{ OMAP850_GPIO2_BASE,  INT_850_GPIO_BANK2,  IH_GPIO_BASE + 32,
METHOD_GPIO_850 },
 	{ OMAP850_GPIO3_BASE,  INT_850_GPIO_BANK3,  IH_GPIO_BASE + 64,
METHOD_GPIO_850 },
-- 
1.6.3.3

