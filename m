From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V5 3/6] OMAPDSS: DSS: Cleanup cpu_is_xxxx checks
Date: Tue, 21 Aug 2012 14:20:06 +0300
Message-ID: <1345548006.4085.55.camel@deskari>
References: <cover.1343912532.git.cmahapatra@ti.com>
	 <cover.1345468541.git.cmahapatra@ti.com>
	 <94a123bbc0a4ecd48fc71275fd5efbe0aac93b87.1345468541.git.cmahapatra@ti.com>
	 <1345545312.4085.46.camel@deskari>
	 <CAF0AtAtvyKdW-J97NJ+YNi5pUGQFyxk=B2Eqn_74MZD4dWebEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-YqJYHBZAnaLNqPfuuO+2"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:42183 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756932Ab2HULUL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 07:20:11 -0400
Received: by lagz14 with SMTP id z14so3585970lag.4
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 04:20:08 -0700 (PDT)
In-Reply-To: <CAF0AtAtvyKdW-J97NJ+YNi5pUGQFyxk=B2Eqn_74MZD4dWebEA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-YqJYHBZAnaLNqPfuuO+2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-08-21 at 16:36 +0530, Mahapatra, Chandrabhanu wrote:
> On Tue, Aug 21, 2012 at 4:05 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > On Mon, 2012-08-20 at 18:53 +0530, Chandrabhanu Mahapatra wrote:
> >> All the cpu_is checks have been moved to dss_init_features function pr=
oviding a
> >> much more generic and cleaner interface. The OMAP version and revision=
 specific
> >> initializations in various functions are cleaned and the necessary dat=
a are
> >> moved to dss_features structure which is local to dss.c.
> >>
> >> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> >> ---
> >>  drivers/video/omap2/dss/dss.c |  117 ++++++++++++++++++++++++++------=
---------
> >>  1 file changed, 76 insertions(+), 41 deletions(-)
> >>
> >> diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/d=
ss.c
> >> index 10566ae..f6d3d0a 100644
> >> --- a/drivers/video/omap2/dss/dss.c
> >> +++ b/drivers/video/omap2/dss/dss.c
> >> @@ -31,6 +31,7 @@
> >>  #include <linux/clk.h>
> >>  #include <linux/platform_device.h>
> >>  #include <linux/pm_runtime.h>
> >> +#include <linux/gfp.h>
> >>
> >>  #include <video/omapdss.h>
> >>
> >> @@ -65,6 +66,12 @@ struct dss_reg {
> >>  static int dss_runtime_get(void);
> >>  static void dss_runtime_put(void);
> >>
> >> +struct dss_features {
> >> +     u16 fck_div_max;
> >> +     int dss_fck_multiplier;
> >> +     char *clk_name;
> >
> > const char *
> >
> >  Tomi
> >
>=20
> All the values are const. So we have a const pointer dss.feat to hold
> this structure. Is a separate
> const char *clk_name required?

Yes, the values are const, so the pointer itself is const. However, the
chars where the pointer points are not const. So:

feat.clk_name =3D 1234; // this is rejected by the compiler
feat.clk_name[0] =3D 0; // this would be accepted

 Tomi




--=-YqJYHBZAnaLNqPfuuO+2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQM27mAAoJEPo9qoy8lh715HQP/2jenDKhEKKpYMY0adyBUyAC
s6HwR0s1msnqo9wLCrqFGTiu8ZTuI7fYJrylIhpuv+9WD6XTmdLNvnqVHHQVCU/A
GWtUKE/G0eb3lEmCVCLPVrq/8z21rcBANoFB7DxGfQGqJrxdOyGnA3FXonhapGyE
mwq1dJekQWOJKWd32/gvXX1PhDfAyjYBIgKUBnqj48F6fJqDlgJ7GdNmcxK45AgC
WXJHD5EeVN3Z4j6vf3NHPokwgHgnPcdLMrQ/mtxdlitRQ+Rv57qNfkcb5A+za1l2
lg56amEeI/B9HGKpsF1FNOvOE9zLIfDfAWOfg9SrKtBiP+8zyLjGjoAoH4c/4n0u
fCbCuLAeevNOWHSLdWP+4VJoa786Qby6AFhWVAqkGD2bzoblBsCH724V7qU0csik
ga6GPo9iYi1n4uU9gLu/4Uu4zy1eG63S4cQAwSbFhTT2DP32EkCCotv5BSXE2W//
1DcN71kAqTS4nv6gD6viUjUPwCEaEgChyn/V0RLyTCCXhfdHGVTs83F4AT+6+0FO
26iXYkH0sIidB6r+tDn0NRzPcyt0ZUYMq3q9uI0XJUAiDPDmrCm2h4UvrYbf1G5O
WWvo0q8clmr67k6PZOE0YpCA5c6osCVh5o6lNW/Jj0S9mSdOwXwplZQxXe3Fzjgh
U5+wfWf6V6evvO8Kcc8L
=21pZ
-----END PGP SIGNATURE-----

--=-YqJYHBZAnaLNqPfuuO+2--

