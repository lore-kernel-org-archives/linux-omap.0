From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 2/2] i2c: omap: fix "Too much work in one IRQ" irq
 handling
Date: Tue, 18 Nov 2014 10:00:59 -0600
Message-ID: <20141118160059.GI8223@saruman>
References: <1416014452-6712-1-git-send-email-al.kochet@gmail.com>
 <1416014452-6712-2-git-send-email-al.kochet@gmail.com>
 <20141115014859.GC808@saruman>
 <7C4EE58D-8956-40C2-B649-775B2F551D2A@gmail.com>
 <20141115034756.GA2917@saruman>
 <20141115035328.GA3289@saruman>
 <A47891AC-7453-43F0-9196-5133A1525C68@gmail.com>
 <20141116154558.GA7422@saruman>
 <20141117144152.GA12644@katana>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FK65GREB+Evh/hTL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53806 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753439AbaKRQAp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2014 11:00:45 -0500
Content-Disposition: inline
In-Reply-To: <20141117144152.GA12644@katana>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Felipe Balbi <balbi@ti.com>, Alexander Kochetkov <al.kochet@gmail.com>, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

--FK65GREB+Evh/hTL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2014 at 03:41:53PM +0100, Wolfram Sang wrote:
>=20
> > > submit write request to General Call Address. In that case ISR could
> > > not correctly handle RDR (or XRDY, ARDY, or that ever). Thats becase
> > > i2c-omap driver doesn't correctly handle i2c-controller's slave mode.
> >=20
> > right, Linux doesn't support being the slave. That's also a missing
> > feature, not a bug.
>=20
> This is going to change. I sent out RFC patches for slave support [1]
> and will send V1 this week. This won't affect your driver, though,
> unless you implement the backend into it.
>=20
> Just to keep your heads up.
>=20
> [1] http://thread.gmane.org/gmane.linux.kernel/1783295

sweet :-)

Still, as of now we can't consider what Alexander mentions a bug. Good
to get it sorted out, but not -rc material.

--=20
balbi

--FK65GREB+Evh/hTL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUa207AAoJEIaOsuA1yqREWv8P/0wuoVjan7wGBpsjA/Xd2s2c
45srl4AgZH3xX6Q10p8f/STxJpLSR1fP+bGdsVkj5G8HjFuTm1+I+Me0uuL08nqi
MPvJVegNJDhAFaw1itF6N5TRr8kV7TavGAQwBWEMD3iJfhIESYoE6rKR76pxsS83
/jK8nNz6yKjxZO+H2/Lp85PZVv+CwJtu4efePoJVFjI1KESqphPCAZJG0/CTcSlE
Fiwi2rg2l5p/4TcoJ0HtTy4+Eo1vt6tBnuVnTPds96BM4gHsK8DQXW5Quc/UT4lF
KH1toAjkf1eY9IeSy+enSllwuT5p8ZNiLj62fPAaoq4OzDiPIj0Hik+D6qWCutDU
LyWqqMcNDJD2GxXdYUJpQbhe1PmrOyt5PWx6ojJRuaXtz676WeVOEZwlFUkuhK3q
EDzoCUp1Pa3R85J8XMqxJFczCNdeos1hGE56f4oCS/WW0q7v5iHKMNAuBSEyVJ4X
P4CBPCkgZKg+xgqwiUO9S+GW56ht2rt72wuh5OclHfYOrk55u7qWbSxYrR+BN4Eo
OWFoK1zVPiBat4mfrXG+3B24c2qpkje+kB//RVfLs/x2dEA46CsY3N1kJr8daMNa
qMYcia69I3tzixyposGwca6nnrT2nwSwVzPIvqF7GldO0ct0fYQ0wAgem7m5JGET
SjaVmwuDy1n/cBbFIIX6
=kbUL
-----END PGP SIGNATURE-----

--FK65GREB+Evh/hTL--
