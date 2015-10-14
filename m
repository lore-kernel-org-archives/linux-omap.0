From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] ARM: dts: omap3: keep ssi ports by default
Date: Wed, 14 Oct 2015 13:17:02 +0200
Message-ID: <20151014111702.GA14340@earth>
References: <1444819456-26728-1-git-send-email-rogerq@ti.com>
 <1444819456-26728-3-git-send-email-rogerq@ti.com>
 <20151014105304.GB13084@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151014105304.GB13084@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: tony@atomide.com, wsa@the-dreams.de, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pali,

On Wed, Oct 14, 2015 at 12:53:04PM +0200, Pali Roh=E1r wrote:
> On Wednesday 14 October 2015 13:44:16 Roger Quadros wrote:
> > Let's keep the SSI ports disabled in the omap3.dtsi to avoid
> > getting the following noise on the console for boards that don't
> > use the SSI ports.
> >=20
> > "omap_ssi_port 4805a000.ssi-port: DT data is missing cawake gpio (err=
=3D-2)"
> >=20
> > As omap3-n900 uses one SSI port, mark it enabled there.
> >=20
>=20
> Sebastian, why is second SSI port disabled on N900? It is not used or
> in DTS file are missing some definitions?

Since the second SSI port is not used on the Nokia N900. It's pins
are used for other things, e.g. as GPIO. It's easily verifiable
by checking the mux data:

$ grep -C1 "ssi2_" arch/arm/mach-omap2/mux34xx.c
	_OMAP3_MUXENTRY(CAM_D10, 109,
		"cam_d10", "ssi2_wake", NULL, NULL,
		"gpio_109", "hw_dbg8", NULL, "safe_mode"),
	_OMAP3_MUXENTRY(CAM_D2, 101,
		"cam_d2", "ssi2_rdy_tx", NULL, NULL,
		"gpio_101", "hw_dbg4", NULL, "safe_mode"),
	_OMAP3_MUXENTRY(CAM_D3, 102,
		"cam_d3", "ssi2_dat_rx", NULL, NULL,
		"gpio_102", "hw_dbg5", NULL, "safe_mode"),
	_OMAP3_MUXENTRY(CAM_D4, 103,
		"cam_d4", "ssi2_flag_rx", NULL, NULL,
		"gpio_103", "hw_dbg6", NULL, "safe_mode"),
	_OMAP3_MUXENTRY(CAM_D5, 104,
		"cam_d5", "ssi2_rdy_rx", NULL, NULL,
		"gpio_104", "hw_dbg7", NULL, "safe_mode"),
	_OMAP3_MUXENTRY(CAM_HS, 94,
		"cam_hs", "ssi2_dat_tx", NULL, NULL,
		"gpio_94", "hw_dbg0", NULL, "safe_mode"),
	_OMAP3_MUXENTRY(CAM_VS, 95,
		"cam_vs", "ssi2_flag_tx", NULL, NULL,
		"gpio_95", "hw_dbg1", NULL, "safe_mode"),

At least gpio 104 is already used for resetting the tsc2005.

-- Sebastian

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWHjmrAAoJENju1/PIO/qahQQP/0XAag7WrN0jq3A1WW2bfqrA
OKcJAyJ/MknJWmZklCjeBZrbExnmF8yWz3v3nq7JAucEUFIVon/LwlCAnlOXs7im
GWAGoYU9q+H5K4kvPpBrtfjBIJ/dPGh23sq1C32vo++w93tj9m1IEHdoO4G5Vevw
LmOoI4/nMaLseSvjiz917KlLn/rt1OnNUf3OMhPHerKN54MzIoVS3sJWrWN/6t6z
+Nkrh7RkVaf5jjJsMInRlbuKNaw+VRRJmaQQCkJFjw118Ovbt3BrKGNfonvqZWzI
6dUYV2H+N5cmAsE2QyORzC1BvKW6mkJ+9vrQqbNURXqbW6dxZwJT6VOpp1WqQUPM
780fgdMjqoaQY5I4y2iCHscHFiI/efyOdpzUrjRpwbg3KhvovsK7rQBiZ2/K81Cj
IlmRaOha0MfRQNUIxEAkd29+eh61okXOIVb4qc5EHHmD8WACQZGJL9QYlL1R1UNb
hptX1k9v8TPpvErv9yhFlsfZjkomj3ftqdKdh1PfOSPYATnrePjkpBSlEBRw3Tky
6dMBrSQYWXjfze1MbBU7HvRAUjuz84vjEiwR0/nn3XV/oxczPImzPvx27ZyEaKV9
nfObZV7Tod4mGbiuESqmz3K9SNj1i2ur3QcbCXgvRnTfejwHOpv57lO3NmRDeeWj
Kv+tBUw4Bj66aA5nntqJ
=XPwV
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
