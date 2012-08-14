From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/6] OMAPDSS: DSS: Cleanup cpu_is_xxxx checks
Date: Tue, 14 Aug 2012 17:34:55 +0300
Message-ID: <1344954895.2345.37.camel@deskari>
References: <1344425899-28267-1-git-send-email-cmahapatra@ti.com>
	 <1344859176-4512-1-git-send-email-cmahapatra@ti.com>
	 <1344937705.2345.17.camel@deskari>
	 <CAF0AtAsgTHwnUKaU8AzO5b7sThQTaocDGdb1Ebknuev_DgC0hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-QpV+2diOZZsAXkQJG9Rs"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:33310 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751444Ab2HNOfB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Aug 2012 10:35:01 -0400
Received: by lagr15 with SMTP id r15so315125lag.21
        for <linux-omap@vger.kernel.org>; Tue, 14 Aug 2012 07:34:57 -0700 (PDT)
In-Reply-To: <CAF0AtAsgTHwnUKaU8AzO5b7sThQTaocDGdb1Ebknuev_DgC0hg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-QpV+2diOZZsAXkQJG9Rs
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-14 at 18:00 +0530, Mahapatra, Chandrabhanu wrote:
> On Tue, Aug 14, 2012 at 3:18 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > On Mon, 2012-08-13 at 17:29 +0530, Chandrabhanu Mahapatra wrote:
> >> All the cpu_is checks have been moved to dss_init_features function pr=
oviding a
> >> much more generic and cleaner interface. The OMAP version and revision=
 specific
> >> initializations in various functions are cleaned and the necessary dat=
a are
> >> moved to dss_features structure which is local to dss.c.
> >
> > It'd be good to have some version information here. Even just [PATCH v3
> > 3/6] in the subject is good, but of course the best is if there's a
> > short change log
> >
>=20
> Is it ok to have short change log in the individual patch description
> itself. I normally prefer the cover letter for this.

No, the patch description is added to git repository, and shouldn't
contain that kind of "extra" information. But you can add the version
information to the posted patch.

The diff stats below, after the "---" line, are discarded by git when
applying the patch. So I think you can just insert any text below ---
(but before the actual diffs) and they do not appear in the final git
commit.

I've not actually used that myself, and I can't find notes about it in
the documentation, so I'm not sure if there are any restrictions about
it. I've seen it used, though.

> >> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> >> ---
> >>  drivers/video/omap2/dss/dss.c |  115 ++++++++++++++++++++++++++------=
---------
> >>  1 file changed, 74 insertions(+), 41 deletions(-)
> >>
> >> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/d=
ss.c
> >> index 7b1c6ac..6ab236e 100644
> >> --- a/drivers/video/omap2/dss/dss.c
> >> +++ b/drivers/video/omap2/dss/dss.c
> >> @@ -31,6 +31,7 @@
> >>  #include <linux/clk.h>
> >>  #include <linux/platform_device.h>
> >>  #include <linux/pm_runtime.h>
> >> +#include <linux/dma-mapping.h>
> >
> > Hmm, what is this for?
> >
>=20
> I should have included "include/linux/gfp.h" instead. It defines GFP_KERN=
EL.
>=20
> >>  #include <video/omapdss.h>
> >>
> >> @@ -65,6 +66,13 @@ struct dss_reg {
> >>  static int dss_runtime_get(void);
> >>  static void dss_runtime_put(void);
> >>
> >> +struct dss_features {
> >> +     u16 fck_div_max;
> >> +     int factor;
> >> +     char *clk_name;
> >> +     bool (*check_cinfo_fck) (void);
> >> +};
> >
> > Is the check_cinfo_fck a leftover from previous versions?
> >
>=20
> Sorry, to have skipped that.
>=20
> > I think "factor" name is too vague. If I remember right, it's some kind
> > of implicit multiplier for the dss fck. So "dss_fck_multiplier"? You
> > could check the clock trees to verify what the multiplier exactly was,
> > and see if you can come up with a better name =3D).
> >
>=20
> dss_fck_multiplier sounds good to me. DSS clocks trees do not seem to

Yes, it's not really DSS thing, but PRCM. If things were perfect, DSS
wouldn't even need to know about the clock.

> mention anything about this multiplier. I found clock "dpll4_mx4_clk"
> in omap3 trm but nothing called "dpll_per_m5x2_clk" in omap4 trm. Any
> references please you know about?

Hmm, I think that's the linux's name for it. TRM seems to call it
CLKOUTX2_M5 (in the power, reset and clock management section).

> >> +     if (cpu_is_omap24xx())
> >> +             dss.feat =3D &omap2_dss_features;
> >> +     else if (cpu_is_omap34xx())
> >> +             dss.feat =3D &omap34_dss_features;
> >> +     else if (cpu_is_omap3630())
> >> +             dss.feat =3D &omap36_dss_features;
> >> +     else
> >> +             dss.feat =3D &omap4_dss_features;
> >
> > Check for omap4 also, and if the cpu is none of the above, return error=
.
> >
>=20
> I was wondering what error value to return. I was considering EINVAL
> (error in value) and ENODEV (no such device). But nothing seems to fit
> this case.

ENODEV sounds fine to me. I think EINVAL should be used when some given
parameter was wrong.


--=-QpV+2diOZZsAXkQJG9Rs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQKmIPAAoJEPo9qoy8lh71glUP/iHP23XQK5WDfBvU9Oq7duu8
KcaEh2tamp34NR7YusoWvnNE5NZBJZYj5IQ/8FdiHUboGzAdxA5bIlWfSCFrHBK4
mkAXWLhqtcYKw54uXQJvHahJApyCOQGvVUBbN4shR/JrGpHnPEZPxNrEJSe+zEMP
ZNT2V+oCt/48gpim19q+i02JLqO/Re/PRuoX1+oLyI/bmh9k4rArKNHneCQDhNWg
Fy7ikj5vG+RIvVEBtjv8wq5YDgcwmaLY+rwRtS3EfG+BFsQS46qE3U9Tix3zecrA
UYihG35G1XrdVKs6GcuNZas1tQUjunrAz+OHVmu8mnJUp9Efz600jIQ+fNihB4B6
wIuPU6OpYyLgYyffNRlsxiajhFUdqoK0RLLsKtG6YVVj+MnkzICqT+Xn4Mw2GKII
4CioP0Ddcz/le3XYQGHOq8CfAYszkYQ+VyLr/T0exWTiT3gctJ2LS02ZGeISB8aX
KMqD6Gq78VQObQQaumhvThDl/TWVIcbYqL3w4t9BAdW76aweuQYO/SqRY3vW8eVd
7qwTEvxDXBonfSCXrU8oD2B/e7M0TiySScD/s2Osr2/ibU9zivWBQetjkDMqcEG6
ka56t2KHsfQScvTM85QaFZeA/LF1HiQkiqY3nVeHN1Vvn77CfDq8nvM2P5peEg08
omq2zfYnIklPN5ylvl9g
=BtiT
-----END PGP SIGNATURE-----

--=-QpV+2diOZZsAXkQJG9Rs--

