From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/8] ARM: OMAP5: Update SOC id detection code for ES2
Date: Wed, 20 Feb 2013 18:27:22 +0200
Message-ID: <20130220162722.GL16652@arwen.pp.htv.fi>
References: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
 <1361374034-21831-2-git-send-email-santosh.shilimkar@ti.com>
 <20130220152940.GE16652@arwen.pp.htv.fi>
 <5124F3D4.1060307@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DN8g+DOX2TxGxleI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47320 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933117Ab3BTQ13 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 11:27:29 -0500
Content-Disposition: inline
In-Reply-To: <5124F3D4.1060307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: balbi@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

--DN8g+DOX2TxGxleI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 20, 2013 at 09:33:32PM +0530, Santosh Shilimkar wrote:
> >>  	default:
> >>  		/* Unknown default to latest silicon rev as default*/
> >>-		omap_revision =3D OMAP5430_REV_ES1_0;
> >>+		omap_revision =3D OMAP5430_REV_ES2_0;
> >
> >how about we default to 0xffffffff ? That's the highest possible
> >version, just not sure if our revision macros can cope with it.
> >
> :D
> For record, it was decided that we will always have latest silicon
> spin as default and hence OMAP5_ES2

but then this line will forever be modified. Every year or so :-p

--=20
balbi

--DN8g+DOX2TxGxleI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRJPlqAAoJEIaOsuA1yqREgocP/3XbWOCJ6OTqJb659/VwOWTh
mb5FT78gaTvJsmz2VL12mb1izIEqJcWkQsYxmxWDNvbBdAJxC7lNOkgctPN0Eh+1
kRdB/uNQiPeNZzLjftiBG4AGFW/j8W8sXPcwgDA7vNV/mA3GtAiJzDz+7m36vV6Y
EITuaXjw/m6/CuaQPlib+zJoOo6f2bMu9whigxrAPinR0+jIu7ta/Cil3IlWZQzH
7cW8u6U/QlQ4ZFq8ZoGSGHwX0LX3q11R0m6GLQQ3rogSXTOSV9C4bL/8qjNw9HPV
M51Hgv8DjZpac4NS7e0/t1ATq/+aptCSPTvWnJZ0MB4a88iW9Izym4aD2Azm41a9
7Yc+3uA9APpC/SUGGWgMC25neMjP7rfrXFibHxR4JkJIKPWErKFXobMdz5a7b/Ya
3XSFKcbpzEoAfyMfBeCSiefjJe5EIYMeQzBIkikpqvAGLFJyyuUrZbtoOp3iYzjm
4w01lwp3kQu6dmEWCkn2CnBmV5hhdY3msTnoaAye9F9xxZeh1936AuYiT0dmrPYt
mdIf1S2cuBru8elsggoX+CbDkDLAhf4QdaFGR3Ky1b9kyUICyFzk7PYm0NJCeNa2
lhFZjIativShPULgpIPsv4o+EP/aI3ODRXZ4R58rE+Uo8ncGOJrjF4XMLQqmER7K
Qjr1WR0k9vaoK3nypAQB
=CY8D
-----END PGP SIGNATURE-----

--DN8g+DOX2TxGxleI--
