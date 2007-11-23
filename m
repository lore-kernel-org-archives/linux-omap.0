From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND 0/4] Runtime constants: define (some) OMAP
	address bases at runtime rather than compile time for multiboot
Date: Fri, 23 Nov 2007 14:08:48 -0800
Message-ID: <20071123220848.GP559@atomide.com>
References: <20071121001620.571082090@pwsan.com>
	<20071121090339.4f256297.jarkko.nikula@nokia.com>
	<Pine.LNX.4.64.0711210009220.31116@utopia.booyaka.com>
	<20071121095605.a929f07d.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20071121095605.a929f07d.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: ext Paul Walmsley <paul@pwsan.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [071120 23:55]:
> On Wed, 21 Nov 2007 00:13:17 -0700 (MST)
> "ext Paul Walmsley" <paul@pwsan.com> wrote:
> 
> > > How about calling omap2_set_globals_242x() from
> > > arch/arm/mach-omap2/io.c: omap2_map_common_io() in order to avoid
> > > modifications to n board files?
> > 
> > We could do that, but we'd still need to modify the board files to
> > pass in the OMAP type to omap2_map_common_io().  
> > 
> > In an ideal world, we could just use omap2_check_revision() to
> > determine the CPU type at runtime, but the TAP base address is not
> > the same across all OMAPs, and must therefore itself be modified for
> > multiboot :-(
> > 
> Ah, yes, I see. Chicken and egg problem.
> 
> void __init omap2_map_common_io(void)
> {
> ...
> 	/* revision? TAP base ?*/
> 	omap2_check_revision();
> ...
> 
> I think at this point it is better to modify n board files, as your set
> is doing, instead of modifying omap2_map_common_io() API? At least both
> add & possible clean-up patches will be just one liners only.

I guess later on we could try autodetect the TAP base :)

Pushing today, like you said improvments to CPU detection will be
trivial patches. And we may want to have both functions in place
so we can printk warnings if CPU detection code does not match what's
set in the board files.

Regards,

Tony
