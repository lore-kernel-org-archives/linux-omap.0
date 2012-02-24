From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/7] ARM: OMAP: Fix devexit for dma when CONFIG_HOTPLUG is
 not set
Date: Thu, 23 Feb 2012 16:54:15 -0800
Message-ID: <20120224005415.16794.60826.stgit@kaulin.local>
References: <20120224005324.16794.73852.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48450 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756470Ab2BXAyQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 19:54:16 -0500
In-Reply-To: <20120224005324.16794.73852.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Otherwise we get:

`omap_system_dma_remove' referenced in section `.data' of arch/arm/plat-omap/built-in.o:
defined in discarded section `.devexit.text' of arch/arm/plat-omap/built-in.o

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 002fb4d..cb856fe 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2125,7 +2125,7 @@ static int __devexit omap_system_dma_remove(struct platform_device *pdev)
 
 static struct platform_driver omap_system_dma_driver = {
 	.probe		= omap_system_dma_probe,
-	.remove		= omap_system_dma_remove,
+	.remove		= __devexit_p(omap_system_dma_remove),
 	.driver		= {
 		.name	= "omap_dma_system"
 	},

