From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] mfd: cpcap: Fix bad use of IRQ sense register
Date: Mon,  3 Apr 2017 20:15:56 -0700
Message-ID: <20170404031556.5093-4-tony@atomide.com>
References: <20170404031556.5093-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170404031556.5093-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

The cpcap INTS registers are for getting the value of the line,
not for configuring the type.

Fixes: 56e1d40d3bea ("mfd: cpcap: Add minimal support")
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>
Reviewed-By: Sebastian Reichel <sre@kernel.org>
Tested-by: Sebastian Reichel <sre@kernel.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mfd/motorola-cpcap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -88,7 +88,6 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.status_base = CPCAP_REG_INT1,
 		.ack_base = CPCAP_REG_INT1,
 		.mask_base = CPCAP_REG_INTM1,
-		.type_base = CPCAP_REG_INTS1,
 		.use_ack = true,
 		.ack_invert = true,
 	},
-- 
2.12.2
