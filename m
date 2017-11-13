From: Tony Lindgren <tony@atomide.com>
Subject: Re: n900 in next-20170901
Date: Mon, 13 Nov 2017 13:15:30 -0800
Message-ID: <20171113211530.GY28152@atomide.com>
References: <20171108163413.GU28152@atomide.com>
 <20171109000801.GA23982@js1304-P5Q-DELUXE>
 <20171109001113.GZ28152@atomide.com>
 <20171109003639.GB23982@js1304-P5Q-DELUXE>
 <20171109035031.GA24383@js1304-P5Q-DELUXE>
 <20171109150854.GC28152@atomide.com>
 <20171110001315.GA29669@js1304-P5Q-DELUXE>
 <20171110032610.GJ28152@atomide.com>
 <20171110063727.GA32073@js1304-P5Q-DELUXE>
 <20171110153620.GO28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171110153620.GO28152@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [171110 07:36]:
> * Joonsoo Kim <iamjoonsoo.kim@lge.com> [171110 06:34]:
> > On Thu, Nov 09, 2017 at 07:26:10PM -0800, Tony Lindgren wrote:
> > > +#define OMAP34XX_SRAM_PHYS	0x40200000
> > > +#define OMAP34XX_SRAM_VIRT	0xd0010000
> > > +#define OMAP34XX_SRAM_SIZE	0x10000
> > 
> > For my testing environment, vmalloc address space is started at
> > roughly 0xe0000000 so 0xd0010000 would not be valid.
> 
> Well we can map it anywhere we want, got any preferences?

Hmm and I'm also wondering what you do to make vmalloc space to
start at 0xe0000000 instead of 0xd0000000?

The reason I'm asking is because I think we can just move all of
save_secure_ram_context to run from DDR instead of SRAM. But I'd
rather do a minimal patch first that fixes your series and then we
can test the further changes with more time.

After moving save_secure_ram_context to DDR, we can call
save_secure_ram_context directly with something like:

	args_pa = __pa(omap3_secure_ram_storage);
	offset = (unsigned long)omap3_secure_ram_storage - args_pa;
	ret = save_secure_ram_context(args_pa, offset);

> Just that the current save_secure_ram_context uses "high_mask"
> of 0xffff to translate the address. To make this more flexible,
> we need the save_secure_ram_context changes too. So we might
> want to do the static mapping and save_secure_ram_context changes
> as a single patch.
> 
> > And, PHYS can be different according to the system type. Maybe either
> > OMAP3_SRAM_PUB_PA or OMAP3_SRAM_PA. It seems that SIZE and TYPE should
> > be considered, too. My understanding is correct?
> 
> We can have a static map for the whole SRAM area, see function
> __arm_ioremap_pfn_caller() for the comment "Try to reuse one of the
> static mapping whenever possible". So the different public SRAM start
> addresses and sizes don't matter there.

And then if save_secure_ram_contet runs in DDR, no static map is
needed.

Regards,

Tony
