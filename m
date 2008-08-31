From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 01/33] add lp5521 driver
Date: Mon, 1 Sep 2008 00:41:54 +0300
Message-ID: <20080831214151.GK9887@frodo>
References: <1220116593-862-1-git-send-email-me@felipebalbi.com> <1220116593-862-2-git-send-email-me@felipebalbi.com> <200808311339.21660.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:35910 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbYHaVmU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Aug 2008 17:42:20 -0400
Content-Disposition: inline
In-Reply-To: <200808311339.21660.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Mathias Nyman <mathias.nyman@nokia.com>

On Sun, Aug 31, 2008 at 01:39:21PM -0700, David Brownell wrote:
> On Saturday 30 August 2008, Felipe Balbi wrote:
> > +static int lp5521_configure(struct i2c_client *client)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0int ret =3D 0;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0/* Enable chip and set light to logarithmic m=
ode*/
> > +=A0=A0=A0=A0=A0=A0=A0ret |=3D lp5521_write(client, LP5521_REG_ENAB=
LE, 0xc0);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0/* setting all color pwms to direct control m=
ode */
> > +=A0=A0=A0=A0=A0=A0=A0ret |=3D lp5521_write(client, LP5521_REG_OP_M=
ODE, 0x3f);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0/* setting current to 4.7 mA for all channels=
 */
> > +=A0=A0=A0=A0=A0=A0=A0ret |=3D lp5521_write(client, LP5521_REG_R_CN=
TRL, LP5521_CURRENT_4m7);
> > +=A0=A0=A0=A0=A0=A0=A0ret |=3D lp5521_write(client, LP5521_REG_G_CN=
TRL, LP5521_CURRENT_4m7);
> > +=A0=A0=A0=A0=A0=A0=A0ret |=3D lp5521_write(client, LP5521_REG_B_CN=
TRL, LP5521_CURRENT_4m7);
> > +
> > +=A0=A0=A0=A0=A0=A0=A0/* Enable auto-powersave, set charge pump to =
auto, red to battery */
> > +=A0=A0=A0=A0=A0=A0=A0ret |=3D lp5521_write(client, LP5521_REG_MISC=
, 0x3c);
> > +
>=20
> This highlights one reason many of these drivers haven't gone
> upstream: embedding non-general assumptions.  In this case it
> should be simple enough to define platform data to represent
> various options like these ...

Also dropped. The author should take a look at this. I'm putting him in
the loop.

Mathias, any comments on this ??

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
