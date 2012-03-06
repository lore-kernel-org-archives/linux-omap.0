From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] gpio/omap: Fix section warning for omap_mpuio_alloc_gc()
Date: Tue, 6 Mar 2012 13:26:06 -0800
Message-ID: <20120306212605.GY12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26581 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756752Ab2CFV0I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Mar 2012 16:26:08 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Tony Lindgren <tony@atomide.com>
Date: Mon, 5 Mar 2012 15:32:38 -0800
Subject: [PATCH] gpio/omap: Fix section warning for omap_mpuio_alloc_gc()

Make omap_mpuio_alloc_gc() __devinit as omap_gpio_chip_init()
is __devinit. Otherwise we get:

WARNING: vmlinux.o(.devinit.text+0xa10): Section mismatch in reference
from the function omap_gpio_chip_init() to the function .init.text:omap_mpuio_alloc_gc()
The function __devinit omap_gpio_chip_init() references
a function __init omap_mpuio_alloc_gc().
If omap_mpuio_alloc_gc is only used by omap_gpio_chip_init then
annotate omap_mpuio_alloc_gc with a matching annotation.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1081,7 +1081,7 @@ static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
 	}
 }
 
-static __init void
+static __devinit void
 omap_mpuio_alloc_gc(struct gpio_bank *bank, unsigned int irq_start,
 		    unsigned int num)
 {
