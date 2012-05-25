From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4-alt 3/6] ARM: OMAP3: hwmod data: add gpmc
Date: Fri, 25 May 2012 10:26:59 +0300
Message-ID: <20120525072659.GB6206@atomide.com>
References: <cover.1335941443.git.afzal@ti.com>
 <99ffbbcc634022ed3c781c37e03989f1d898003e.1335941444.git.afzal@ti.com>
 <alpine.DEB.2.00.1205051949290.20926@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E987188@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1205080915220.9984@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98A2F3@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1205212344460.1275@utopia.booyaka.com>
 <20120522164215.GE16308@atomide.com>
 <alpine.DEB.2.00.1205230843260.3085@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:43937 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab2EYH1E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 May 2012 03:27:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1205230843260.3085@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Mohammed, Afzal" <afzal@ti.com>, khilman@ti.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Paul Walmsley <paul@pwsan.com> [120523 17:55]:
> On Tue, 22 May 2012, Tony Lindgren wrote:
> > 
> > Unfortunately for many of the older boards these values will probably
> > remain unknown.
> > 
> > So the better approach here is to just disable frequency scaling
> > for these cases. Otherwise we'll be breaking old boards with smsc911x
> > where the timings for the FPGA controlling smsc911x are unknown.
> > 
> > If we somehow manage to get those values without breaking support for
> > these boards, then yes I agree we should deprecate hardcoded and
> > bootloader values.
> 
> I was thinking that if we log the register values supplied by the 
> bootloader to the console, then someone can write a patch to the board 
> file or DT data to set those register values explicitly in the kernel, 
> once they're known.  Or at least just report them to the l-o list.
> 
> So then that should reduce the problem cases down to boards which no one 
> reports the data to the mailing list within a few mainline kernel releases 
> -- i.e., boards which are unmaintained.  For those boards, I'd suggest 
> that we just drop GPMC support until someone shows up who has a board and 
> can test-boot it.  Or just drop the board completely ;-)

OK seems fair to me. It still allows us to boot the older boards with
minimal changes (but without L3 frequency scaling).

Sounds like those registers should be dumped only if no configuration
is specified to avoid spamming the console.

Regards,

Tony
