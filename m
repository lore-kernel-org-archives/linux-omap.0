From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] ARM: OMAP: MUSB: BUG on potential deadlocks
Date: Fri, 31 Aug 2007 13:10:24 -0700
Message-ID: <20070831201024.855D8237170@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20070831025359.663866890@mvista.com>
	<20070831025811.887406517@mvista.com>
	<20070831060525.6B49D23744C@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<46D83F42.5090004@mvista.com>
	<20070831174932.3FEA123719C@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<46D860E7.6080306@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46D860E7.6080306@mvista.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: khilman@mvista.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> >> dma_controller_irq
> >>  musb_dma_completion
> >>   musb_g_rx  (or musb_host_rx in host mode)
> >>    musb_g_giveback (musb_advance_schedule --> musb_giveback)
> >>
> >> In both host and gadget cases, the giveback function is entered without
> >> the lock being held and tries to unlock the lock.  The comment in
> >> musb_dma_completion says that the lock is held, but it's not when called
> >> from the DMA IRQ ( but is when called from davinci_irq via
> >> cppi_completion.)
> > 
> > I presume you mean the OMAP2430 support?  Looked to me like TUSB6010
> > got that OK too.  That code for Mentor's DMA engine still has obvious
> > bugs; and I don't know that it's ever had more than basic cleanups.
>
> Yes, this is 2430.
>
> So is nobody else trying to use the Mentor's DMA engine?

It's not available on most other TI silicon.  As I understand it,
Mentor licenses their IP "a la carte" with their DMA being one of
the optional parts.  (Ditto the capability of working through an
external hub ...)


> I know it's typically disabled on DaVinci, but is it used on tusb?

Nope.  "Disabled" being the wrong word; "unavailable" (see above).


>From what I can tell, the TUSB60x0 team took the DaVinci design and
moved it into a discrete chip.  They upgraded the RTL for the MHDRC
core (getting bugfixes).  The 6010 chip uses a relatively conventional
external DMA interface, although it's mostly broken on the first revision
(only one channel works).  The 6020 uses VLYNQ and CPPI ... I can hope
they fixed some of the broken-as-designed aspects of CPPI; that DMA
interface is really counterproductive for most USB cases.

- Dave
