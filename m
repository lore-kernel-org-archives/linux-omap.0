From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 2/9] memory: emif: setup LP settings on freq update
Date: Mon, 10 Dec 2012 12:39:11 +0530
Message-ID: <1355123358-5273-3-git-send-email-lokeshvutla@ti.com>
References: <1355123358-5273-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54892 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053Ab2LJHJ3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Dec 2012 02:09:29 -0500
In-Reply-To: <1355123358-5273-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, gregkh@linuxfoundation.org, b-cousson@ti.com, lokeshvutla@ti.com, Nishanth Menon <nm@ti.com>

From: Nishanth Menon <nm@ti.com>

Program the power management shadow register on freq update
else the concept of threshold frequencies dont really matter
as the system always uses the performance mode timing for LP
which is programmed in at init time.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/memory/emif.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 8589aba..69a480d 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -815,6 +815,11 @@ static void setup_registers(struct emif_data *emif, struct emif_regs *regs)
 	writel(regs->sdram_tim2_shdw, base + EMIF_SDRAM_TIMING_2_SHDW);
 	writel(regs->phy_ctrl_1_shdw, base + EMIF_DDR_PHY_CTRL_1_SHDW);
 
+	if (emif->lpmode != EMIF_LP_MODE_DISABLE) {
+		writel(regs->pwr_mgmt_ctrl_shdw,
+		       base + EMIF_POWER_MANAGEMENT_CTRL_SHDW);
+	}
+
 	/* Settings specific for EMIF4D5 */
 	if (emif->plat_data->ip_rev != EMIF_4D5)
 		return;
-- 
1.7.9.5

