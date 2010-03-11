From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/19] omap2/3/4: mailbox: remove compiler warning
Date: Thu, 11 Mar 2010 15:48:24 -0800
Message-ID: <20100311234824.4500.50674.stgit@baageli.muru.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52448 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672Ab0CKXrB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 18:47:01 -0500
In-Reply-To: <20100311234404.4500.82861.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Remove a compiler warning in device-specific
mailbox module.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/mailbox.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 52a981c..318f363 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -430,19 +430,19 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 		if (unlikely(!res)) {
 			dev_err(&pdev->dev, "invalid irq resource\n");
 			ret = -ENODEV;
-			goto err_iva1;
+			omap_mbox_unregister(&mbox_dsp_info);
+			goto err_dsp;
 		}
 		mbox_iva_info.irq = res->start;
 		ret = omap_mbox_register(&pdev->dev, &mbox_iva_info);
-		if (ret)
-			goto err_iva1;
+		if (ret) {
+			omap_mbox_unregister(&mbox_dsp_info);
+			goto err_dsp;
+		}
 	}
 #endif
 	return 0;
 
-err_iva1:
-	omap_mbox_unregister(&mbox_dsp_info);
-
 err_dsp:
 	iounmap(mbox_base);
 	return ret;

