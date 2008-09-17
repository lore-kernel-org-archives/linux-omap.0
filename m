From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP support in mainline?
Date: Wed, 17 Sep 2008 09:57:25 -0700
Message-ID: <20080917165725.GG25885@atomide.com>
References: <87tzcgi1gv.fsf@nokia.com> <alpine.DEB.1.00.0809160906140.21341@utopia.booyaka.com> <20080916184110.GA10733@frodo> <20080916232505.GC25885@atomide.com> <20080917082043.04c94e2d.jarkko.nikula@nokia.com> <87y71rqo43.fsf@nokia.com> <20080917165350.GF25885@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56698 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714AbYIQQ53 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 12:57:29 -0400
Content-Disposition: inline
In-Reply-To: <20080917165350.GF25885@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Valo <kalle.valo@nokia.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, Felipe Balbi <me@felipebalbi.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [080917 09:55]:
> * Kalle Valo <kalle.valo@nokia.com> [080916 23:32]:
> > Jarkko Nikula <jarkko.nikula@nokia.com> writes:
> > 
> > > On Tue, 16 Sep 2008 16:25:06 -0700
> > > "ext Tony Lindgren" <tony@atomide.com> wrote:
> > >
> > >> Hopefully we'll get all core 24xx and 34xx files integrated soon. But
> > >> then there are tons of board-*.c files missing from mainline that
> > >> probably need to be cleaned up a bit. 
> > >> 
> > > I think one good measure for this whole work when one can can run
> > > Beagle or Overo with mainline kernel.
> > 
> > I really would like to run N800/N810 with mainline kernel (ie. with
> > Linus' tree), at least get it booting. For example, sound and
> > bluetooth are not that important for me right now. What kind of
> > cleanup is needed for that?
> 
> Well here are few things that come to mind for N8X0:
> 
> - drivers/cbus needs to be cleaned and submitted via LKML
> 
> - arch/arm/mach-omap2/board-n800*.c maybe should be called board-n8x0*.c
>   instead?
> 
> - blizzard_enable_clocks() needs to create a virtual clock so that
>   drivers/video/omap/ can just call clk_enable/disable(). Other board
>   files may need this done too, at least nokia770*.c has the same
>   problem

Oh, one more thing: All the ATAG_OMAP data needs to be set in the
board-*.c files as platform_data, omap specific ATAGs won't be going
to mainline as discussed earlier on linux-arm-kernel.

If any ATAGs are needed, such as for the serial console, it needs to
be a generic ATAG for whole arch/arm.

Tony
