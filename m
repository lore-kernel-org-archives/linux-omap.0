From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP: fix fncpy API call
Date: Tue, 1 Feb 2011 16:01:17 -0800
Message-ID: <20110202000116.GM3358@atomide.com>
References: <1295977686-22765-1-git-send-email-j-pihet@ti.com>
 <AANLkTinU5Msop=Lg7iuSfNZXa+7NQCwcrN2hB1a1T9Ds@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26561 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab1BBABg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 19:01:36 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinU5Msop=Lg7iuSfNZXa+7NQCwcrN2hB1a1T9Ds@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dave Martin <dave.martin@linaro.org>
Cc: jean.pihet@newoldbits.com, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

* Dave Martin <dave.martin@linaro.org> [110201 08:34]:
> On Tue, Jan 25, 2011 at 5:48 PM,  <jean.pihet@newoldbits.com> wrote:
> > From: Jean Pihet <j-pihet@ti.com>
> >
> > Fix a potential problem with function types when calling the
> > fncpy API to copy the PM code functions to SRAM.
> >
> > Signed-off-by: Jean Pihet <j-pihet@ti.com>
> > ---
> > =C2=A0arch/arm/plat-omap/include/plat/sram.h | =C2=A0 =C2=A04 ++--
> > =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat=
-omap/include/plat/sram.h
> > index d673f2c..f500fc3 100644
> > --- a/arch/arm/plat-omap/include/plat/sram.h
> > +++ b/arch/arm/plat-omap/include/plat/sram.h
> > @@ -18,10 +18,10 @@ extern void *omap_sram_push_address(unsigned lo=
ng size);
> >
> > =C2=A0/* Macro to push a function to the internal SRAM, using the f=
ncpy API */
> > =C2=A0#define omap_sram_push(funcp, size) ({ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > - =C2=A0 =C2=A0 =C2=A0 typeof(&funcp) _res =3D NULL; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 \
> > + =C2=A0 =C2=A0 =C2=A0 typeof(&(funcp)) _res =3D NULL; =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0void *_sram_address =3D omap_sram_push_a=
ddress(size); =C2=A0 =C2=A0 \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (_sram_address) =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _res =3D fncpy(_=
sram_address, &funcp, size); =C2=A0 =C2=A0 =C2=A0\
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _res =3D fncpy(_=
sram_address, &(funcp), size); =C2=A0 =C2=A0\
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0_res; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> > =C2=A0})
>=20
> I believe this is sound, though I'm not yet in a position to test it =
fully.
>=20
> When I have the OMAP kernel building with Thumb-2 again I will follow=
 up.
>=20
> Cheers
> ---Dave
>=20
>=20
> Reviewed-by: Dave Martin <dave.martin@linaro.org>

Looks good to me too:

Acked-by: Tony Lindgren <tony@atomide.com>

I'll add this to omap-testing branch, but as Russell has this queued,
you'll have to send this to him on linux-arm-kernel list.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
