From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: n900 in next-20170901
Date: Fri, 10 Nov 2017 09:13:16 +0900
Message-ID: <20171110001315.GA29669@js1304-P5Q-DELUXE>
References: <20171026141627.GD21504@atomide.com>
 <20171107053313.GA12447@js1304-P5Q-DELUXE>
 <20171107154842.GP28152@atomide.com>
 <20171108074645.GA18747@js1304-P5Q-DELUXE>
 <20171108163413.GU28152@atomide.com>
 <20171109000801.GA23982@js1304-P5Q-DELUXE>
 <20171109001113.GZ28152@atomide.com>
 <20171109003639.GB23982@js1304-P5Q-DELUXE>
 <20171109035031.GA24383@js1304-P5Q-DELUXE>
 <20171109150854.GC28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171109150854.GC28152@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 09, 2017 at 07:08:54AM -0800, Tony Lindgren wrote:
> * Joonsoo Kim <iamjoonsoo.kim@lge.com> [171109 03:47]:
> > Could you test following two commits on my updated branch?
> > 
> > "arm/dma: vmalloc area allocation"
> 
> Won't boot at this commit:
> 
> [    6.747283] save_secure_sram() returns 0000ff02
> [    6.751983] save_secure_sram()'s param: 0: 0x4
> [    6.756561] save_secure_sram()'s param: 1: 0x8e700000
> [    6.761749] save_secure_sram()'s param: 2: 0x0
> [    6.766326] save_secure_sram()'s param: 3: 0x1
> [    6.770904] save_secure_sram()'s param: 4: 0x1
> 
> > "arm/dma: defer atomic pool initialization"
> 
> Boots at this commit.
> 
> > I suspect that changed virtual address of the sram due to early
> > __dma_alloc_remap() call causes the problem and above two commits test
> > this theory.
> 
> Hmm OK. Does your first patch above now have the initcall issue too?
> It boots if I make that also subsys_initcall and then I get:

> [    2.078094] vmalloc_pool_init: DMA: get vmalloc area: d0010000

Yes, first patch has the initcall issue and it's intentional in order
to check the theory. I checked following log for this.

- Boot failure
SRAM_ADDR: omap_map_sram: P: 0x40208000 - 0x4020f000
SRAM_ADDR: omap_map_sram: V: 0xd0050000 - 0xd0057000

- Boot success
SRAM_ADDR: omap_map_sram: P: 0x40208000 - 0x4020f000
SRAM_ADDR: omap_map_sram: V: 0xd0008000 - 0xd000f000

When failure, virtual address for sram is higher than normal one due
to vmalloc area allocation in __dma_alloc_remap(). If it is deferred,
virtual address is the same with success case and then the system work.

So, my next theory is that there is n900 specific assumption that sram
should have that address. Could you check if any working tree for n900
which doesn't have my CMA series work or not with adding
"arm/dma: vmalloc area allocation"?

Thanks.
