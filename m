From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 43/59] omap: namespace cleanup to drivers/usb/host/ohci-omap.c
Date: Wed, 12 Nov 2008 00:57:02 +0200
Message-ID: <1226444238-14614-44-git-send-email-me@felipebalbi.com>
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
 <1226444238-14614-37-git-send-email-me@felipebalbi.com>
 <1226444238-14614-38-git-send-email-me@felipebalbi.com>
 <1226444238-14614-39-git-send-email-me@felipebalbi.com>
 <1226444238-14614-40-git-send-email-me@felipebalbi.com>
 <1226444238-14614-41-git-send-email-me@felipebalbi.com>
 <1226444238-14614-42-git-send-email-me@felipebalbi.com>
 <1226444238-14614-43-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56589 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbYKKXFH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:05:07 -0500
In-Reply-To: <1226444238-14614-43-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/host/ohci-omap.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index 91697bd..fe5a351 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -115,10 +115,10 @@ static int omap_ohci_transceiver_power(int on)
 static int omap_1510_local_bus_power(int on)
 {
 	if (on) {
-		omap_writel((1 << 1) | (1 << 0), OMAP1510_LB_MMU_CTL);
+		__raw_writel((1 << 1) | (1 << 0), OMAP1510_LB_MMU_CTL);
 		udelay(200);
 	} else {
-		omap_writel(0, OMAP1510_LB_MMU_CTL);
+		__raw_writel(0, OMAP1510_LB_MMU_CTL);
 	}
 
 	return 0;
@@ -136,24 +136,24 @@ static int omap_1510_local_bus_init(void)
 	unsigned int tlb;
 	unsigned long lbaddr, physaddr;
 
-	omap_writel((omap_readl(OMAP1510_LB_CLOCK_DIV) & 0xfffffff8) | 0x4,
+	__raw_writel((__raw_readl(OMAP1510_LB_CLOCK_DIV) & 0xfffffff8) | 0x4,
 	       OMAP1510_LB_CLOCK_DIV);
 
 	/* Configure the Local Bus MMU table */
 	for (tlb = 0; tlb < OMAP1510_LB_MEMSIZE; tlb++) {
 		lbaddr = tlb * 0x00100000 + OMAP1510_LB_OFFSET;
 		physaddr = tlb * 0x00100000 + PHYS_OFFSET;
-		omap_writel((lbaddr & 0x0fffffff) >> 22, OMAP1510_LB_MMU_CAM_H);
-		omap_writel(((lbaddr & 0x003ffc00) >> 6) | 0xc,
+		__raw_writel((lbaddr & 0x0fffffff) >> 22, OMAP1510_LB_MMU_CAM_H);
+		__raw_writel(((lbaddr & 0x003ffc00) >> 6) | 0xc,
 		       OMAP1510_LB_MMU_CAM_L);
-		omap_writel(physaddr >> 16, OMAP1510_LB_MMU_RAM_H);
-		omap_writel((physaddr & 0x0000fc00) | 0x300, OMAP1510_LB_MMU_RAM_L);
-		omap_writel(tlb << 4, OMAP1510_LB_MMU_LCK);
-		omap_writel(0x1, OMAP1510_LB_MMU_LD_TLB);
+		__raw_writel(physaddr >> 16, OMAP1510_LB_MMU_RAM_H);
+		__raw_writel((physaddr & 0x0000fc00) | 0x300, OMAP1510_LB_MMU_RAM_L);
+		__raw_writel(tlb << 4, OMAP1510_LB_MMU_LCK);
+		__raw_writel(0x1, OMAP1510_LB_MMU_LD_TLB);
 	}
 
 	/* Enable the walking table */
-	omap_writel(omap_readl(OMAP1510_LB_MMU_CTL) | (1 << 3), OMAP1510_LB_MMU_CTL);
+	__raw_writel(__raw_readl(OMAP1510_LB_MMU_CTL) | (1 << 3), OMAP1510_LB_MMU_CTL);
 	udelay(200);
 
 	return 0;
@@ -176,9 +176,9 @@ static void start_hnp(struct ohci_hcd *ohci)
 	local_irq_save(flags);
 	ohci->transceiver->state = OTG_STATE_A_SUSPEND;
 	writel (RH_PS_PSS, &ohci->regs->roothub.portstatus [port]);
-	l = omap_readl(OTG_CTRL);
+	l = __raw_readl(OTG_CTRL);
 	l &= ~OTG_A_BUSREQ;
-	omap_writel(l, OTG_CTRL);
+	__raw_writel(l, OTG_CTRL);
 	local_irq_restore(flags);
 }
 
-- 
1.6.0.2.307.gc427

