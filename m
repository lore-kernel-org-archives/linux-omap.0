From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: More randconfig OMAP build errors
Date: Wed, 29 Feb 2012 10:50:22 +0200
Message-ID: <1330505422.1934.5.camel@deskari>
References: <20120228102229.GE18045@n2100.arm.linux.org.uk>
	 <20120228224623.GG18901@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-P2/LxICe6lGUdqvEDzXc"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:48406 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755612Ab2B2Iu0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 03:50:26 -0500
Received: by mail-lpp01m010-f53.google.com with SMTP id c1so1788642lah.40
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 00:50:25 -0800 (PST)
In-Reply-To: <20120228224623.GG18901@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>


--=-P2/LxICe6lGUdqvEDzXc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-02-28 at 14:46 -0800, Tony Lindgren wrote:
> Tomi,
>=20
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120228 01:50]:
> > Todays randconfig found this:
> >=20
> > drivers/video/omap2/displays/panel-dvi.c: In function 'panel_dvi_ddc_re=
ad':
> > drivers/video/omap2/displays/panel-dvi.c:239: error: implicit declarati=
on of function 'i2c_transfer'
> > drivers/video/omap2/displays/panel-dvi.c: In function 'panel_dvi_read_e=
did':
> > drivers/video/omap2/displays/panel-dvi.c:265: error: implicit declarati=
on of function 'i2c_get_adapter'
> >=20
> > caused by I2C being disabled.
> >=20
> > There's also some warnings in arch/arm/mach-omap2/omap_l3_smx.c and
> > drivers/video/omap2/dss/apply.c about unused variables:
> >=20
> > arch/arm/mach-omap2/omap_l3_smx.c: In function 'omap3_l3_block_irq':
> > arch/arm/mach-omap2/omap_l3_smx.c:156: warning: unused variable 'addres=
s'
> > arch/arm/mach-omap2/omap_l3_smx.c:155: warning: unused variable 'multi'
> > arch/arm/mach-omap2/omap_l3_smx.c:154: warning: unused variable 'initid=
'
> > arch/arm/mach-omap2/omap_l3_smx.c:153: warning: unused variable 'code'
> > arch/arm/mach-omap2/omap_l3_smx.c: At top level:
> > arch/arm/mach-omap2/omap_l3_smx.c:68: warning: 'omap3_l3_code_string' d=
efined but not used
> > arch/arm/mach-omap2/omap_l3_smx.c:90: warning: 'omap3_l3_initiator_stri=
ng' defined but not used
> > drivers/video/omap2/dss/apply.c:350: warning: 'wait_pending_extra_info_=
updates' defined but not used
>=20
> Care to take a look at fixing the above?

Yep, I made and sent fixes for them.

 Tomi


--=-P2/LxICe6lGUdqvEDzXc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPTebOAAoJEPo9qoy8lh71JP8P/2wBtvAPnLRklcnJqXSxnkV1
xuQzjyk4TUoXDdCrgKOPB8n68OPZqhzoYOpHLH3GeUr7xAlGlH+UXgVI5eEel/PB
BPkXqD93qXh/bjTaRNqqrNScRXqJlBafktXMCvLwUCYga3g7tNX8X207ESirJeXa
aLmBB0wNhQTtoXdI7qW/5y7NRg9HivFPgDAFnNHB48QiRXToO1QEtlo5CERV/cNf
2DiaiCqGLiBrQLl3wliRYU0nkH62U8sp4Go+ppMggGZOkkcKv8RzBwOS5akk23SB
ilv+lZge1gP62mud0jU+LxK9Q2Z+7520TA/bp9WNmqF7Lzi82slGTHezUggDk8wo
zT4o+Mb/G9MaPfPMsNyxQtud9Xw4ox57NdAv40La14vE5BvHGVdLwJMHvEwzaoEz
BBSjaRySVseTDaFjrJC9adymw4IP3tDovROBjjwsZRe7CyFFE5LP0DQza9bPwmEE
kNNQeI/KA9ZDiFCSq8kuneYx389Xw3byG3lbhoLDdzh2UQfPCNLjY0vAm5UwiBj8
38TGbjZ7KKzjIYevslrDt/c2usI6b9YipSpFoZ+yLDqRrsaxe/xyhbNmzzYDp5vq
fARHv0JLhGaGxeTBZmr2BF83baNJh/v3Gs5/ZGwZcFvAauwDagPs5JE2tHZQjmwO
cSlsg0lG0L4cTmbQJENL
=GQvx
-----END PGP SIGNATURE-----

--=-P2/LxICe6lGUdqvEDzXc--

