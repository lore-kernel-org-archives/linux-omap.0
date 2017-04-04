From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] mfd: cpcap: Use ack_invert interrupts
Date: Mon,  3 Apr 2017 20:15:55 -0700
Message-ID: <20170404031556.5093-3-tony@atomide.com>
References: <20170404031556.5093-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170404031556.5093-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

We should use ack_invert as the int_read_and_clear() in the Motorola
kernel tree does "ireg_val & ~mreg_val" before writing to the mask
register.

Fixes: 56e1d40d3bea ("mfd: cpcap: Add minimal support")
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Tested-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/motorola-cpcap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -71,6 +71,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.ack_base = CPCAP_REG_MI1,
 		.mask_base = CPCAP_REG_MIM1,
 		.use_ack = true,
+		.ack_invert = true,
 	},
 	{
 		.name = "cpcap-m2",
@@ -79,6 +80,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.ack_base = CPCAP_REG_MI2,
 		.mask_base = CPCAP_REG_MIM2,
 		.use_ack = true,
+		.ack_invert = true,
 	},
 	{
 		.name = "cpcap1-4",
@@ -88,6 +90,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.mask_base = CPCAP_REG_INTM1,
 		.type_base = CPCAP_REG_INTS1,
 		.use_ack = true,
+		.ack_invert = true,
 	},
 };
 
-- 
2.12.2
