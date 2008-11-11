From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 36/59] omap: namespace cleanup to drivers/pcmcia/omap_cf.c
Date: Wed, 12 Nov 2008 00:56:55 +0200
Message-ID: <1226444238-14614-37-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
 <1226444238-14614-13-git-send-email-me@felipebalbi.com>
 <1226444238-14614-14-git-send-email-me@felipebalbi.com>
 <1226444238-14614-15-git-send-email-me@felipebalbi.com>
 <1226444238-14614-16-git-send-email-me@felipebalbi.com>
 <1226444238-14614-17-git-send-email-me@felipebalbi.com>
 <1226444238-14614-18-git-send-email-me@felipebalbi.com>
 <1226444238-14614-19-git-send-email-me@felipebalbi.com>
 <1226444238-14614-20-git-send-email-me@felipebalbi.com>
 <1226444238-14614-21-git-send-email-me@felipebalbi.com>
 <1226444238-14614-22-git-send-email-me@felipebalbi.com>
 <1226444238-14614-23-git-send-email-me@felipebalbi.com>
 <1226444238-14614-24-git-send-email-me@felipebalbi.com>
 <1226444238-14614-25-git-send-email-me@felipebalbi.com>
 <1226444238-14614-26-git-send-email-me@felipebalbi.com>
 <1226444238-14614-27-git-send-email-me@felipebalbi.com>
 <1226444238-14614-28-git-send-email-me@felipebalbi.com>
 <1226444238-14614-29-git-send-email-me@felipebalbi.com>
 <1226444238-14614-30-git-send-email-me@felipebalbi.com>
 <1226444238-14614-31-git-send-email-me@felipebalbi.com>
 <1226444238-14614-32-git-send-email-me@felipebalbi.com>
 <1226444238-14614-33-git-send-email-me@felipebalbi.com>
 <1226444238-14614-34-git-send-email-me@felipebalbi.com>
 <1226444238-14614-35-git-send-email-me@felipebalbi.com>
 <1226444238-14614-36-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:34829 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbYKKXKo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:10:44 -0500
In-Reply-To: <1226444238-14614-36-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/pcmcia/omap_cf.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index f373639..5600f98 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -50,7 +50,7 @@
 #define CF_CONTROL			(CF_BASE + 0x04)
 #	define	CF_CONTROL_RESET	(1 << 0)
 
-#define omap_cf_present() (!(omap_readw(CF_STATUS) & CF_STATUS_CARD_DETECT))
+#define omap_cf_present() (!(__raw_readw(CF_STATUS) & CF_STATUS_CARD_DETECT))
 
 /*--------------------------------------------------------------------------*/
 
@@ -139,11 +139,11 @@ omap_cf_set_socket(struct pcmcia_socket *sock, struct socket_state_t *s)
 		return -EINVAL;
 	}
 
-	control = omap_readw(CF_CONTROL);
+	control = __raw_readw(CF_CONTROL);
 	if (s->flags & SS_RESET)
-		omap_writew(CF_CONTROL_RESET, CF_CONTROL);
+		__raw_writew(CF_CONTROL_RESET, CF_CONTROL);
 	else
-		omap_writew(0, CF_CONTROL);
+		__raw_writew(0, CF_CONTROL);
 
 	pr_debug("%s: Vcc %d, io_irq %d, flags %04x csc %04x\n",
 		driver_name, s->Vcc, s->io_irq, s->flags, s->csc_mask);
@@ -270,7 +270,7 @@ static int __init omap_cf_probe(struct platform_device *pdev)
 	omap_cfg_reg(V10_1610_CF_IREQ);
 	omap_cfg_reg(W10_1610_CF_RESET);
 
-	omap_writew(~(1 << seg), CF_CFG);
+	__raw_writew(~(1 << seg), CF_CFG);
 
 	pr_info("%s: cs%d on irq %d\n", driver_name, seg, irq);
 
@@ -279,15 +279,15 @@ static int __init omap_cf_probe(struct platform_device *pdev)
 	 * CF/PCMCIA variants...
 	 */
 	pr_debug("%s: cs%d, previous ccs %08x acs %08x\n", driver_name,
-		seg, omap_readl(EMIFS_CCS(seg)), omap_readl(EMIFS_ACS(seg)));
-	omap_writel(0x0004a1b3, EMIFS_CCS(seg));	/* synch mode 4 etc */
-	omap_writel(0x00000000, EMIFS_ACS(seg));	/* OE hold/setup */
+		seg, __raw_readl(EMIFS_CCS(seg)), omap_readl(EMIFS_ACS(seg)));
+	__raw_writel(0x0004a1b3, EMIFS_CCS(seg));	/* synch mode 4 etc */
+	__raw_writel(0x00000000, EMIFS_ACS(seg));	/* OE hold/setup */
 
 	/* CF uses armxor_ck, which is "always" available */
 
 	pr_debug("%s: sts %04x cfg %04x control %04x %s\n", driver_name,
-		omap_readw(CF_STATUS), omap_readw(CF_CFG),
-		omap_readw(CF_CONTROL),
+		__raw_readw(CF_STATUS), omap_readw(CF_CFG),
+		__raw_readw(CF_CONTROL),
 		omap_cf_present() ? "present" : "(not present)");
 
 	cf->socket.owner = THIS_MODULE;
-- 
1.6.0.2.307.gc427

