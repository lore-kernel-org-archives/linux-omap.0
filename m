From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] pinctrl: single: dra7: remove PCS_QUIRK_SHARED_IRQ
Date: Mon, 6 Jul 2015 18:11:50 +0300
Message-ID: <1436195510-23880-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On DRA7 there is one pinctrl domain (dra7_pmx_core) and
PRCM wake-up IRQ is not shared, so remove quirk.

Cc: Nishanth Menon <nm@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Fixes: 31320beaa3d3 ('pinctrl: single: Add DRA7 pinctrl compatibility')
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/pinctrl/pinctrl-single.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 0b8d480..9b24b343 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1983,7 +1983,6 @@ static const struct pcs_soc_data pinctrl_single_omap_wkup = {
 };
 
 static const struct pcs_soc_data pinctrl_single_dra7 = {
-	.flags = PCS_QUIRK_SHARED_IRQ,
 	.irq_enable_mask = (1 << 24),	/* WAKEUPENABLE */
 	.irq_status_mask = (1 << 25),	/* WAKEUPEVENT */
 };
-- 
2.4.5

