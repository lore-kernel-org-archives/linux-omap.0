From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 01/18] OMAP1: GPIO: Fix mpuio_init() call
Date: Fri, 22 Apr 2011 16:38:15 +0530
Message-ID: <1303470512-19671-2-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38699 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab1DVLE7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Apr 2011 07:04:59 -0400
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

In OMAP1 GPIO, MPUIO bank's initialization is called as part of
omap_gpio_sysinit() which is an "arch_initcall". mpuio_init()
relies on the gpio_bank pointer of MPUIO bank whose memory is
allocated only during omap_gpio_probe(). Hence move mpuio_init()
call as part of probe after the gpio_bank pointer is initialized.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index d2adcdd..9164bd4 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1697,6 +1697,8 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		ret = init_gpio_info(pdev);
 		if (ret)
 			return ret;
+		if (cpu_class_is_omap1())
+			mpuio_init();
 	}
 
 	id = pdev->id;
@@ -2110,8 +2112,6 @@ static int __init omap_gpio_sysinit(void)
 {
 	int ret = 0;
 
-	mpuio_init();
-
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
 	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
 		if (ret == 0) {
-- 
1.7.1

