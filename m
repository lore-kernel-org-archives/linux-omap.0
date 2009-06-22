From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/12] OMAP2/3: Initialize gpio debounce register
Date: Mon, 22 Jun 2009 14:53:06 +0300
Message-ID: <20090622115306.28477.27169.stgit@localhost>
References: <20090622113422.28477.27052.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57840 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbZFVLxM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 07:53:12 -0400
In-Reply-To: <20090622113422.28477.27052.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, janboe <janboe.ye@gmail.com>

From: janboe <janboe.ye@gmail.com>

Some bootloader may initialize debounce register and this will make
dbclk not consist with the debounce register after linux kernel boot
up.

Signed-off-by: janboe <janboe.ye@gmail.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

