From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/5] omap: Stalker board: switch over to gpio_set_debounce
Date: Tue, 08 Jun 2010 15:03:25 +0300
Message-ID: <20100608120325.24902.42622.stgit@baageli.muru.com>
References: <20100608120104.24902.36055.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57232 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581Ab0FHMDZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jun 2010 08:03:25 -0400
In-Reply-To: <20100608120104.24902.36055.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

With latest linus's tip, omap3_defconfig is broken.

 LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/arm/mach-omap2/built-in.o: In function `ads7846_dev_init':
linux-2.6/arch/arm/mach-omap2/board-omap3stalker.c:542: undefined reference to `omap_set_gpio_debounce'
linux-2.6/arch/arm/mach-omap2/board-omap3stalker.c:543: undefined reference to `omap_set_gpio_debounce_time'
make: *** [.tmp_vmlinux1] Error 1

>From the commit 48feb337475a ( arm: omap: switch over to gpio_set_debounce),
board-omap3stalker.c seems to be missed out or got merged later.
The patch was to remove omap-specific implementations for gpio debouncing
in favor of gpiolib function.

Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3stalker.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index f848ba8..a04cffd 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -538,9 +538,7 @@ static void ads7846_dev_init(void)
 		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
 
 	gpio_direction_input(OMAP3_STALKER_TS_GPIO);
-
-	omap_set_gpio_debounce(OMAP3_STALKER_TS_GPIO, 1);
-	omap_set_gpio_debounce_time(OMAP3_STALKER_TS_GPIO, 0xa);
+	gpio_set_debounce(OMAP3_STALKER_TS_GPIO, 310);
 }
 
 static int ads7846_get_pendown_state(void)

