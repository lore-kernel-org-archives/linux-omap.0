From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/12] OMAP2/3: omap mailbox: platform_get_irq() error ignored
Date: Mon, 22 Jun 2009 14:43:42 +0300
Message-ID: <20090622114342.28477.80621.stgit@localhost>
References: <20090622113422.28477.27052.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59088 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756574AbZFVLns (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 07:43:48 -0400
In-Reply-To: <20090622113422.28477.27052.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org, Roel Kluin <roel.kluin@gmail.com>

From: Roel Kluin <roel.kluin@gmail.com>

platform_get_irq may return -ENXIO. but struct omap_mbox mbox_dsp_info.irq
is unsigned, so the error was not noticed.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mailbox.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index fd5b8a5..6f71f37 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -282,12 +282,12 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* DSP or IVA2 IRQ */
-	mbox_dsp_info.irq = platform_get_irq(pdev, 0);
-	if (mbox_dsp_info.irq < 0) {
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
 		dev_err(&pdev->dev, "invalid irq resource\n");
-		ret = -ENODEV;
 		goto err_dsp;
 	}
+	mbox_dsp_info.irq = ret;
 
 	ret = omap_mbox_register(&pdev->dev, &mbox_dsp_info);
 	if (ret)

