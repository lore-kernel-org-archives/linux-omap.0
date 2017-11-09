From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: n900 in next-20170901
Date: Thu, 9 Nov 2017 12:50:31 +0900
Message-ID: <20171109035031.GA24383@js1304-P5Q-DELUXE>
References: <20171025173137.GQ4394@atomide.com>
 <20171026044829.GB11791@js1304-P5Q-DELUXE>
 <20171026141627.GD21504@atomide.com>
 <20171107053313.GA12447@js1304-P5Q-DELUXE>
 <20171107154842.GP28152@atomide.com>
 <20171108074645.GA18747@js1304-P5Q-DELUXE>
 <20171108163413.GU28152@atomide.com>
 <20171109000801.GA23982@js1304-P5Q-DELUXE>
 <20171109001113.GZ28152@atomide.com>
 <20171109003639.GB23982@js1304-P5Q-DELUXE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171109003639.GB23982@js1304-P5Q-DELUXE>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 09, 2017 at 09:36:39AM +0900, Joonsoo Kim wrote:
> On Wed, Nov 08, 2017 at 04:11:13PM -0800, Tony Lindgren wrote:
> > * Joonsoo Kim <iamjoonsoo.kim@lge.com> [171109 00:05]:
> > > On Wed, Nov 08, 2017 at 08:34:13AM -0800, Tony Lindgren wrote:
> > > > * Joonsoo Kim <iamjoonsoo.kim@lge.com> [171108 07:43]:
> > > > > On Tue, Nov 07, 2017 at 07:48:42AM -0800, Tony Lindgren wrote:
> > > > > > So it seems the issue is currently at the atomic_pool_init()
> > > > > > related code?
> > > > > 
> > > > > Yes, your test showed it although I can't find any clue in
> > > > > atomic_pool_init().
> > > > > 
> > > > > Could you test updated branch?
> > > > > 
> > > > > https://github.com/JoonsooKim/linux/tree/cma-debug4-next-20180901
> > > > > 
> > > > > There are two relevant commits.
> > > > > 
> > > > > arm/dma: stop dma allocation before __dma_alloc_remap()
> > > > > arm/dma: disable atomic pool after dma allocation
> > > > > 
> > > > > atomic pool initialization will be done partially to check
> > > > > exact point of failure. These are brain-dead commits however I have no
> > > > > idea what's going on here until now. :/
> > > > 
> > > > OK that booted, dmesg output below. Hopefully that provides
> > > > you with some more clues.
> > > 
> > > Thanks!
> > > 
> > > Could you let me know which one is booted? Both of them? or just top
> > > commit ("arm/dma: stop dma allocation before __dma_alloc_remap()")?
> > 
> > Oh OK. Only the top commit boots.
> 
> Okay! I will try to analyze!
> 

Could you test following two commits on my updated branch?

"arm/dma: vmalloc area allocation"
"arm/dma: defer atomic pool initialization"

I suspect that changed virtual address of the sram due to early
__dma_alloc_remap() call causes the problem and above two commits test
this theory.

Thanks.
