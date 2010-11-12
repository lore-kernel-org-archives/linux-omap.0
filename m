From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/4] OMAP2: Devkit8000: Fix mmc regulator failure
Date: Thu, 11 Nov 2010 17:03:23 -0800
Message-ID: <20101112010323.3827.47103.stgit@baageli.muru.com>
References: <20101112010245.3827.75329.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51054 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755401Ab0KLBDb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Nov 2010 20:03:31 -0500
In-Reply-To: <20101112010245.3827.75329.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Thomas Weber <weber@corscience.de>, linux-omap@vger.kernel.org

From: Thomas Weber <weber@corscience.de>

This patch fixes the following error:

>regulator: VMMC1: 1850 <--> 3150 mV at 3000 mV normal standby
>twl_reg twl_reg.6: can't register VMMC1, -22
>twl_reg: probe of twl_reg.6 failed with error -22

Signed-off-by: Thomas Weber <weber@corscience.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 067f437..53ac762 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -242,9 +242,6 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	mmc[0].gpio_cd = gpio + 0;
 	omap2_hsmmc_init(mmc);
 
-	/* link regulators to MMC adapters */
-	devkit8000_vmmc1_supply.dev = mmc[0].dev;
-
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 

