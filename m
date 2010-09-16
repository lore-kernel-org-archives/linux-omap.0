From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device registration
Date: Thu, 16 Sep 2010 09:10:08 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027843C3C3@dbde02.ent.ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
 <1282647866-6918-8-git-send-email-manjugk@ti.com>
 <87lj7iv8zv.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A8F@dbde02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027843B8E7@dbde02.ent.ti.com>
 <20100914102407.GC7554@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027843B9A8@dbde02.ent.ti.com>
 <20100914115711.GE7554@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027843BAE5@dbde02.ent.ti.com>
 <20100915071116.GE3393@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48855 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab0IPDkW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 23:40:22 -0400
In-Reply-To: <20100915071116.GE3393@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

Hi,

> -----Original Message-----
> From: Balbi, Felipe 
> Sent: Wednesday, September 15, 2010 12:41 PM
> To: G, Manjunath Kondaiah
> Cc: Balbi, Felipe; Kevin Hilman; linux-omap@vger.kernel.org; 
> Cousson, Benoit; Shilimkar, Santosh
> Subject: Re: [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device 
> registration
> 
> Hi,
> 
> On Tue, Sep 14, 2010 at 09:11:26AM -0500, G, Manjunath Kondaiah wrote:
> >There are several places in kernel code (ex:
> >tools/perf/util/include/linux/bitops.h:static __always_inline int 
> >test_bit(unsigned int nr, const unsigned long *addr)) which 
> are using 
> >__always_inline attribute to make sure functions are inlined.
> 
> those are special cases. Generally, compiler is much better 
> than humans for choosing what should be inlined or not.
> 
> >Ok, Agreed.  We can have inline functions and expanding all 
> macros in 
> >mach-omap dma driver code.
> >However, there is common dma driver(in plat-omap) which has code for 
> >both omap1 and omap2plus which uses this macro.
> 
> well, that can be patched, right ?

In that case, the dma_read/dma_write macros will be splitted into:

static inline void omap1_dma_write(...);
static inline void omap2_dma_write(...);
static inline u32 omap1_dma_read(...);
static inline u32 omap2_dma_read(...);

i.e., Two macro definitions will expand into four internal functions.

-Manjunath
