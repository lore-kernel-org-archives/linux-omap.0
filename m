From: Felipe Balbi <balbi@ti.com>
Subject: Re: [GIT PULL] move omap mailbox to drivers for v3.11
Date: Thu, 13 Jun 2013 04:37:29 +0300
Message-ID: <20130613013729.GB12078@arwen.pp.htv.fi>
References: <1371074306-57583-1-git-send-email-s-anna@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50559 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756676Ab3FMBjK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Jun 2013 21:39:10 -0400
Content-Disposition: inline
In-Reply-To: <1371074306-57583-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ohad Ben-Cohen <ohad@wizery.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jassi Brar <jaswinder.singh@linaro.org>, Loic Pallardy <loic.pallardy@st.com>

--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 12, 2013 at 04:58:26PM -0500, Suman Anna wrote:
> The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a=
10:
>=20
>   Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)
>=20
> are available in the git repository at:
>=20
>   git@github.com:sumananna/mailbox.git tags/omap-mailbox-for-v3.11

Tony might not have an ssh account on github, when sending pull requests
make sure to use the git read-only URL.

We even have separate url and pushurl attributes for the repository.
Should be enough to just edit .git/config and fix it up.

--=20
balbi

--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRuSJZAAoJEIaOsuA1yqREntkQAKJEVhhSEPLP/ZyD6jjmB1Jp
jkNi9UyJzA4v2SuRch0dWI3spROXH+TsAZv1ja+15ZeAeKLObGCNhceem1gio4fj
JhEpLY1JSnVwXXzrFP1o147B7vuy0zKTFfCK8LYICeNHZMYXGaoawKAe1F+719x6
NZ3WXjTCFoJEE8guNU14e7zpYVAvJ3YVjakvktyvo9lorEf45k1wcHFPBmP7u/V0
2/mHu/T9ZdLxDtVfpnopMTHrDCrYJl9M8azy5sNz1JLzLnW1w8MphAiSGQ2VrHSl
ufRp2fjkI6qRKvpOFoTjhngvHyHYXb5NJNEVubOTnyPPyInOCutIOF+V+d4uG3zN
/WU0ESj5R8dw9OvIVVrZoX+JWFx+hNi+2rS7AmcaFJ1/CmiIE9yiJ7tBM0RfBUTe
XH+o9+duXzJZyKCiv4cDKY74tAxE4zXsZgjHFPDLcRGOXYhkVnsUB+xL70aVDNy9
YmB6t/bLQ1qKYnVTTZNpJCSLtV0Mrd9xDwfRH4yQ6ytmrSCWvpmfHa+1tDc4SwYN
6+nVUSb/xZN4WoAkjeLhncVQJe8qbMct87z6Nv5iobbUzgBc6iLri3wYWv/xrHQ7
qoiixGzVQM/PTKNh2RTg2uZPjCNGNk5oBmkp4uCA0D64bQ7RnvUswX/11yn+2HfT
SUoW5dUw3NDl6gl0d7cl
=rI5Z
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
