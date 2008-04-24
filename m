From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] USB: Generalize usb initialization for omap hw
Date: Fri, 25 Apr 2008 00:08:22 +0300
Message-ID: <20080424210821.GB8794@kedavra.cpe.vivax.com.br>
References: <200804241129.28213.david-b@pacbell.net> <1209063112-30352-1-git-send-email-felipe.balbi@nokia.com> <1209063112-30352-2-git-send-email-felipe.balbi@nokia.com> <200804241207.43593.david-b@pacbell.net> <20080424204811.GJ16834@atomide.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55466 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbYDXVG7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 17:06:59 -0400
Content-Disposition: inline
In-Reply-To: <20080424204811.GJ16834@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: David Brownell <david-b@pacbell.net>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

On Thu, Apr 24, 2008 at 01:48:11PM -0700, Tony Lindgren wrote:
> * David Brownell <david-b@pacbell.net> [080424 12:07]:
> > Looks better to me, but:
> >=20
> > On Thursday 24 April 2008, Felipe Balbi wrote:
> > > +static void setup_ehci_io_mux(void)
> > > +{
> > > +#ifdef CONFIG_OMAP_EHCI_PHY_MODE
> >=20
> > This PHY_MODE thing should probably be provided by the board
> > data not Kconfig, and
> >=20
> > > +=A0=A0=A0=A0=A0=A0=A0/* PHY mode of operation for board: 750-208=
3-001
> > > +=A0=A0=A0=A0=A0=A0=A0 * ISP1504 connected to Port1 and Port2
> > > +=A0=A0=A0=A0=A0=A0=A0 * Do Func Mux setting for 12-pin ULPI PHY =
mode
> > > +=A0=A0=A0=A0=A0=A0=A0 */
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0/* Port1 */
> > > +=A0=A0=A0=A0=A0=A0=A0omap_cfg_reg(Y9_3430_USB1HS_PHY_STP);
> > > +=A0=A0=A0=A0=A0=A0=A0omap_cfg_reg(Y8_3430_USB1HS_PHY_CLK);
> > > 	...
> >=20
> > All those MUX options should be driven by the board data too.
> >=20
> > Unless it's for some reason not possible to configure only one
> > of the three EHCI ports at a time...
> >=20
> > This patch being cleanup-only, I don't suggest you fix that
> > at this time.
>=20
> OK, I'll push Felipe's patch today.

Thanks tony, i'll check dave's comments tomorrow then. Maybe i can come
up with some stuff soon.

--=20
Best Regards,

=46elipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
