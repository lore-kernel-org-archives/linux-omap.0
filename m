From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: Add SSI driver configuration
Date: Fri, 23 Aug 2013 20:20:12 +0200
Message-ID: <20130823182011.GC5753@earth.universe>
References: <1376237628-1077-1-git-send-email-sre@debian.org>
 <1376237877-1740-1-git-send-email-sre@debian.org>
 <1376237877-1740-3-git-send-email-sre@debian.org>
 <20130812083051.GL7656@atomide.com>
 <CACRpkdbfGPx=j7byCdQV7Eghohr==mi+FyxSODE8kNTCgH-ayA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IrhDeMKUP4DT/M7F"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbfGPx=j7byCdQV7Eghohr==mi+FyxSODE8kNTCgH-ayA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>
List-Id: linux-omap@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2013 at 03:58:30PM +0200, Linus Walleij wrote:
> On Mon, Aug 12, 2013 at 10:30 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Sebastian Reichel <sre@debian.org> [130811 09:25]:
> >> From: Sebastian Reichel <sre@ring0.de>
> >>
> >> This patch configures and activates the OMAP SSI driver on the RX-51.
> >
> > Hmm, I'd rather see this be DT only driver at this point.
>=20
> +1 on this.

I'm already working on this.

-- Sebastian

--IrhDeMKUP4DT/M7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCAAGBQJSF6fbAAoJENju1/PIO/qa1lcP+gPuo8f2sq/GxQRznTMyJCx2
zH6jq5fmL2XXdCZHrsXi1D7c/islnn6DCwWN/9wlcQZpQ68olGsslbK0kd2K8oFR
4jlLqijxsuBF2lmx4ylG9e2AQ/H2/ZCV8IR/Agz9NFxDa4IsikDM3ldGwMuguOKT
gMEA1iqwY2o/ZxIl4N437HC7667ErYF0Tm85ImKxjJKKkD8TZz1A6eKCF2Z7o1Cj
7JRMDTKgyfYzS+5EtunG2XnJdvOcE8cUsT5WUIaJ0RlGKVTy5KNVXVGz4pfgexLG
cwlmbA12nPyQfxXRmEASunfjo/S/F+uYWYna6LB6l4RYSpsOhXxtjPI59sjX06SE
URl+mwtzPVe4/vTC++vx/SXVfBvwAnu6uPvDRft3O51c9+6DCHbUP8Zo4hu8Vpdh
fHyPwISIPuXcdYErjgEL442G/X8dXhp56phgfuQfoKHEHXzA1zVTOHbyqkAG5nkd
skD78+YxXullqNxAIEFp5hkXm1wqYU/FbOkCmauDB5aMmRToxw/rvN52bcfJSGAW
+K8C4gh6gOhz3x1flz+Awfnj6MsYBUR2cbX6EOL3KboDUKVLjvXGAFSoszReiQcW
Kjx/E5asZQoKyIGAZIjcX01hreu0QvShKzFJM4Z8BfRDX4/2JrnAQSHAd0bTUrPX
pxeh2yKROYdfh2bd66w1
=Sah8
-----END PGP SIGNATURE-----

--IrhDeMKUP4DT/M7F--
