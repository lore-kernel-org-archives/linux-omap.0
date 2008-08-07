From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Thu, 7 Aug 2008 22:59:26 +0100
Message-ID: <20080807215926.GJ5737@flint.arm.linux.org.uk>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com> <1218016428.25235.11.camel@pc1117.cambridge.arm.com> <13B9B4C6EF24D648824FF11BE89671620361F4E504@dlee02.ent.ti.com> <20080807073035.GA10255@flint.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE89671620361FBB4FB@dlee02.ent.ti.com> <20080807192531.GF5737@flint.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE89671620361FBB662@dlee02.ent.ti.com> <20080807212033.GH5737@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51892 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbYHGV7n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 17:59:43 -0400
Content-Disposition: inline
In-Reply-To: <20080807212033.GH5737@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Thu, Aug 07, 2008 at 10:20:33PM +0100, Russell King - ARM Linux wrote:
> In the case of arch/arm/mach-omap2/irq.c, reading the INTC_REVISION
> reg after masking should be a sufficient solution.

And here's a patch to do exactly that.

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 9ef15b3..27610b1 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -48,6 +48,7 @@ static struct omap_irq_bank {
 static void omap_ack_irq(unsigned int irq)
 {
 	__raw_writel(0x1, irq_banks[0].base_reg + INTC_CONTROL);
+	__raw_readl(irq_banks[0].base_reg + INTC_REVISION);
 }
 
 static void omap_mask_irq(unsigned int irq)
@@ -61,6 +62,7 @@ static void omap_mask_irq(unsigned int irq)
 	}
 
 	__raw_writel(1 << irq, irq_banks[0].base_reg + INTC_MIR_SET0 + offset);
+	__raw_readl(irq_banks[0].base_reg + INTC_REVISION);
 }
 
 static void omap_unmask_irq(unsigned int irq)

