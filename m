From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/14] CF: Change omap_cf.c to use  omap_readw/writew instead of __REG for multi-omap
Date: Tue, 27 May 2008 21:20:06 -0700
Message-ID: <1211948418-16455-3-git-send-email-tony@atomide.com>
References: multi-omap-2008-05-27-212014
 <1211948418-16455-1-git-send-email-tony@atomide.com>
 <1211948418-16455-2-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:49604 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055AbYE1EUW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 May 2008 00:20:22 -0400
In-Reply-To: <1211948418-16455-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Change omap_cf.c to use  omap_readw/writew instead of __REG for multi-omap

Signed-off-by: Tony Lindren <tony@atomide.com>
---
 drivers/pcmcia/omap_cf.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 46314b4..a7d9e4b 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -38,19 +38,19 @@
 #define	CF_BASE	0xfffe2800
 
 /* status; read after IRQ */
-#define CF_STATUS_REG		__REG16(CF_BASE + 0x00)
+#define CF_STATUS			(CF_BASE + 0x00)
 #	define	CF_STATUS_BAD_READ	(1 << 2)
 #	define	CF_STATUS_BAD_WRITE	(1 << 1)
 #	define	CF_STATUS_CARD_DETECT	(1 << 0)
 
 /* which chipselect (CS0..CS3) is used for CF (active low) */
-#define CF_CFG_REG		__REG16(CF_BASE + 0x02)
+#define CF_CFG				(CF_BASE + 0x02)
 
 /* card reset */
-#define CF_CONTROL_REG		__REG16(CF_BASE + 0x04)
+#define CF_CONTROL			(CF_BASE + 0x04)
 #	define	CF_CONTROL_RESET	(1 << 0)
 
-#define omap_cf_present() (!(CF_STATUS_REG & CF_STATUS_CARD_DETECT))
+#define omap_cf_present() (!(omap_readw(CF_STATUS) & CF_STATUS_CARD_DETECT))
 
 /*--------------------------------------------------------------------------*/
 
@@ -139,11 +139,11 @@ omap_cf_set_socket(struct pcmcia_socket *sock, struct socket_state_t *s)
 		return -EINVAL;
 	}
 
-	control = CF_CONTROL_REG;
+	control = omap_readw(CF_CONTROL);
 	if (s->flags & SS_RESET)
-		CF_CONTROL_REG = CF_CONTROL_RESET;
+		omap_writew(CF_CONTROL_RESET, CF_CONTROL);
 	else
-		CF_CONTROL_REG = 0;
+		omap_writew(0, CF_CONTROL);
 
 	pr_debug("%s: Vcc %d, io_irq %d, flags %04x csc %04x\n",
 		driver_name, s->Vcc, s->io_irq, s->flags, s->csc_mask);
@@ -270,7 +270,7 @@ static int __init omap_cf_probe(struct platform_device *pdev)
 	omap_cfg_reg(V10_1610_CF_IREQ);
 	omap_cfg_reg(W10_1610_CF_RESET);
 
-	CF_CFG_REG = ~(1 << seg);
+	omap_writew(~(1 << seg), CF_CFG);
 
 	pr_info("%s: cs%d on irq %d\n", driver_name, seg, irq);
 
@@ -286,7 +286,8 @@ static int __init omap_cf_probe(struct platform_device *pdev)
 	/* CF uses armxor_ck, which is "always" available */
 
 	pr_debug("%s: sts %04x cfg %04x control %04x %s\n", driver_name,
-		CF_STATUS_REG, CF_CFG_REG, CF_CONTROL_REG,
+		omap_readw(CF_STATUS), omap_readw(CF_CFG),
+		omap_readw(CF_CONTROL),
 		omap_cf_present() ? "present" : "(not present)");
 
 	cf->socket.owner = THIS_MODULE;
-- 
1.5.3.6

