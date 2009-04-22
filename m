From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: dma_alloc_coherent fragmentation
Date: Wed, 22 Apr 2009 15:39:22 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8F76F@dbde02.ent.ti.com>
References: <f502236f0904220046s50ff816cse752798deb895759@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02B3D8F6E5@dbde02.ent.ti.com>
 <f502236f0904220244t6b39839aw268f0a3a7660928e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45413 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753572AbZDVKJc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 06:09:32 -0400
In-Reply-To: <f502236f0904220244t6b39839aw268f0a3a7660928e@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: pramod gurav <pramodforum@gmail.com>, "Gupta, Ramesh" <grgupta@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This would just temporarily delay the problem. People have even tried with values of 14 MB and all. Nishant M knows one such recent issue.

Bye the way use of this macro for general DMAable memory is discouraged. You can find many threads on ARM mailing list. 

Regards,
Santosh
 

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of pramod gurav
> Sent: Wednesday, April 22, 2009 3:14 PM
> To: Gupta, Ramesh
> Cc: Menon, Nishanth; linux-omap@vger.kernel.org
> Subject: Re: dma_alloc_coherent fragmentation
> 
> Hi Ramesh,
> This worked. Thanks a lot.
> 
> 
> -- 
> Best Regards
> Pramod
> 
> 
> On Wed, Apr 22, 2009 at 2:44 PM, Gupta, Ramesh <grgupta@ti.com> wrote:
> > Hi Pramod,
> >
> >
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org
> >> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of pramod gurav
> >> Sent: Wednesday, April 22, 2009 1:17 PM
> >> To: Menon, Nishanth
> >> Cc: linux-omap@vger.kernel.org
> >> Subject: Re: dma_alloc_coherent fragmentation
> >>
> >> Hi Nishant,
> >> I am facing the same problem to allocate a chunk of 4MB on omap3evm
> >> using dma_alloc_coherent. I used the test driver mentioned here
> >> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg11074.html
> >>
> >> I applied the patch for
> >> ioremap(24f11ec001920f1cfaeeed8e8b55725d900bbb56) suggested by
> >> Russell, but stiill seeing the error saying
> >>
> >> coherent allocation too big (requested 0x400000 mask 0xffffffff)
> >> alloc[0] - virt=0x00000000 phy=0xFFFFFFFF size=0x00400000
> >> Allocation failed idx=0
> >> insmod: cannot insert `dummy.ko': Cannot allocate memory 
> (-1): Cannot
> >> allocate memory
> >>
> >> I changed the GFP_KERNEL to GFP_TEMPORARY and also to (GFP_KERNEL |
> >> __GFP_RECLAIMABLE), but failed to insmod the module.
> >> I am working on linux-omap 2.6.28 kernel. Even I could not allocate
> >> memory size greater than 1MB.
> >> Has this been fixed? Are there any patches to fix this issue?
> >>
> >
> > What is the value for 'CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE' 
> (default is 2 in omap_3430sdp_defconfig), Can you please
> > try increasing to 8?
> >
> > Regards
> > Ramesh Gupta G
> >
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 