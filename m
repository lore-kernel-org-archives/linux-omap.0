From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] mfd: cpcap: Fix bad use of IRQ sense register
Date: Thu, 16 Mar 2017 17:36:33 -0700
Message-ID: <20170317003633.7361-5-tony@atomide.com>
References: <20170317003633.7361-1-tony@atomide.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170317003633.7361-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Sebastian Reichel <sre@kernel.org>, Tony Lindgrne <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

The cpcap INTS registers are for getting the value of the line,
not for configuring the type.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Marcel Partap <mpartap@gmx.net>
Cc: Michael Scott <michael.scott@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Tony Lindgrne <tony@atomide.com>
---
 drivers/mfd/motorola-cpcap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -115,7 +115,6 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
 		.status_base = CPCAP_REG_INT1,
 		.ack_base = CPCAP_REG_INT1,
 		.mask_base = CPCAP_REG_INTM1,
-		.type_base = CPCAP_REG_INTS1,
 		.use_ack = true,
 		.handle_reread = true,
 		.ack_invert = true,
-- 
2.11.1
