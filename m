From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v4 05/12] ARM: OMAP2+: GPMC: resolve type-conversion warning
 from sparse
Date: Tue, 10 Apr 2012 18:35:42 -0600
Message-ID: <20120411003538.27059.57206.stgit@dusk>
References: <20120411003454.27059.37500.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43927 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759911Ab2DKAiU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 20:38:20 -0400
In-Reply-To: <20120411003454.27059.37500.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

arch/arm/mach-omap2/gpmc.c passes a return value from ioremap() as the
fifth argument to request_irq() without casting it.  This causes
sparse to generate the following warning:

arch/arm/mach-omap2/gpmc.c:759:63: warning: incorrect type in argument 5 (different address spaces)
arch/arm/mach-omap2/gpmc.c:759:63:    expected void *dev
arch/arm/mach-omap2/gpmc.c:759:63:    got void [noderef] <asn:2>*static [toplevel] [assigned] gpmc_base

It turns out that it's not necessary to pass this.  gpmc_base is a
file-scoped static variable, the ISR is located in the same file ... and
the ISR doesn't even touch the passed-in variable.  So, just replace it with
NULL in request_irq().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/gpmc.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 00d5108..580e684 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -755,8 +755,7 @@ static int __init gpmc_init(void)
 		irq++;
 	}
 
-	ret = request_irq(gpmc_irq,
-			gpmc_handle_irq, IRQF_SHARED, "gpmc", gpmc_base);
+	ret = request_irq(gpmc_irq, gpmc_handle_irq, IRQF_SHARED, "gpmc", NULL);
 	if (ret)
 		pr_err("gpmc: irq-%d could not claim: err %d\n",
 						gpmc_irq, ret);


