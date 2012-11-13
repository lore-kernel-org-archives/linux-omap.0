From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCHv2 4/5] staging: omap-thermal: add IRQ debugging messaging
Date: Tue, 13 Nov 2012 14:10:03 -0400
Message-ID: <1352830204-21546-5-git-send-email-eduardo.valentin@ti.com>
References: <1352830204-21546-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57157 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812Ab2KMSL5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Nov 2012 13:11:57 -0500
In-Reply-To: <1352830204-21546-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: b-cousson@ti.com, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, Enric Balletbo i Serra <eballetbo@gmail.com>

For debugging purposes, print the IRQ event for the domain being processed.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/staging/omap-thermal/omap-bandgap.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/omap-thermal/omap-bandgap.c b/drivers/staging/omap-thermal/omap-bandgap.c
index 1cae5ed..3eb726f 100644
--- a/drivers/staging/omap-thermal/omap-bandgap.c
+++ b/drivers/staging/omap-thermal/omap-bandgap.c
@@ -113,6 +113,11 @@ static irqreturn_t talert_irq_handler(int irq, void *data)
 
 		omap_bandgap_writel(bg_ptr, ctrl, tsr->bgap_mask_ctrl);
 
+		dev_dbg(bg_ptr->dev,
+			"%s: IRQ from %s sensor: hotevent %d coldevent %d\n",
+			__func__, bg_ptr->conf->sensors[i].domain,
+			t_hot, t_cold);
+
 		/* read temperature */
 		temp = omap_bandgap_readl(bg_ptr, tsr->temp_sensor_ctrl);
 		temp &= tsr->bgap_dtemp_mask;
-- 
1.7.7.1.488.ge8e1c

