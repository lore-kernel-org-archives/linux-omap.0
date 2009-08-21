From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: [PATCH] OMAP850: GPIO: Fix typo: virtual/physical address mix up.
Date: Fri, 21 Aug 2009 21:44:51 +0100
Message-ID: <3d374d00908211344ieb66ddet673e45de8269b514@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f207.google.com ([209.85.219.207]:51883 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932390AbZHUUou (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Aug 2009 16:44:50 -0400
Received: by ewy3 with SMTP id 3so957481ewy.18
        for <linux-omap@vger.kernel.org>; Fri, 21 Aug 2009 13:44:51 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

OMAP1_MPUIO_BASE was used instead of OMAP1_MPUIO_VBASE leading to
a crash on init as soon as the address was used.

Signed-off-by: Alistair Buxton <a.j.buxton@gmail.com>
---
 arch/arm/plat-omap/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 7c70a6a..8f98c12 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -224,7 +224,7 @@ static struct gpio_bank gpio_bank_730[7] = {

 #ifdef CONFIG_ARCH_OMAP850
 static struct gpio_bank gpio_bank_850[7] = {
-	{ OMAP1_MPUIO_BASE,     INT_850_MPUIO,	    IH_MPUIO_BASE,	METHOD_MPUIO },
+	{ OMAP1_MPUIO_VBASE,    INT_850_MPUIO,	    IH_MPUIO_BASE,	METHOD_MPUIO },
 	{ OMAP850_GPIO1_BASE,  INT_850_GPIO_BANK1,  IH_GPIO_BASE,	METHOD_GPIO_850 },
 	{ OMAP850_GPIO2_BASE,  INT_850_GPIO_BANK2,  IH_GPIO_BASE +
32,	METHOD_GPIO_850 },
 	{ OMAP850_GPIO3_BASE,  INT_850_GPIO_BANK3,  IH_GPIO_BASE +
64,	METHOD_GPIO_850 },
-- 
1.6.0.4


-- 
Alistair Buxton
a.j.buxton@gmail.com
