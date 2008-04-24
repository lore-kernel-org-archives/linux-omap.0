From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] USB: Generalize usb initialization for omap hw
Date: Thu, 24 Apr 2008 14:31:58 -0700
Message-ID: <20080424213157.GL16834@atomide.com>
References: <200804241129.28213.david-b@pacbell.net> <1209063112-30352-1-git-send-email-felipe.balbi@nokia.com> <1209063112-30352-2-git-send-email-felipe.balbi@nokia.com> <200804241207.43593.david-b@pacbell.net> <20080424204811.GJ16834@atomide.com> <20080424210821.GB8794@kedavra.cpe.vivax.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55116 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbYDXVcC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 17:32:02 -0400
Content-Disposition: inline
In-Reply-To: <20080424210821.GB8794@kedavra.cpe.vivax.com.br>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [080424 14:07]:
> On Thu, Apr 24, 2008 at 01:48:11PM -0700, Tony Lindgren wrote:
> > * David Brownell <david-b@pacbell.net> [080424 12:07]:
> > > Looks better to me, but:
> > >=20
> > > On Thursday 24 April 2008, Felipe Balbi wrote:
> > > > +static void setup_ehci_io_mux(void)
> > > > +{
> > > > +#ifdef CONFIG_OMAP_EHCI_PHY_MODE
> > >=20
> > > This PHY_MODE thing should probably be provided by the board
> > > data not Kconfig, and
> > >=20
> > > > +=A0=A0=A0=A0=A0=A0=A0/* PHY mode of operation for board: 750-2=
083-001
> > > > +=A0=A0=A0=A0=A0=A0=A0 * ISP1504 connected to Port1 and Port2
> > > > +=A0=A0=A0=A0=A0=A0=A0 * Do Func Mux setting for 12-pin ULPI PH=
Y mode
> > > > +=A0=A0=A0=A0=A0=A0=A0 */
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0/* Port1 */
> > > > +=A0=A0=A0=A0=A0=A0=A0omap_cfg_reg(Y9_3430_USB1HS_PHY_STP);
> > > > +=A0=A0=A0=A0=A0=A0=A0omap_cfg_reg(Y8_3430_USB1HS_PHY_CLK);
> > > > 	...
> > >=20
> > > All those MUX options should be driven by the board data too.
> > >=20
> > > Unless it's for some reason not possible to configure only one
> > > of the three EHCI ports at a time...
> > >=20
> > > This patch being cleanup-only, I don't suggest you fix that
> > > at this time.
> >=20
> > OK, I'll push Felipe's patch today.
>=20
> Thanks tony, i'll check dave's comments tomorrow then. Maybe i can co=
me
> up with some stuff soon.

Great. While at it, can you also set the TWL4030_IRQNUM during init bas=
ed
on cpu_is_omap() macros? I already got rid of all the other TWL defines
in board-*.h files as you already probably noticed.

That way we can remove it from the board-*.h files as it would block
compiling in multiple omaps.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
