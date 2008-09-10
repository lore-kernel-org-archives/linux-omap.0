From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.27-rc3-omap1] tweak musb_hdrc SOC init code
Date: Wed, 10 Sep 2008 16:50:47 -0700
Message-ID: <20080910235046.GT21163@atomide.com>
References: <200809021205.00376.david-b@pacbell.net> <20080902193920.GE6814@frodo> <200809021254.33265.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57883 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbYIJXut (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 19:50:49 -0400
Content-Disposition: inline
In-Reply-To: <200809021254.33265.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [080902 12:58]:
> On Tuesday 02 September 2008, Felipe Balbi wrote:
> >=20
> > > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> >=20
> > Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
> >=20
> > > +
> > > +=A0=A0=A0=A0=A0/* REVISIT charge pump on TWL4030 can supply up t=
o
> > > +=A0=A0=A0=A0=A0 * 100 mA ... but this value is board-specific, l=
ike
> > > +=A0=A0=A0=A0=A0 * "mode", and should be passed to usb_musb_init(=
).
> > > +=A0=A0=A0=A0=A0 */
> > > +=A0=A0=A0=A0=A0.power=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=3D 50,=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* up to 100 mA */
> >=20
> > We can add some parameters to usb_musb_init();
> > Something similar should be done to hsmmc_init(), as of now it only
> > registers one slot and some boards have more than one.
>=20
> Let's wait till the twl4030 usb init gets some board-specific
> parameterization.  The MUSB init code should be called after
> the TWL4030 is initialized, so it can use TWL facilities right
> away.

Pushing this to l-o tree today.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
