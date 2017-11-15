From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: n900 in next-20170901
Date: Wed, 15 Nov 2017 11:48:01 +0900
Message-ID: <20171115024801.GA21621@js1304-P5Q-DELUXE>
References: <20171109035031.GA24383@js1304-P5Q-DELUXE>
 <20171109150854.GC28152@atomide.com>
 <20171110001315.GA29669@js1304-P5Q-DELUXE>
 <20171110032610.GJ28152@atomide.com>
 <20171110063727.GA32073@js1304-P5Q-DELUXE>
 <20171110153620.GO28152@atomide.com>
 <20171114063724.GA16969@js1304-P5Q-DELUXE>
 <20171114173719.GA28152@atomide.com>
 <20171115005118.GA21113@js1304-P5Q-DELUXE>
 <20171115020400.GJ28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171115020400.GJ28152@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 14, 2017 at 06:04:00PM -0800, Tony Lindgren wrote:
> * Joonsoo Kim <iamjoonsoo.kim@lge.com> [171115 00:48]:
> > On Tue, Nov 14, 2017 at 09:37:19AM -0800, Tony Lindgren wrote:
> > > * Joonsoo Kim <iamjoonsoo.kim@lge.com> [171114 06:34]:
> > > > On Fri, Nov 10, 2017 at 07:36:20AM -0800, Tony Lindgren wrote:
> > > > > * Joonsoo Kim <iamjoonsoo.kim@lge.com> [171110 06:34]:
> > > > > > On Thu, Nov 09, 2017 at 07:26:10PM -0800, Tony Lindgren wrote:
> > > > > > > +#define OMAP34XX_SRAM_PHYS	0x40200000
> > > > > > > +#define OMAP34XX_SRAM_VIRT	0xd0010000
> > > > > > > +#define OMAP34XX_SRAM_SIZE	0x10000
> > > > > > 
> > > > > > For my testing environment, vmalloc address space is started at
> > > > > > roughly 0xe0000000 so 0xd0010000 would not be valid.
> > > > > 
> > > > > Well we can map it anywhere we want, got any preferences?
> > > > 
> > > > My testing environment is a beagle-(xm?) for QEMU. It is configured by
> > > > CONFIG_VMSPLIT_3G=y so kernel address space is started at 0xc0000000.
> > > > And, it has 512 MB memory so 0xc0000000 ~ 0xdff00000 is used for
> > > > direct mapping. See below.
> > > > 
> > > > [    0.000000] Memory: 429504K/522240K available (11264K kernel code,
> > > > 1562K rwdata, 4288K rodata, 2048K init, 405K bss, 27200K reserved,
> > > > 65536K cma-reserved, 0K highmem)
> > > > [    0.000000] Virtual kernel memory layout:
> > > > [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> > > > [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> > > > [    0.000000]     vmalloc : 0xe0000000 - 0xff800000   ( 504 MB)
> > > > [    0.000000]     lowmem  : 0xc0000000 - 0xdff00000   ( 511 MB)
> > > > [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> > > > [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> > > > [    0.000000]       .text : 0xc0208000 - 0xc0e00000   (12256 kB)
> > > > [    0.000000]       .init : 0xc1300000 - 0xc1500000   (2048 kB)
> > > > [    0.000000]       .data : 0xc1500000 - 0xc1686810   (1563 kB)
> > > > [    0.000000]        .bss : 0xc168fc68 - 0xc16f512c   ( 406 kB)
> > > > 
> > > > Therefore, if OMAP34XX_SRAM_VIRT is 0xd0010000, direct mapping is
> > > > broken and the system doesn't work. I guess that we should use more
> > > > stable address like as 0xf0000000.
> > > 
> > > OK. Let's forget about adding static mappings and my earlier
> > > patches to attempt to fix this. Below is what I now think we should
> > > merge as a fix before merging Joonsoo's patches. Please all review
> > > and test, adding Tero to Cc also.
> > 
> > Okay. Then, this patch will be merged by yourself as a fix? I'm okay
> > with either way. Just let me know. :)
> 
> Well what's the plan with your patches? I'd not have mainline
> kernel broken so if this was the only blocker for the v4.15,
> then you should pick it.
> 
> However, if your patches are now planned for v4.16, then I'll
> queue it for early v4.15-rc.

It was the only blocker but I think that it's too late for v4.15. I
will try again for v4.16. Please queue your fix for early v4.15-rc.

Thanks.
