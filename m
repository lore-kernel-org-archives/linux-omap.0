From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] mfd: cpcap: Fix interrupt to use level interrupt
Date: Mon,  3 Apr 2017 20:15:54 -0700
Message-ID: <20170404031556.5093-2-tony@atomide.com>
References: <20170404031556.5093-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170404031556.5093-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

I made a mistake assuming the device tree configuration for interrupt
triggering was somehow passed to the SPI device but it's not.

In the Motorola Linux kernel tree CPCAP PMIC is configured as a rising
edge triggered interrupt, but then then it's interrupt handler keeps
looping until the GPIO line goes down. So the CPCAP interrupt is clearly
a level interrupt and not an edge interrupt.

Earlier when I tried to configure it as level interrupt using the
device tree, I did not account that the triggering only gets passed
to the SPI core and it also needs to be specified in the CPCAP driver
when we do devm_regmap_add_irq_chip().

Fixes: 56e1d40d3bea ("mfd: cpcap: Add minimal support")
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/motorola-cpcap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -126,7 +126,7 @@ static int cpcap_init_irq_chip(struct cpcap_ddata *cpcap, int irq_chip,
 
 	ret = devm_regmap_add_irq_chip(&cpcap->spi->dev, cpcap->regmap,
 				       cpcap->spi->irq,
-				       IRQF_TRIGGER_RISING |
+				       irq_get_trigger_type(cpcap->spi->irq) |
 				       IRQF_SHARED, -1,
 				       chip, &cpcap->irqdata[irq_chip]);
 	if (ret) {
-- 
2.12.2
