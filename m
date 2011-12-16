From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] OMAPDSS: DISPC: Update Fir Coefficients
Date: Fri, 16 Dec 2011 10:15:05 +0200
Message-ID: <1324023305.1859.9.camel@deskari>
References: <1323838310-4439-1-git-send-email-cmahapatra@ti.com>
	 <1323939331.2010.27.camel@deskari>
	 <CAF0AtAtaCGpgeYxss0H_jbYWOwJJ_LW0W8-eqM20juKTAGassA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-9i2cDduHxUaTWbPCMpVN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:36638 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755974Ab1LPIPK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 03:15:10 -0500
In-Reply-To: <CAF0AtAtaCGpgeYxss0H_jbYWOwJJ_LW0W8-eqM20juKTAGassA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org


--=-9i2cDduHxUaTWbPCMpVN
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2011-12-16 at 10:26 +0530, Mahapatra, Chandrabhanu wrote:
> On Thu, Dec 15, 2011 at 2:25 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > On Wed, 2011-12-14 at 10:21 +0530, Chandrabhanu Mahapatra wrote:
> >
> >> +const struct dispc_coef *dispc_ovl_get_scale_coef(int inc, int five_t=
aps)
> >> +{
> >> +     int i;
> >> +     static const struct {
> >> +             int Mmin;
> >> +             int Mmax;
> >> +             const struct dispc_coef *coef_3;
> >> +             const struct dispc_coef *coef_5;
> >> +     } coefs[] =3D {
> >> +             { 26, 32, coef3_M32, coef5_M32 },
> >> +             { 22, 26, coef3_M26, coef5_M26 },
> >> +             { 19, 22, coef3_M22, coef5_M22 },
> >> +             { 16, 19, coef3_M19, coef5_M19 },
> >> +             { 14, 16, coef3_M16, coef5_M16 },
> >> +             { 13, 14, coef3_M14, coef5_M14 },
> >> +             { 12, 13, coef3_M13, coef5_M13 },
> >> +             { 11, 12, coef3_M12, coef5_M12 },
> >> +             { 10, 11, coef3_M11, coef5_M11 },
> >> +             {  9, 10, coef3_M10, coef5_M10 },
> >> +             {  8,  9,  coef3_M9,  coef5_M9 },
> >> +             {  3,  8,  coef3_M8,  coef5_M8 },
> >> +             /*
> >> +              * When upscaling more than two times, blockiness and ou=
tlines
> >> +              * around the image are observed when M8 tables are used=
. M11,
> >> +              * M16 and M19 tables are used to prevent this.
> >> +              */
> >> +             {  2,  3, coef3_M11, coef5_M11 },
> >> +             {  1,  2, coef3_M16, coef5_M16 },
> >> +     };
> >> +
> >> +     inc /=3D 128;
> >> +     for (i =3D 0; i < ARRAY_LEN(coefs); ++i)
> >> +             if (inc > coefs[i].Mmin && inc <=3D coefs[i].Mmax)
> >> +                     return five_taps ? coefs[i].coef_5 : coefs[i].co=
ef_3;
> >> +     if (inc =3D=3D 1)
> >> +             return five_taps ? coef3_M19 : coef5_M19;
> >> +     return NULL;
> >> +}
> >
> > Why don't you handle the inc =3D=3D 1 case the same as others? Just hav=
e an
> > entry in the table for Mmin=3D0, Mmax =3D 1.
> >
> For inc=3D1 i.e. M=3D1 , scaling ratio is maximum as L/M=3D8. DISPC scale=
r
> doesnot support upscaling more than 8 itmes. Having an (Mmin,Mmax] of
> (0,1] will allow such cases.

I don't think I understand. A table entry for 0,1 would match exactly
one inc value, which is 1. Which is the same as you do with the separate
if statement now.

> > Also, I think it's a bit confusing that Mmin is exclusive and Mmax is
> > inclusive in the comparison. It makes the table a bit hard to read, whe=
n
> > looking at which entry is used for which inc. I'd recommend using
> > inclusive comparison for both.
> >
> >  Tomi
> >
> Having both inclusive will allow us to delete the extra comparison for
> inc=3D=3D1 but in my opinion having Mmin exclusive and Mmax inclusive
> actually gives an clear idea of comparison. The tables mostly go by
> the Mmax value.
> For example, for inc=3D26 coef3/5_M26 table is selected, for inc=3D22
> coef3/5_M22 is selected etc.
> If we have both Mmin and Mmax as inclusive above case becomes slightly
> incoherent. Say for M=3D26 instead of coef3/5_M26 which seems more
> obvious choice coef3/5_M32 is selected.

I don't understand this either... If you now have:

{ 26, 32, coef3_M32, coef5_M32 },
{ 22, 26, coef3_M26, coef5_M26 },

It would be changed to

{ 27, 32, coef3_M32, coef5_M32 },
{ 23, 26, coef3_M26, coef5_M26 },

and it would match the same inc values as before after changing the Mmin
comparison to >=3D.

> For both inclusive cases to work and avoid confusion and delete extra
> comparison for inc=3D=3D1 , I have to reverse the order of table entries
> in "coef" table. But for that I will have to put the "When upscaling
> more than two times, blockiness and outlines" comment at the beginning
> of the table and then start with  {  1,  2, coef3_M16, coef5_M16 }.
> This will create even more confusion.

The ranges for the table elements are exclusive. The order doesn't
matter because one inc value can only match one table entry. So I have
to say I don't understand this comment either =3D). Am I missing
something?

 Tomi


--=-9i2cDduHxUaTWbPCMpVN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO6v4EAAoJEPo9qoy8lh719/IQAIfHYF1/0DCt7r40h2OTKsgm
59LwxR0I4VeM1VHxDvu9o7n/sDJmX4pTJEdO0IB+XKl6h2v2tgCRufplUOAhwRIx
2ERp28KP9xArEgRGJH5RlDlo0GAxVB3QsXf9xkAykoz5h0hzOWbi189tNhI+3uSz
S3xxVQy9hcHroj+TaliruPNSA80VsxDofusGXz/TRH5CgRUNDAm6X/3Bn6xDtzm8
J1ZzEhYVUhjpcCn1A4M9KjUg0xp8S8moAaa+fD1jqjumdbb6zmwbCyg/y0LqknfC
lg+bLO6B5cBu8Y3j+7ORrFh3+LTSIkFrXN73DICMAi0TrRSdHm1ma6AU9acHJ8tL
T0vvZUM3l+IlIiwZsWvD6wWM/lFcra1p3VvmCxdiuQq5MI4Cll43K/Inp1OYYwpk
LhGnl3jfih6fWh7sZhqNhJDoN+OcWohewQ7EWolM/y8qB6LQxOSvbCg5OZd0tHNR
6ghoCi6PTAywbkOD5dn/W36zUPo6JbJEwdz36BgYn+hdewyJHMcvD0Pw9lY6edVu
6lsKu4K+oobuB9AFx8zmGTuqCWY/whOCeuAMpAFJEXw8oFOtLJCG5rvUOXaKvicq
g3Zyrgkw69KTDrhC37wlcGlUqNXNYaw0A8SwmX8x831EPt8oFJ1M9V6/VpWYtMJa
JmZFN8/64JhUQMmL8MZW
=eg1E
-----END PGP SIGNATURE-----

--=-9i2cDduHxUaTWbPCMpVN--

