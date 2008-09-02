From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.27-rc3-omap1] tweak musb_hdrc SOC init code
Date: Tue, 2 Sep 2008 12:54:33 -0700
Message-ID: <200809021254.33265.david-b@pacbell.net>
References: <200809021205.00376.david-b@pacbell.net> <20080902193920.GE6814@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:44637 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751499AbYIBTyf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 15:54:35 -0400
In-Reply-To: <20080902193920.GE6814@frodo>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-omap@vger.kernel.org

On Tuesday 02 September 2008, Felipe Balbi wrote:
>=20
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
>=20
> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
>=20
> > +
> > +=A0=A0=A0=A0=A0/* REVISIT charge pump on TWL4030 can supply up to
> > +=A0=A0=A0=A0=A0 * 100 mA ... but this value is board-specific, lik=
e
> > +=A0=A0=A0=A0=A0 * "mode", and should be passed to usb_musb_init().
> > +=A0=A0=A0=A0=A0 */
> > +=A0=A0=A0=A0=A0.power=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=3D 50,=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* up to 100 mA */
>=20
> We can add some parameters to usb_musb_init();
> Something similar should be done to hsmmc_init(), as of now it only
> registers one slot and some boards have more than one.

Let's wait till the twl4030 usb init gets some board-specific
parameterization.  The MUSB init code should be called after
the TWL4030 is initialized, so it can use TWL facilities right
away.


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
