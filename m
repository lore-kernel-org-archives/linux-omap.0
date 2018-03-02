From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.16-rc0: missing includes in framebuffers break N900 compilation
Date: Fri, 2 Mar 2018 10:12:53 +0100
Message-ID: <20180302091253.GB15948@amd>
References: <20180226130007.GA5634@amd>
 <46d9fddf-7e6d-b157-0745-6366ccd57a41@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1476689455=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <46d9fddf-7e6d-b157-0745-6366ccd57a41@ti.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, arvind.yadav.cs@gmail.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, sre@kernel.org, martijn@brixit.nl, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, b.zolnierkie@samsung.com, abcloriens@gmail.com, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, clayton@craftyguy.net, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============1476689455==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-02-26 16:05:53, Tomi Valkeinen wrote:
> v4.16-rc1 has a fix (b9058afcd6c7).

Yep, thanks. I was bisecting sound problem on N900, so this hit me...

     	       	   	     	   	      	       	    Pavel

> On 26/02/18 15:00, Pavel Machek wrote:
> > I needed this to get -rc0 to compile.
> >=20
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >=20
> >=20
> > diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video=
/fbdev/omap2/omapfb/dss/dss.c
> > index 48c6500..990f1c9 100644
> > --- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> > +++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/regmap.h>
> >  #include <linux/of.h>
> >  #include <linux/regulator/consumer.h>
> > +#include <linux/pinctrl/consumer.h>
> >  #include <linux/suspend.h>
> >  #include <linux/component.h>
> > =20
> > diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c b/drivers/=
video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> > index 9a13c35..4862b12 100644
> > --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> > +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/seq_file.h>
> >  #include <linux/slab.h>
> >  #include <video/omapfb_dss.h>
> > =20
> > diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c b/drivers/=
video/fbdev/omap2/omapfb/dss/hdmi_pll.c
> > index eac3665..39014e2 100644
> > --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
> > +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/seq_file.h>
> >  #include <linux/clk.h>
> > =20
> >  #include <video/omapfb_dss.h>
> > diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c b/drivers/v=
ideo/fbdev/omap2/omapfb/dss/hdmi_wp.c
> > index 705373e..e93e7a7 100644
> > --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
> > +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/io.h>
> >  #include <linux/platform_device.h>
> >  #include <video/omapfb_dss.h>
> > +#include <linux/seq_file.h>
> > =20
> >  #include "dss.h"
> >  #include "hdmi.h"
> >=20
>=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqZFZUACgkQMOfwapXb+vIl3QCgjv4HqbyIYsPPmA4EmFd3V7uu
rgQAniOOVBBExlQO/oerf0yTkr14DbeV
=yUiQ
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--

--===============1476689455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1476689455==--
