From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] drm/i2c: tda998x: Register ASoC hdmi-codec and add
 audio DT binding
Date: Fri, 5 Aug 2016 18:59:08 +0100
Message-ID: <20160805175908.GC10383@sirena.org.uk>
References: <cover.1470129989.git.jsarha@ti.com>
 <ce10548e1c28270d80ee99a525e117d0d25f5656.1470129989.git.jsarha@ti.com>
 <20160804140712.GO5783@n2100.arm.linux.org.uk>
 <3a3dcfa4-cec8-53f8-eddb-9a0e04c10ac9@ti.com>
 <20160805164845.GP5783@n2100.arm.linux.org.uk>
 <20160805165959.GA10383@sirena.org.uk>
 <20160805170450.GQ5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1937463431=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20160805170450.GQ5783@n2100.arm.linux.org.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, dri-devel@lists.freedesktop.org, liam.r.girdwood@linux.intel.com, tony@atomide.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============1937463431==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UhXv5VeBZ/Y8lRnC"
Content-Disposition: inline


--UhXv5VeBZ/Y8lRnC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 05, 2016 at 06:04:50PM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 05, 2016 at 05:59:59PM +0100, Mark Brown wrote:

> > We do have some stuff in there in order to handle MFDs - they'll
> > instantiate a Linux-internal virtual platform device as a child of the
> > DT device that represents the device as a whole.  We're definitely not
> > expecting to find anything for parentless platform devices though, it's
> > only done if the ASoC level device has no of_node and the parent does.

> And if we make the hdmi-codec device a child of the I2C device which
> does have an of-node, what will happen?

It'll pick up that as the DT device to hang things off which I'd expect
to be the desired outcome given that this is a very similar situation to
the MFD situation.  I've not been following the full thread so there is
probably context I'm missing here...

--UhXv5VeBZ/Y8lRnC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXpNPsAAoJECTWi3JdVIfQx/MH/j3fjcNIvv8zNazdXsJ2UoAx
uZr4CzjX8P5eeixh0PF9XJJoh+MlhvDkLMgfjyi0nV0sv1GhafWdEmfszE01TIiD
XiWLUQvCbw79s6rRgOgfjbTblzgAx1Vv+VtcI1dkesb5t6phwzv2qsEx5veFYl4U
dYV/Pj96/8+HCVWv28XwGMQ/G4qKF4TojAazWjsAtuVPOLYYF6NuwacoDIkQIwnO
uip5G9QY6pqFL9QSnm5ZlQoiTbqt2OWTumF0aiWTdLXwKiUvXMkK+/UFYAWkVDOY
N7CpvLd+sgPwqUdtOa/8FPHRTyRvExtNBe/4e1jWvVNznEKhmQy5mfQff/kAUpI=
=FJn/
-----END PGP SIGNATURE-----

--UhXv5VeBZ/Y8lRnC--

--===============1937463431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1937463431==--
