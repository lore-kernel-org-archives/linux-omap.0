From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device registration
Date: Tue, 14 Sep 2010 19:41:26 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027843BAE5@dbde02.ent.ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
 <1282647866-6918-8-git-send-email-manjugk@ti.com>
 <87lj7iv8zv.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A8F@dbde02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027843B8E7@dbde02.ent.ti.com>
 <20100914102407.GC7554@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027843B9A8@dbde02.ent.ti.com>
 <20100914115711.GE7554@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59777 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab0INOLc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 10:11:32 -0400
In-Reply-To: <20100914115711.GE7554@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>




> -----Original Message-----
> From: Balbi, Felipe 
> Sent: Tuesday, September 14, 2010 5:27 PM
> To: G, Manjunath Kondaiah
> Cc: Balbi, Felipe; Kevin Hilman; linux-omap@vger.kernel.org; 
> Cousson, Benoit; Shilimkar, Santosh
> Subject: Re: [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device 
> registration
> 
> On Tue, Sep 14, 2010 at 06:44:01AM -0500, G, Manjunath Kondaiah wrote:
> >
> >
> >> -----Original Message-----
> >> From: Balbi, Felipe
> >> Sent: Tuesday, September 14, 2010 3:54 PM
> >> To: G, Manjunath Kondaiah
> >> Cc: Kevin Hilman; linux-omap@vger.kernel.org; Cousson,
> >> Benoit; Shilimkar, Santosh
> >> Subject: Re: [PATCH v2 07/11] OMAP2/3/4: DMA: HWMOD: Device
> >> registration
> >>
> >> Hi,
> >>
> >> On Tue, Sep 14, 2010 at 05:18:52AM -0500, G, Manjunath 
> Kondaiah wrote:
> >> >How static inline functions are better than this?
> >>
> >> static inline function will at least give you type checking ??
> >
> >If so, even inline function has certain disadvantages such as, A.
> >somtimes the compiler may not be able to inline as many functions as
> >the programmer indicates.
> 
> show me one such example.

There are several places in kernel code
(ex: tools/perf/util/include/linux/bitops.h:static __always_inline int test_bit(unsigned int nr, const unsigned long *addr))
which are using __always_inline attribute to make sure functions are inlined.

> 
> > B. Inline functions might increcase compilation time
> 
> it's possible, for sure. But for the case you just showed the 
> arguments
> are even constant, so there's more room for compile-time optimization.
> In the end, GCC will replace your calls with:
> 
> address = value;
> 
> or, when reading:
> 
> return address
> 
> >The issue in DMA driver is, if I replace dma_read/dma_write 
> macros with
> >inline functions, I need to remove OMAP_DMA4_##reg macro in dma_read
> >and dma write functions and I have to expand the register names all
> >over the place in DMA driver(like instead of CAPS0, it should be
> >OMAP_DMA4_CAPS0, having only CAPS0 will be easier to read).
> 
> it might be easier to read but this is a recipe for disaster. Avoid
> using those macros for part of the actual symbol/define/whatever name
> like that. If someone later decides to change something, it will be a
> pain. With those macros you also kill any possibility of using
> ctags/cscope for source code cross-referencing. When a developers
> searchs for the definition of CAPS0, he won't find it, as it's called
> OMAP_DMA4_CAPS0. So remove those silly things and change the 
> defines to
> static inline functions.

Ok, Agreed.  We can have inline functions and expanding all macros in mach-omap
dma driver code.
However, there is common dma driver(in plat-omap) which has code for both omap1
and omap2plus which uses this macro.

-Manjunath