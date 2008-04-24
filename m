From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] USB: Generalize usb initialization for omap hw
Date: Thu, 24 Apr 2008 13:48:11 -0700
Message-ID: <20080424204811.GJ16834@atomide.com>
References: <200804241129.28213.david-b@pacbell.net> <1209063112-30352-1-git-send-email-felipe.balbi@nokia.com> <1209063112-30352-2-git-send-email-felipe.balbi@nokia.com> <200804241207.43593.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64518 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbYDXUsO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2008 16:48:14 -0400
Content-Disposition: inline
In-Reply-To: <200804241207.43593.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [080424 12:07]:
> Looks better to me, but:
>=20
> On Thursday 24 April 2008, Felipe Balbi wrote:
> > +static void setup_ehci_io_mux(void)
> > +{
> > +#ifdef CONFIG_OMAP_EHCI_PHY_MODE
>=20
> This PHY_MODE thing should probably be provided by the board
> data not Kconfig, and
>=20
> > +=A0=A0=A0=A0=A0=A0=A0/* PHY mode of operation for board: 750-2083-=
001
> > +=A0=A0=A0=A0=A0=A0=A0 * ISP1504 connected to Port1 and Port2
> > +=A0=A0=A0=A0=A0=A0=A0 * Do Func Mux setting for 12-pin ULPI PHY mo=
de
> > +=A0=A0=A0=A0=A0=A0=A0 */
> > +
> > +=A0=A0=A0=A0=A0=A0=A0/* Port1 */
> > +=A0=A0=A0=A0=A0=A0=A0omap_cfg_reg(Y9_3430_USB1HS_PHY_STP);
> > +=A0=A0=A0=A0=A0=A0=A0omap_cfg_reg(Y8_3430_USB1HS_PHY_CLK);
> > 	...
>=20
> All those MUX options should be driven by the board data too.
>=20
> Unless it's for some reason not possible to configure only one
> of the three EHCI ports at a time...
>=20
> This patch being cleanup-only, I don't suggest you fix that
> at this time.

OK, I'll push Felipe's patch today.

Tony



> - Dave
>=20
>=20
>=20
> > +
> > +#else
> > +=A0=A0=A0=A0=A0=A0=A0/* Set Func mux for :
> > +=A0=A0=A0=A0=A0=A0=A0 * TLL mode of operation
> > +=A0=A0=A0=A0=A0=A0=A0 * 12-pin ULPI SDR TLL mode for Port1/2/3
> > +=A0=A0=A0=A0=A0=A0=A0 */
> > +
> > +=A0=A0=A0=A0=A0=A0=A0/* Port1 */
> > +=A0=A0=A0=A0=A0=A0=A0omap_cfg_reg(Y9_3430_USB1HS_TLL_STP);
> > +=A0=A0=A0=A0=A0=A0=A0omap_cfg_reg(Y8_3430_USB1HS_TLL_CLK);
> > +=A0=A0=A0=A0=A0=A0=A0	...
> > +#endif /* CONFIG_OMAP_EHCI_PHY_MODE */
> > +
> > +=A0=A0=A0=A0=A0=A0=A0return;
> > +}
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
