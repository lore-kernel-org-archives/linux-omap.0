From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM: v3.13-rc1: USB regression
Date: Mon, 25 Nov 2013 17:18:53 +0000
Message-ID: <20131125171853.GF25039@n2100.arm.linux.org.uk>
References: <20131124222247.GC24645@blackmetal.musicnaut.iki.fi> <20131124224359.GE25039@n2100.arm.linux.org.uk> <20131125163302.GD24645@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43386 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684Ab3KYRTr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Nov 2013 12:19:47 -0500
Content-Disposition: inline
In-Reply-To: <20131125163302.GD24645@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, linux-omap@vger.kernel.org

On Mon, Nov 25, 2013 at 06:33:02PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Sun, Nov 24, 2013 at 10:43:59PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Nov 25, 2013 at 12:22:47AM +0200, Aaro Koskinen wrote:
> > > [   33.967324] ohci ohci: Coherent DMA mask 0xffffffff (pfn 0xe0000-0xe0000) covers a smaller range of system memory than the DMA zone pfn 0x0-0x100000
> > > 
> > > I bisected this to 4dcfa60071b3d23f0181f27d8519f12e37cefbb9 (ARM: DMA-API:
> > > better handing of DMA masks for coherent allocations). Reverting that
> > > commit makes the USB work again fine.
> 
> [...]
> 
> > Better would be:
> > 
> > #define __arch_dma_to_pfn(dev, addr)	\
> > 	({ unsigned long pfn = (addr) >> PAGE_SHIFT;		\
> > 	   if (is_lbus_device(dev))				\
> > 		pfn += PHYS_PFN_OFFSET - 			\
> > 			(OMAP1510_LB_OFFSET >> PAGE_SHIFT);	\
> > 	   pfn;							\
> > 	})
> > 
> > Can you try that in arch/arm/mach-omap1/include/mach/memory.h please?
> 
> Still doesn't work:
> 
> [   33.878790] ohci ohci: Coherent DMA mask 0xffffffff (pfn 0xfffe0000-0xe0000) covers a smaller range of system memory than the DMA zone pfn 0x0-0x100000
> [   33.894019] ohci ohci: can't setup: -12

Well, that looks technically better, rather unfortunate that we end up
going to negative PFNs though.

Without that change, could you try this instead please:

 arch/arm/mm/dma-mapping.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f0ea0134e5a3..a18cfc53f445 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -9,6 +9,7 @@
  *
  *  DMA uncached mapping support.
  */
+#include <linux/bootmem.h>
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/gfp.h>
@@ -162,6 +163,8 @@ static u64 get_coherent_dma_mask(struct device *dev)
 	u64 mask = (u64)DMA_BIT_MASK(32);
 
 	if (dev) {
+		unsigned long max_dma_pfn;
+
 		mask = dev->coherent_dma_mask;
 
 		/*
@@ -173,6 +176,8 @@ static u64 get_coherent_dma_mask(struct device *dev)
 			return 0;
 		}
 
+		max_dma_pfn = min(max_pfn, arm_dma_pfn_limit);
+
 		/*
 		 * If the mask allows for more memory than we can address,
 		 * and we actually have that much memory, then fail the
@@ -180,7 +185,7 @@ static u64 get_coherent_dma_mask(struct device *dev)
 		 */
 		if (sizeof(mask) != sizeof(dma_addr_t) &&
 		    mask > (dma_addr_t)~0 &&
-		    dma_to_pfn(dev, ~0) > arm_dma_pfn_limit) {
+		    dma_to_pfn(dev, ~0) > max_dma_pfn) {
 			dev_warn(dev, "Coherent DMA mask %#llx is larger than dma_addr_t allows\n",
 				 mask);
 			dev_warn(dev, "Driver did not use or check the return value from dma_set_coherent_mask()?\n");
@@ -192,7 +197,7 @@ static u64 get_coherent_dma_mask(struct device *dev)
 		 * fits within the allowable addresses which we can
 		 * allocate.
 		 */
-		if (dma_to_pfn(dev, mask) < arm_dma_pfn_limit) {
+		if (dma_to_pfn(dev, mask) < max_dma_pfn) {
 			dev_warn(dev, "Coherent DMA mask %#llx (pfn %#lx-%#lx) covers a smaller range of system memory than the DMA zone pfn 0x0-%#lx\n",
 				 mask,
 				 dma_to_pfn(dev, 0), dma_to_pfn(dev, mask) + 1,

