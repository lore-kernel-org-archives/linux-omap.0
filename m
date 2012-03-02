From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus: Fix lines for Nokia 770
Date: Fri, 2 Mar 2012 11:22:30 +0200
Message-ID: <20120302092228.GF23543@legolas.emea.dhcp.ti.com>
References: <20120222220937.GM18185@atomide.com>
 <20120223084633.GB18463@legolas.emea.dhcp.ti.com>
 <20120302000219.GD18901@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xkXJwpr35CY/Lc3I"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:56291 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757836Ab2CBJWi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 04:22:38 -0500
Received: by lahl5 with SMTP id l5so1964242lah.29
        for <linux-omap@vger.kernel.org>; Fri, 02 Mar 2012 01:22:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120302000219.GD18901@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org


--xkXJwpr35CY/Lc3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2012 at 04:02:19PM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [120223 00:15]:
> > Hi,
> >=20
> > On Wed, Feb 22, 2012 at 02:09:37PM -0800, Tony Lindgren wrote:
> > > From 54c4785b8d274f8d282b4243945ae0b17edf4686 Mon Sep 17 00:00:00 2001
> > > From: Tony Lindgren <tony@atomide.com>
> > > Date: Wed, 22 Feb 2012 13:03:07 -0800
> > > Subject: [PATCH] cbus: Fix lines for Nokia 770
> > >=20
> > > This makes retu and tahvo work again on Nokia 770 so it
> > > stays running.
> > >=20
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > >=20
> > > ---
> > >=20
> > > I applied this into cbus branch as it seems to fix retu
> > > watchdog for Nokia 770.
> > >=20
> > > --- a/arch/arm/mach-omap1/board-nokia770.c
> > > +++ b/arch/arm/mach-omap1/board-nokia770.c
> > > @@ -87,9 +87,9 @@ static struct platform_device nokia770_kp_device =
=3D {
> > >  #if defined(CONFIG_CBUS) || defined(CONFIG_CBUS_MODULE)
> > > =20
> > >  static struct cbus_host_platform_data nokia770_cbus_data =3D {
> > > -	.clk_gpio	=3D OMAP_MPUIO(11),
> > > +	.clk_gpio	=3D OMAP_MPUIO(9),
> > >  	.dat_gpio	=3D OMAP_MPUIO(10),
> > > -	.sel_gpio	=3D OMAP_MPUIO(9),
> > > +	.sel_gpio	=3D OMAP_MPUIO(11),
> > >  };
> > > =20
> > >  static struct platform_device nokia770_cbus_device =3D {
> >=20
> > Has this been wrong since the beginning ? Looking at commit d64193bd, I
> > just moved whatever was on cbus.c to respective board-files.
>=20
> Yes I think I dumped them from custom ATAGs quite a while ago,
> but probably got them wrong way around at some point and have
> been wondering ever since how come cbus does not seem to work
> on 770 :)

I see... oh well, shit happens :-) Good catch btw :-)

--=20
balbi

--xkXJwpr35CY/Lc3I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPUJFUAAoJEIaOsuA1yqREraMQAJM/fGdQqiiosMh98AFqGAEO
mOF+i/Ul0fGTPs98LT50NAdvWL/wgjiOQ1PqpQmb/ujShKX813dAUzz39Cd5LZn3
TVXRbJ6ytE6i9Apqr5QQOEW/FW7D2f2GE8O8LiLdh6fCIoW1NijNLZ+dop6ngzj/
rw8UTgrwSJS0FHU2fpCt6DVdOOo4qc3ViNWYpHcTYt7z9jnF3dV4JGrhb7ccYGT5
dsXfi8sd3eZLnzXbgSBu5UJUMPmKfkA4NNHQaVWafuVhnzU4416lkHfON47//ABL
Ut/hTcO9V4cwC8b2iarlv6UGM5odeKOo3cIg3lThi8bD2olwWFmjV6YY05O+m9OW
W34CQ3fuCgDJbLitMJkPKZ6Lo7qhUNIvSwYf9/7ba/sZ2NZmV0QMylY9yc+sJQ2p
jOb82xPOwhnSSjinGPQjRXtM7l9sv71mw8GiRHhVxkto2D9vIgzLqbvIC1bxB7A0
COKWJfU0yddoeaGFtUOXLlbNWGnw4npyAGCi3WoJy3hn1eQ/v7isO6eIHgiZffJk
1deW+UIGphWy7FGYLAXmX3HIrVFdxeL1B8h0Ovz9nZrESwTWD0UesQBg3ysh404d
ny2CK+xAkfYa0JSdtcyWHXZu+CBV7uJk+32n11466QLVk6XgLbFIcf1w/NOUpM9x
1sVmZmNLryXJwBfKB1Ht
=RVO2
-----END PGP SIGNATURE-----

--xkXJwpr35CY/Lc3I--
