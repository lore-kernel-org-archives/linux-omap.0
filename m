From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 08/18] ASoC: codecs/hdmi: HDMI codec doesn't benefit
 from pmdown delay
Date: Wed, 15 Oct 2014 12:27:16 +0200
Message-ID: <20141015102716.GB27755@sirena.org.uk>
References: <cover.1413306131.git.jsarha@ti.com>
 <aa7ad47271e780b75b608382a8830cdc22c4193a.1413306131.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xEUC5fB8Sf//E0AF"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:55530 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbaJOK1f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2014 06:27:35 -0400
Content-Disposition: inline
In-Reply-To: <aa7ad47271e780b75b608382a8830cdc22c4193a.1413306131.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com, detheridge@ti.com


--xEUC5fB8Sf//E0AF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2014 at 08:29:27PM +0300, Jyri Sarha wrote:
> Adds .ignore_pmdown_time =3D true to codec driver struct.
>=20
> HDMI codec is currently a dummy codec and doesn't benefit from pmdown
> delay. Even if in the future the codec would controll HDMI encoder, it
> would still be a digital to digital interface that should have no need
> for pmdown delay.

Applied, thanks.

--xEUC5fB8Sf//E0AF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUPkwDAAoJECTWi3JdVIfQArgH/1BXNHUAeg6597g6sd0YW46v
DG+9aEoZKD4ciU50q2GS9T6wLWnNAFV/5vPHFrDyqgt4o5YnOx7t/M7Kh/gG+SsV
NxZdqMmr66XQKueS5vwkxIZ4VwQbb2HWxUwAf5E1iVP2LSqSIr1kJnmo1fzrViUx
G16Yg6N5SBZvkYocn+2mhsUYSpuc6B/3jmRzctuiX0vsISb0vqoY6npU9r48a72a
aJ8ursduLA4+A9Es75rLhu+3Bst4tUpc7OZkG3P8B+5RIxsr97wQ4T+rsZr/I1Yt
pOqGz1rQP4Kw3rx2B+XYn1zOvkrJQS9GK8rfWCsmlJxEy5eBZFjYYQzhX6MDC/Q=
=S90N
-----END PGP SIGNATURE-----

--xEUC5fB8Sf//E0AF--
