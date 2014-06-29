From: Andre Heider <a.heider@gmail.com>
Subject: [PATCH 08/13] uio: uio_pruss: make the UIO SRAM memory region optional
Date: Sun, 29 Jun 2014 18:21:42 +0200
Message-ID: <1404058907-21112-9-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:36017 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbaF2QWF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 29 Jun 2014 12:22:05 -0400
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Skip creating the UIO SRAM memory region if no SRAM genalloc has been
passed along. This will be the case for am33xx SoCs.

The order of the memory regions is not changed for already supported
platforms. That is to keep the current behavior for existing userland
drivers.

For am33x this gives one memory region less. This behavior is in line
with downstream patches and userland driver support for this SoC family.

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 drivers/uio/uio_pruss.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index 50ff206..afaf726 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -111,7 +111,7 @@ static int pruss_probe(struct platform_device *pdev)
 	struct uio_pruss_dev *gdev;
 	struct resource *regs_prussio;
 	struct device *dev = &pdev->dev;
-	int ret = -ENODEV, cnt = 0;
+	int ret = -ENODEV, cnt = 0, i;
 	struct uio_pruss_pdata *pdata = dev_get_platdata(dev);
 	dma_addr_t ddr_paddr;
 
@@ -160,17 +160,24 @@ static int pruss_probe(struct platform_device *pdev)
 	gdev->hostirq_start = platform_get_irq(pdev, 0);
 
 	for (cnt = 0, p = gdev->info; cnt < MAX_PRUSS_EVT; cnt++, p++) {
-		p->mem[0].addr = regs_prussio->start;
-		p->mem[0].size = resource_size(regs_prussio);
-		p->mem[0].memtype = UIO_MEM_PHYS;
-
-		p->mem[1].addr = gdev->sram_paddr;
-		p->mem[1].size = sram_pool_sz;
-		p->mem[1].memtype = UIO_MEM_PHYS;
+		i = 0;
+
+		p->mem[i].addr = regs_prussio->start;
+		p->mem[i].size = resource_size(regs_prussio);
+		p->mem[i].memtype = UIO_MEM_PHYS;
+		i++;
+
+		if (gdev->sram_vaddr) {
+			p->mem[i].addr = gdev->sram_paddr;
+			p->mem[i].size = sram_pool_sz;
+			p->mem[i].memtype = UIO_MEM_PHYS;
+			i++;
+		}
 
-		p->mem[2].addr = ddr_paddr;
-		p->mem[2].size = extram_pool_sz;
-		p->mem[2].memtype = UIO_MEM_PHYS;
+		p->mem[i].addr = ddr_paddr;
+		p->mem[i].size = extram_pool_sz;
+		p->mem[i].memtype = UIO_MEM_PHYS;
+		i++;
 
 		p->name = kasprintf(GFP_KERNEL, "pruss_evt%d", cnt);
 		p->version = DRV_VERSION;
-- 
2.0.0

