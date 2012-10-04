From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Converting vrfb.c
Date: Thu, 04 Oct 2012 12:18:58 +0200
Message-ID: <1349345938.32558.0.camel@lappyti>
References: <1348833847.2437.36.camel@deskari>
	 <20120928150052.GA4840@atomide.com> <20121003184149.GG4840@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Xeu93SjA7EWra59BraDM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:37115 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752715Ab2JDKTI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 06:19:08 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so220241lbo.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 03:19:05 -0700 (PDT)
In-Reply-To: <20121003184149.GG4840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>


--=-Xeu93SjA7EWra59BraDM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-10-03 at 11:41 -0700, Tony Lindgren wrote:
> Hi,
>=20
> * Tony Lindgren <tony@atomide.com> [120928 08:02]:
> > * Tomi Valkeinen <tomi.valkeinen@ti.com> [120928 05:05]:
> > > Hi,
> > >=20
> > > I'm a bit at loss how to deal with drivers/video/omap2/vrfb.c.
> > >=20
> > > VRFB is part of the SDRAM controller on OMAP2 and OMAP3. vrfb.c uses =
the
> > > following functions from sdrc.h:
> > >=20
> > > omap2_sms_write_rot_control();
> > > omap2_sms_write_rot_size();
> > > omap2_sms_write_rot_physical_ba();
> > >=20
> > > There are no other dependencies to the sdrc.c.
> > >=20
> > > Those functions are quite simple:
> > >=20
> > > void omap2_sms_write_rot_control(u32 val, unsigned ctx)
> > > {
> > > 	sms_write_reg(val, SMS_ROT_CONTROL(ctx));
> > > }
> > >=20
> > > void omap2_sms_write_rot_size(u32 val, unsigned ctx)
> > > {
> > > 	sms_write_reg(val, SMS_ROT_SIZE(ctx));
> > > }
> > >=20
> > > void omap2_sms_write_rot_physical_ba(u32 val, unsigned ctx)
> > > {
> > > 	sms_write_reg(val, SMS_ROT_PHYSICAL_BA(ctx));
> > > }
> > >=20
> > > vrfb.c is in turn used by omapfb and omap v4l2 driver.
> > >=20
> > >=20
> > > So... Should I just remove the sdrc.h dependency and make vrfb.c iore=
map
> > > those SMS registers itself? Those three registers are VRFB specific, =
so
> > > they are not used by anyone else. In that case I'd need to pass the S=
MS
> > > base address to vrfb.c somehow.
> > >=20
> > > Or should I have some kind of platform data passed to vrfb.c, which
> > > contains func pointers to the above three functions?
> > >=20
> > > Or should vrfb.c be moved into mach-omap2/? But then how would omapfb
> > > call it? Passing vrfb functions as pointers in omapfb platform data?
> >=20
> > Maybe just export those functions in sdrc.c for now? Eventually
> > that should be just a regular device driver too..
>=20
> Actually, if you're only using it to save and restore the hw
> context, why don't you let mach-omap2/sdrc.c do it based on runtime
> PM calls? It already has omap2_sms_save/restore_context.

No, the functions are used to configure the rotation parameters whenever
the user asks for a new rotation.

 Tomi


--=-Xeu93SjA7EWra59BraDM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQbWKSAAoJEPo9qoy8lh71vA8QAI8LSONmOe7+0E5/pm+Wi/4v
Nrvg7bbs92PdWFwDRQHIHctO6A1TV8xZ5HaU7Gql9F/35j3hgB84RijMoUJcKJkG
BZDpc6YIn3UM6GzEMsgAtLT/gsQGePohmv+NHS48XDCGftyT5CD2GQ3chTmXOz0+
eu1s7yhIwVh0D1wP6I+VzYuHMG6iSbvbb30gwNTPzftRBKTRlzD4ZpxeEg/F23H7
3Cne9skl8p9O9DGm/lNnHgoQlFDEDbGqaKshqkIz7fumsG9jafS2mNtuVPTWaUnk
vY7CIF9Ln654voZKk+DLUw+8vYPcLhKuTeRjtPm89whPML4fvM2tP6rNNytEkMsO
/ErJGKIk6Qvhr3mK3//QV5I23xLYZQCwu75aMaTOTTw7XJ2Ryj0Ke6/FJ1DFlULi
9IWLpqk7CoVV2e5sLUS6c9KkvYYnoS5LbSSSAGs1lhl0lcAtSeR9E1P9LlpEAnXl
j2cEIJPDHdL+L836DieMDALqYSwDX5ryBq3Uf8E6kYuPzERH6gmnpVSiI6rxcE3k
NdP1df+Dt2ktJhEoLCyY6Ml3YPstuVtwOvG9w6JaiHuVMNxgX/uJgpRNLEYBN009
FUqZj8l74U7umGx5pWUDdEaNdOQZj+wHe4V46StUtppMhtfFdJlLL2/+gYLfrNch
d7U2l9X13jbItFBckWiB
=7g7B
-----END PGP SIGNATURE-----

--=-Xeu93SjA7EWra59BraDM--

