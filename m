From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 07/10] ARM: OMAP2/3: sDMA: Correct
	omap_request_dma_chain(), v2
Date: Tue, 26 May 2009 10:25:52 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B4B33CBC@dbde02.ent.ti.com>
References: <20090519232905.12760.15490.stgit@localhost>
 <20090519234007.12760.1967.stgit@localhost>
 <20090525093400.GD28195@n2100.arm.linux.org.uk>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B4B338A3@dbde02.ent.ti.com>
 <20090525162857.GC29933@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53651 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbZEZE4X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 May 2009 00:56:23 -0400
In-Reply-To: <20090525162857.GC29933@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Monday, May 25, 2009 9:59 PM
> To: Shilimkar, Santosh
> Cc: Russell King - ARM Linux; 
> linux-arm-kernel@lists.arm.linux.org.uk; linux-omap@vger.kernel.org
> Subject: Re: [PATCH 07/10] ARM: OMAP2/3: sDMA: Correct 
> omap_request_dma_chain(), v2
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [090525 02:40]:
> > > -----Original Message-----
> > > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> > > Sent: Monday, May 25, 2009 3:04 PM
> > > To: Tony Lindgren
> > > Cc: linux-arm-kernel@lists.arm.linux.org.uk; 
> > > linux-omap@vger.kernel.org; Shilimkar, Santosh
> > > Subject: Re: [PATCH 07/10] ARM: OMAP2/3: sDMA: Correct 
> > > omap_request_dma_chain()
> > > 
> > > On Tue, May 19, 2009 at 04:40:07PM -0700, Tony Lindgren wrote:
> > > > From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > > > 
> > > > Original OMAP DMA chaining design has chain_id as one of 
> > > the callback
> > > > parameters. Patch 538528de0cb256f65716ab2e9613d9e920f97fe2 broke
> > > > the desing.
> > > > 
> > > > Change the callback to return the logical channel number and not
> > > > chain_id.
> > > 
> > > This patch does not make a material change.  It merely 
> > > changes the name
> > > used in a couple function pointer prototype.  This has no 
> > > impact on the
> > > generated code - iow, it's cosmetic.
> > Yes it does look cosmetic but if you see the API signature, 
> it corrects the callback parameters which actually the DMA lib sends. 
> > 
> > The current API signature is misleading for chained DMA 
> transfers where the actual driver passes 'channel number' as 
> one of the callback parameter instead of chain_id which was 
> the original design.
> 
> Here's this one with more descriptive comments.

Thanks Tony !!

Regards,
Santosh
 