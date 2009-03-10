From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/6] RX51: adjust hsmmc info
Date: Tue, 10 Mar 2009 12:30:24 -0700
Message-ID: <20090310193023.GB19229@atomide.com>
References: <20090310093255.16889.30509.sendpatchset@ahunter-laptop> <20090310093329.16889.76098.sendpatchset@ahunter-laptop> <200903101058.12980.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51084 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761AbZCJTa2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 15:30:28 -0400
Content-Disposition: inline
In-Reply-To: <200903101058.12980.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>

* David Brownell <david-b@pacbell.net> [090310 10:58]:
> On Tuesday 10 March 2009, Adrian Hunter wrote:
> > @@ -52,16 +52,20 @@ static struct platform_device *rx51_flash_devic=
es[] =3D {
> > =A0
> > =A0static struct twl4030_hsmmc_info mmc[] __initdata =3D {
> > =A0=A0=A0=A0=A0=A0=A0=A0{
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.name=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=3D "external",
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.mmc=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=3D 1,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.wires=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=3D 8,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.wires=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=3D 4,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.cover_only=A0=A0=A0=A0=
=A0=3D true,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.gpio_cd=A0=A0=A0=A0=
=A0=A0=A0=A0=3D 160,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.gpio_wp=A0=A0=A0=A0=
=A0=A0=A0=A0=3D -EINVAL,
> > =A0=A0=A0=A0=A0=A0=A0=A0},
> > =A0=A0=A0=A0=A0=A0=A0=A0{
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.name=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=3D "internal",
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.mmc=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=3D 2,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.wires=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=3D 8,
>=20
> Ack on all the changes above ...
>=20
>=20
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.gpio_cd=A0=A0=A0=A0=
=A0=A0=A0=A0=3D -EINVAL,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.gpio_wp=A0=A0=A0=A0=
=A0=A0=A0=A0=3D -EINVAL,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.vsim_18v=A0=A0=A0=A0=
=A0=A0=A0=3D true,
>=20
> ... but not that one.
>=20
> > =A0=A0=A0=A0=A0=A0=A0=A0},
> > =A0=A0=A0=A0=A0=A0=A0=A0{}=A0=A0=A0=A0=A0=A0/* Terminator */
> > =A0};
>=20
>=20

Applied this too except for the vsim_18v.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
