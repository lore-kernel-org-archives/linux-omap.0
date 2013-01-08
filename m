From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Build failure with DMA_OMAP=m and a caller built-in
Date: Tue, 8 Jan 2013 01:02:32 -0800
Message-ID: <20130108090231.GF19691@intel.com>
References: <1357449969.4324.25.camel@deadeye.wl.decadent.org.uk>
 <20130107202106.GG14149@atomide.com>
 <20130107203834.GB2637@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130107203834.GB2637@n2100.arm.linux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Ben Hutchings <ben@decadent.org.uk>, linux-kbuild@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 07, 2013 at 08:38:34PM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 07, 2013 at 12:21:06PM -0800, Tony Lindgren wrote:
> > * Ben Hutchings <ben@decadent.org.uk> [130105 21:29]:
> > > Various drivers use omap_dma_filter_fn() but don't depend on DMA_OMAP.
> > > This is fine because there is a trivial inline definition in case
> > > DMA_OMAP is disabled... until the caller is built-in and DMA_OMAP=m.
> > > 
> > > I tried adding the rather weird 'select DMA_OMAP if DMA_OMAP!=n' to
> > > these drivers' kconfig symbols to promote it to built-in if necessary.
> > > This sort of works but kconfig complains about the circular dependency
> > > and it becomes impossible to disable DMA_OMAP in the 'make nconfig'
> > > menu.  So that's not the right thing to do.
> > > 
> > > Any ideas?
> > 
> > Hmm let's ask Russell and Vinod what they are envisioning. I believe
> > there was some talk about removing the filter functions?
> 
> The right thing is to nobble down and try and resolve the age old, much
> talked about, common way to tie peripheral devices and their DMA engine
> channels together by some means.
> 
> Unfortunately, it seems everyone has different views, and as yet it's
> not reached any kind of concensus.  This has now been going on for a
> couple of years in various forms.
> 
> The problem we have is that the way peripheral devices are connected to
> their DMA engines can involve additional complexity, which if not handled
> correctly results in some platforms being crippled by the API.
> 
> I think Vinod was working on something, however I've not heard anything on
> that for a while now.
My work was stalled due to other stuff at my workplace. I plan to spend some
time on this pretty soon.
> 
> How we avoid this problem outside of OMAP is that the DMA filter function
> gets passed from platform code, and we only ever allow the DMA engine
> driver to be configured into the kernel (iow, non-modular).  This means
> that the DMA users never directly reference the DMA engine driver itself.
> However, as OMAP headed down the DT path, many drivers no longer make use
> of platform data, which makes that approach impractical.
> 
> So, I'm afraid that OMAP's rather boxed into a corner over the various
> different competing factions about how ARM should do X, Y and Z vs the
> state of various subsystems.  So much for DT sorting out world hunger
> and it never failing to solve any problem...
> 
> I'm sure it'll eventually get sorted, but how long that takes depends on
> how long it takes to come up with a working API for connecting peripheral
> devices with their DMA agent(s).
