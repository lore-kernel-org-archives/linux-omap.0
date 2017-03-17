From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/4] mfd: cpcap: Use ack_invert interrupts
Date: Thu, 16 Mar 2017 17:36:32 -0700
Message-ID: <20170317003633.7361-4-tony@atomide.com>
References: <20170317003633.7361-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170317003633.7361-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

We should use ack_invert as the int_read_and_clear() in the Motorola
kernel tree does "ireg_val & ~mreg_val" before writing to the mask
register.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/motorola-cpcap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -97,6 +97,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.mask_base = CPCAP_REG_MIM1,
 		.use_ack = true,
 		.handle_reread = true,
+		.ack_invert = true,
 	},
 	{
 		.name = "cpcap-m2",
@@ -106,6 +107,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.mask_base = CPCAP_REG_MIM2,
 		.use_ack = true,
 		.handle_reread = true,
+		.ack_invert = true,
 	},
 	{
 		.name = "cpcap1-4",
@@ -116,6 +118,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.type_base = CPCAP_REG_INTS1,
 		.use_ack = true,
 		.handle_reread = true,
+		.ack_invert = true,
 	},
 };
 
-- 
2.11.1
