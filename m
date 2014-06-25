From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 4/7] mailbox/omap: simplify the fifo assignment by using macros
Date: Tue, 24 Jun 2014 19:43:40 -0500
Message-ID: <1403657023-53897-5-git-send-email-s-anna@ti.com>
References: <1403657023-53897-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33831 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920AbaFYAot (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 20:44:49 -0400
In-Reply-To: <1403657023-53897-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

The OMAP mailbox IP has two different type of interrupt configuration
registers between OMAP4+ SoCs and OMAP2/3 SoCs. Simplify the current
interrupt configuration by using a single macro that translates the
two variants.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/mailbox-omap2.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/mailbox/mailbox-omap2.c b/drivers/mailbox/mailbox-omap2.c
index b44e3bc..2c463d6 100644
--- a/drivers/mailbox/mailbox-omap2.c
+++ b/drivers/mailbox/mailbox-omap2.c
@@ -25,13 +25,21 @@
 #define MAILBOX_MESSAGE(m)		(0x040 + 4 * (m))
 #define MAILBOX_FIFOSTATUS(m)		(0x080 + 4 * (m))
 #define MAILBOX_MSGSTATUS(m)		(0x0c0 + 4 * (m))
-#define MAILBOX_IRQSTATUS(u)		(0x100 + 8 * (u))
-#define MAILBOX_IRQENABLE(u)		(0x104 + 8 * (u))
+
+#define OMAP2_MAILBOX_IRQSTATUS(u)	(0x100 + 8 * (u))
+#define OMAP2_MAILBOX_IRQENABLE(u)	(0x104 + 8 * (u))
 
 #define OMAP4_MAILBOX_IRQSTATUS(u)	(0x104 + 0x10 * (u))
 #define OMAP4_MAILBOX_IRQENABLE(u)	(0x108 + 0x10 * (u))
 #define OMAP4_MAILBOX_IRQENABLE_CLR(u)	(0x10c + 0x10 * (u))
 
+#define MAILBOX_IRQSTATUS(type, u)	(type ? OMAP4_MAILBOX_IRQSTATUS(u) : \
+						OMAP2_MAILBOX_IRQSTATUS(u))
+#define MAILBOX_IRQENABLE(type, u)	(type ? OMAP4_MAILBOX_IRQENABLE(u) : \
+						OMAP2_MAILBOX_IRQENABLE(u))
+#define MAILBOX_IRQDISABLE(type, u)	(type ? OMAP4_MAILBOX_IRQENABLE_CLR(u) \
+						: OMAP2_MAILBOX_IRQENABLE(u))
+
 #define MAILBOX_IRQ_NEWMSG(m)		(1 << (2 * (m)))
 #define MAILBOX_IRQ_NOTFULL(m)		(1 << (2 * (m) + 1))
 
@@ -227,6 +235,7 @@ static int omap2_mbox_probe(struct platform_device *pdev)
 	struct omap_mbox2_priv *priv, *privblk;
 	struct omap_mbox_pdata *pdata = pdev->dev.platform_data;
 	struct omap_mbox_dev_info *info;
+	u32 intr_type;
 	int i;
 
 	if (!pdata || !pdata->info_cnt || !pdata->info) {
@@ -251,6 +260,7 @@ static int omap2_mbox_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	info = pdata->info;
+	intr_type = pdata->intr_type;
 	mbox = mboxblk;
 	priv = privblk;
 	for (i = 0; i < pdata->info_cnt; i++, info++, priv++) {
@@ -260,17 +270,10 @@ static int omap2_mbox_probe(struct platform_device *pdev)
 		priv->rx_fifo.msg_stat =  MAILBOX_MSGSTATUS(info->rx_id);
 		priv->notfull_bit = MAILBOX_IRQ_NOTFULL(info->tx_id);
 		priv->newmsg_bit = MAILBOX_IRQ_NEWMSG(info->rx_id);
-		if (pdata->intr_type) {
-			priv->irqenable = OMAP4_MAILBOX_IRQENABLE(info->usr_id);
-			priv->irqstatus = OMAP4_MAILBOX_IRQSTATUS(info->usr_id);
-			priv->irqdisable =
-				OMAP4_MAILBOX_IRQENABLE_CLR(info->usr_id);
-		} else {
-			priv->irqenable = MAILBOX_IRQENABLE(info->usr_id);
-			priv->irqstatus = MAILBOX_IRQSTATUS(info->usr_id);
-			priv->irqdisable = MAILBOX_IRQENABLE(info->usr_id);
-		}
-		priv->intr_type = pdata->intr_type;
+		priv->irqenable = MAILBOX_IRQENABLE(intr_type, info->usr_id);
+		priv->irqstatus = MAILBOX_IRQSTATUS(intr_type, info->usr_id);
+		priv->irqdisable = MAILBOX_IRQDISABLE(intr_type, info->usr_id);
+		priv->intr_type = intr_type;
 
 		mbox->priv = priv;
 		mbox->name = info->name;
-- 
2.0.0

