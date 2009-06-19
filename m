From: ye janboe <janboe.ye@gmail.com>
Subject: [PATCH] initialize gpio debounce register
Date: Fri, 19 Jun 2009 11:07:02 -0500
Message-ID: <af3ea28a0906190907q718f3ac7o122bf85db2f14322@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:28622 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849AbZFSQHA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jun 2009 12:07:00 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1024867ywb.1
        for <linux-omap@vger.kernel.org>; Fri, 19 Jun 2009 09:07:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Hi,
some bootloader may initialize debounce register and this will make
dbclk not consist with the debounce register after linux kernel boot
up.

>From 8f97e5b50e50627e9e4b40f5d4fba09d750aceb1 Mon Sep 17 00:00:00 2001
From: janboe <janboe.ye@gmail.com>
Date: Fri, 19 Jun 2009 10:56:02 -0500
Subject: [PATCH] initialize gpio debounce register

Signed-off-by: janboe <janboe.ye@gmail.com>
---
 arch/arm/plat-omap/gpio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 7fd89ba..26b387c 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1585,6 +1585,7 @@ static int __init _omap_gpio_init(void)
 			__raw_writel(0x00000000, bank->base + OMAP24XX_GPIO_IRQENABLE1);
 			__raw_writel(0xffffffff, bank->base + OMAP24XX_GPIO_IRQSTATUS1);
 			__raw_writew(0x0015, bank->base + OMAP24XX_GPIO_SYSCONFIG);
+			__raw_writel(0x00000000, bank->base + OMAP24XX_GPIO_DEBOUNCE_EN);

 			/* Initialize interface clock ungated, module enabled */
 			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
