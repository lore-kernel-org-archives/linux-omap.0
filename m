From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] autogain support for bayer10 format (was Re: [patch]
 propagating controls in libv4l2)
Date: Thu, 27 Apr 2017 00:51:50 +0200
Message-ID: <20170426225150.GA4188@amd>
References: <20170416091209.GB7456@valkosipuli.retiisi.org.uk>
 <20170419105118.72b8e284@vento.lan> <20170424093059.GA20427@amd>
 <20170424103802.00d3b554@vento.lan> <20170424212914.GA20780@amd>
 <20170424224724.5bb52382@vento.lan> <20170426105300.GA857@amd>
 <20170426081330.6ca10e42@vento.lan> <20170426132337.GA6482@amd>
 <cedfd68d-d0fe-6fa8-2676-b61f3ddda652@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1562016602295871138=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cedfd68d-d0fe-6fa8-2676-b61f3ddda652@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: abcloriens@gmail.com, linux-media@vger.kernel.org, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, Mauro Carvalho Chehab <mchehab@s-opensource.com>, Sakari Ailus <sakari.ailus@iki.fi>, Sakari Ailus <sakari.ailus@linux.intel.com>, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============1562016602295871138==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>There are two separate things here:
> >>
> >>1) Autofoucs for a device that doesn't use subdev API
> >>2) libv4l2 support for devices that require MC and subdev API
> >
> >Actually there are three: 0) autogain. Unfortunately, I need autogain
> >first before autofocus has a chance...
> >
> >And that means... bayer10 support for autogain.
> >
> >Plus, I changed avg_lum to long long. Quick calculation tells me int
> >could overflow with few megapixel sensor.
> >
> >Oh, btw http://ytse.tricolour.net/docs/LowLightOptimization.html no
> >longer works.
> >
> >Regards,
> >								Pavel
> >
> >diff --git a/lib/libv4lconvert/processing/autogain.c b/lib/libv4lconvert=
/processing/autogain.c
> >index c6866d6..0b52d0f 100644
> >--- a/lib/libv4lconvert/processing/autogain.c
> >+++ b/lib/libv4lconvert/processing/autogain.c
> >@@ -68,6 +71,41 @@ static void autogain_adjust(struct v4l2_queryctrl *ct=
rl, int *value,
> > 	}
> > }
> >
> >+static int get_luminosity_bayer10(uint16_t *buf, const struct v4l2_form=
at *fmt)
> >+{
> >+	long long avg_lum =3D 0;
> >+	int x, y;
> >+=09
> >+	buf +=3D fmt->fmt.pix.height * fmt->fmt.pix.bytesperline / 4 +
> >+		fmt->fmt.pix.width / 4;
> >+
> >+	for (y =3D 0; y < fmt->fmt.pix.height / 2; y++) {
> >+		for (x =3D 0; x < fmt->fmt.pix.width / 2; x++)
>=20
> That would take some time :). AIUI, we have NEON support in ARM kernels
> (CONFIG_KERNEL_MODE_NEON), I wonder if it makes sense (me) to convert the
> above loop to NEON-optimized when it comes to it? Are there any drawbacks=
 in
> using NEON code in kernel?

Well, thanks for offer. This is actualy libv4l2.

But I'd say NEON conversion is not neccessary anytime soon. First,
this is just trying to get average luminosity. We can easily skip
quite a lot of pixels, and still get reasonable answer.

Second, omap3isp actually has a hardware block computing statistics
for us. We just don't use it for simplicity.

(But if you want to play with camera, I'll get you patches; there's
ton of work to be done, both kernel and userspace :-).

Regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlkBJIYACgkQMOfwapXb+vIlXgCcC0O2gZ+1Qb6RGo7nSEWdofks
QgwAoI6UOY26tqLmewbaWHowbm38Pl4M
=kC1k
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--


--===============1562016602295871138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1562016602295871138==--
