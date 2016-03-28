From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] regulator: twl: Provide of_map_mode for twl4030
Date: Mon, 28 Mar 2016 10:39:38 +0100
Message-ID: <20160328093938.GA2350@sirena.org.uk>
References: <1458980895-10240-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1458980895-10240-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458980895-10240-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: tony@atomide.com, lgirdwood@gmail.com, sre@kernel.org, pali.rohar@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 26, 2016 at 10:28:14AM +0200, Ivaylo Dimitrov wrote:
> of_map_mode is needed so to be possible to set initial regulators mode from
> the board DTS. Otherwise, for DT boot, regulators are left in their default
> state after reset/reboot.

This should also update the DT binding document for the device to
specify what the valid modes for the device are.

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+PvWAAoJECTWi3JdVIfQurwIAIYbzJCT7y/h3hKl+VrDxEzo
WKoEi25poedxWhqwOz7Wck/xolqUNt9s63WHhf/n34K7RPjY7mLgCNNWs8O8gqs3
7A66OeXc7pcpbUKFSVp3RjOTmdoApifSQRnIs1pafrH5pvK5bRnrex+hStA2m7Pa
+JX/7A0/3TLNNmHZ0/xAaopjpz98HiG8TnlFRd4JSsNAdroHVKTjjNtOqaNVENTB
8hGV33lBpUwkMWU7ys2nIiRQMus+BscvLex+r699KzMYHsQFbmjlMghddbkR4TBP
ElokpW3zrEXwSzVx2vaReuUzymwVBzB29FXL6bCwP2tn3d+XBdFkKSNy8ZQQ3og=
=YBYB
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
