From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: Fix compile error when FB_OMAP2 is not set
Date: Fri, 09 Mar 2012 10:11:58 +0200
Message-ID: <1331280718.1927.10.camel@deskari>
References: <20120308204328.GW12083@atomide.com>
	 <20120308204607.GX12083@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-7SBVTSyn0xF3OZJcOjAW"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:56496 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752092Ab2CIIME (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 03:12:04 -0500
Received: by laap9 with SMTP id p9so1770044laa.24
        for <linux-omap@vger.kernel.org>; Fri, 09 Mar 2012 00:12:01 -0800 (PST)
In-Reply-To: <20120308204607.GX12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--=-7SBVTSyn0xF3OZJcOjAW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-03-08 at 12:46 -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120308 12:11]:
> > Otherwise we will get:
> >=20
> > arch/arm/plat-omap/fb.c:101: error: expected =E2=80=98)=E2=80=99 before=
 =E2=80=98*=E2=80=99 token
> >=20
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> >=20
> > ---
> >=20
> > Tomi, you need something like this for what you have in for-next.
> >=20
> > --- a/arch/arm/plat-omap/fb.c
> > +++ b/arch/arm/plat-omap/fb.c
> > @@ -98,6 +98,8 @@ arch_initcall(omap_init_fb);
> > =20
> >  #else
> > =20
> > -void __init omapfb_set_lcd_config(omap_lcd_config *config) { }
> > +void __init omapfb_set_lcd_config(const struct omap_lcd_config *config=
)
> > +{
> > +}
> > =20
> >  #endif
>=20
> Also now seeing the following with what you have in for-next:
>=20
> drivers/video/omap2/displays/panel-taal.c: In function =E2=80=98taal_num_=
errors_show=E2=80=99:
> drivers/video/omap2/displays/panel-taal.c:605: warning: =E2=80=98errors=
=E2=80=99 may be used uninitialized in this function

Hmm, my compiler doesn't complain (codesourcery 2010.09-50), so I didn't
notice that. Which compiler version reports the warning?

I'm not 100% sure, but I think it's a false warning, the code path that
uses "errors" should only be ran when "errors" has been set.

 Tomi


--=-7SBVTSyn0xF3OZJcOjAW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPWbtOAAoJEPo9qoy8lh71Am4P/2W7b8F+Rtno8yWA0Lze0G2r
xFG9QjJcTIQTzeOqvQ+RacKm+XrLzMLHKCKs3jf0WD0b1BGpNn2NoJaJ4b1qGV48
YB8pP06Rm3iCgLq+I85xZh/NETd5xvc9LGxas//LQ8dNo4Ya9m/DYZWqs5czvIAD
FCbm2PdA49kcUb8MslEvIdJ+Htk6OQV/jQSdriPEj0KDH+N41uxwOSr+BSPP7Hws
mF96LuKjtDG2RYc0Vn5mqOEfBcJU29KIeO4LwX23Qy15PNdjzRjOTDaAobOtUuYD
TYGLT4AqXKD7UBWTSZJg7mg3vERFh1WrHr3WwLv5m7vBlsGutAQhzcCEZWKRHAPo
4LPSz271pl5YlPQDuVcFgJZF2vijSTSJQYSuXs2v6UWLc3HiG9kNSCSazBXkX/W0
W/GEvkH6kewz9aWuGifSYQN5ofwPWODWVwZ7mffkyMRcPo5A1mSNzKg8/G9jBufn
5A5JldJB1hLXUHyvbf/wNRn8uqeByVwMtR8JEkhr689SS88r8VV4toVi2VitaGpH
ZMN+YGTBMQoqBkgDllmW39h3DWwqpyyA1/ColjDlWDtlfEDp+wEk+w0xRO+OCmnJ
s8NLabPrkjO+kkUP95xTgq3wKL8X85O91MovYyNp1QKIPINCdrnjCNf5L24aou/7
7FgYKS1uPdTnwrLnLp0g
=4lZM
-----END PGP SIGNATURE-----

--=-7SBVTSyn0xF3OZJcOjAW--

