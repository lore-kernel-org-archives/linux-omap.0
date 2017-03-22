From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] mfd: cpcap: Use handle_reread flag for interrupts
Date: Wed, 22 Mar 2017 10:10:50 -0700
Message-ID: <20170322171052.7006-3-tony@atomide.com>
References: <20170322171052.7006-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170322171052.7006-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org

On CPCAP we need to keep reading interrupts until there are no
more interrupts. Otherwise the PMIC interrupt to the SoC will at
some point stop toggling. This seems to happen because new CPCAP
device interrupts show up while we're handling.

Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Lee Jones <lee.jones@linaro.org>
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
+		.handle_reread = true,
 	},
 	{
 		.name = "cpcap-m2",
@@ -79,6 +80,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.ack_base = CPCAP_REG_MI2,
 		.mask_base = CPCAP_REG_MIM2,
 		.use_ack = true,
+		.handle_reread = true,
 	},
 	{
 		.name = "cpcap1-4",
@@ -88,6 +90,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.mask_base = CPCAP_REG_INTM1,
 		.type_base = CPCAP_REG_INTS1,
 		.use_ack = true,
+		.handle_reread = true,
 	},
 };
 
-- 
2.11.1
