From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 4/5] staging: omap-thermal: add IRQ debugging messaging
Date: Tue, 13 Nov 2012 11:43:21 -0400
Message-ID: <1352821402-13458-5-git-send-email-eduardo.valentin@ti.com>
References: <1352821402-13458-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352821402-13458-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: b-cousson@ti.com, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-omap@vger.kernel.org

For debugging purposes, print the IRQ event for the domain being processed.

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-bandgap.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index 1cae5ed..c5f39ec 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -113,6 +113,11 @@ static irqreturn_t talert_irq_handler(int irq, void *data)
 
 		omap_bandgap_writel(bg_ptr, ctrl, tsr->bgap_mask_ctrl);
 
+		dev_dbg(bg_ptr->dev,
+			"%s: IRQ from %s sensor: hotevent %d coldevent %d\n",
+			__func__, bg_ptr->pdata->sensors[i].domain,
+			t_hot, t_cold);
+
 		/* read temperature */
 		temp = omap_bandgap_readl(bg_ptr, tsr->temp_sensor_ctrl);
 		temp &= tsr->bgap_dtemp_mask;
-- 
1.7.7.1.488.ge8e1c
