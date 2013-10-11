From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH] pinctrl: single: call pcs_soc->rearm() whenever IRQ mask is changed
Date: Fri, 11 Oct 2013 19:13:16 +0300
Message-ID: <1381507996-15021-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56789 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756070Ab3JKQNn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 12:13:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linus.walleij@linaro.org, grygorii.strashko@ti.com, peter.ujfalusi@ti.com, haojian.zhuang@linaro.org, bcousson@baylibre.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

On OMAPs the IO ring must be rearmed each time the pad wakeup
configuration is changed. So call pcs_soc->rearm() from
pcs_irq_set().

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/pinctrl/pinctrl-single.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index c2aada7..1800e47 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1604,6 +1604,9 @@ static inline void pcs_irq_set(struct pcs_soc_data *pcs_soc,
 		pcs->write(mask, pcswi->reg);
 		raw_spin_unlock(&pcs->lock);
 	}
+
+	if (pcs_soc->rearm)
+		pcs_soc->rearm();
 }
 
 /**
@@ -1626,8 +1629,6 @@ static void pcs_irq_unmask(struct irq_data *d)
 	struct pcs_soc_data *pcs_soc = irq_data_get_irq_chip_data(d);
 
 	pcs_irq_set(pcs_soc, d->irq, true);
-	if (pcs_soc->rearm)
-		pcs_soc->rearm();
 }
 
 /**
-- 
1.7.4.1

