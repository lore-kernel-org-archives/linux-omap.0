From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/10] ARM: OMAP2/3: sDMA: Correct
	omap_request_dma_chain(), v2
Date: Mon, 25 May 2009 09:28:57 -0700
Message-ID: <20090525162857.GC29933@atomide.com>
References: <20090519232905.12760.15490.stgit@localhost> <20090519234007.12760.1967.stgit@localhost> <20090525093400.GD28195@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02B4B338A3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57056 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbZEYQ3M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 12:29:12 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B4B338A3@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [090525 02:40]:
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> > Sent: Monday, May 25, 2009 3:04 PM
> > To: Tony Lindgren
> > Cc: linux-arm-kernel@lists.arm.linux.org.uk; 
> > linux-omap@vger.kernel.org; Shilimkar, Santosh
> > Subject: Re: [PATCH 07/10] ARM: OMAP2/3: sDMA: Correct 
> > omap_request_dma_chain()
> > 
> > On Tue, May 19, 2009 at 04:40:07PM -0700, Tony Lindgren wrote:
> > > From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > 
> > > Original OMAP DMA chaining design has chain_id as one of 
> > the callback
> > > parameters. Patch 538528de0cb256f65716ab2e9613d9e920f97fe2 broke
> > > the desing.
> > > 
> > > Change the callback to return the logical channel number and not
> > > chain_id.
> > 
> > This patch does not make a material change.  It merely 
> > changes the name
> > used in a couple function pointer prototype.  This has no 
> > impact on the
> > generated code - iow, it's cosmetic.
> Yes it does look cosmetic but if you see the API signature, it corrects the callback parameters which actually the DMA lib sends. 
> 
> The current API signature is misleading for chained DMA transfers where the actual driver passes 'channel number' as one of the callback parameter instead of chain_id which was the original design.

Here's this one with more descriptive comments.

Tony

--u3/rZRmxL6MmkK24
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="dma-chaining-v2.patch"

>From eb76d1e31e2da419a66e16f90504ac3f8cdb6874 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Thu, 21 May 2009 09:11:31 -0700
Subject: [PATCH] ARM: OMAP2/3: sDMA: Correct omap_request_dma_chain(), v2

Original OMAP DMA chaining design had chain_id as one of the callback
parameters. Patch 538528de0cb256f65716ab2e9613d9e920f97fe2 changed it
to use logical channel instead.

Correct the naming for callback to also use logical channel number
instead of the chain_id.

More details are on this email thread:

http://marc.info/?l=linux-omap&m=122961071931459&w=2

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 58d98ad..06e9cbe 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1220,7 +1220,7 @@ static void create_dma_lch_chain(int lch_head, int lch_queue)
  * 	     Failure: -EINVAL/-ENOMEM
  */
 int omap_request_dma_chain(int dev_id, const char *dev_name,
-			   void (*callback) (int chain_id, u16 ch_status,
+			   void (*callback) (int lch, u16 ch_status,
 					     void *data),
 			   int *chain_id, int no_of_chans, int chain_mode,
 			   struct omap_dma_channel_params params)
diff --git a/arch/arm/plat-omap/include/mach/dma.h b/arch/arm/plat-omap/include/mach/dma.h
index 35fefdb..19df76f 100644
--- a/arch/arm/plat-omap/include/mach/dma.h
+++ b/arch/arm/plat-omap/include/mach/dma.h
@@ -532,7 +532,7 @@ extern int omap_get_dma_index(int lch, int *ei, int *fi);
 /* Chaining APIs */
 #ifndef CONFIG_ARCH_OMAP1
 extern int omap_request_dma_chain(int dev_id, const char *dev_name,
-				  void (*callback) (int chain_id, u16 ch_status,
+				  void (*callback) (int lch, u16 ch_status,
 						    void *data),
 				  int *chain_id, int no_of_chans,
 				  int chain_mode,

--u3/rZRmxL6MmkK24--
