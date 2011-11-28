From: Sebastian Reichel <sre@debian.org>
Subject: Re: RX51: tsc2005 platform data
Date: Mon, 28 Nov 2011 23:30:09 +0100
Message-ID: <20111128223009.GA26183@earth.universe>
References: <20111105234942.GA5937@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comu.ring0.de ([46.4.151.82]:35901 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750876Ab1K1WaM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 17:30:12 -0500
Content-Disposition: inline
In-Reply-To: <20111105234942.GA5937@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 06, 2011 at 12:49:42AM +0100, Sebastian Reichel wrote:
> Hi,
>=20
> Please add tsc2005 to board-rx51-peripherals.c. The code should
> have gone through the input queue according to [0], but only
> the touchscreen driver is part of the mainline linux kernel
> since 2.6.39-rc1.
>=20
> I attached the patch adding tsc2005 support to the rx51 board
> file, updated to apply cleanly against the mainline 3.1 kernel.
>=20
> [0] http://comments.gmane.org/gmane.linux.ports.arm.omap/34198

ping! Can this finally go into 3.3?

-- Sebastian

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJO1AtxAAoJENju1/PIO/qaZJQP/jp9XRWYg5/D4QtEgCabK8Nu
chkU6kfIvARHaxTKwCL1zkq77JWzV35nulG3iFiD1qRnI3ehTIv32C2dfRGp4258
2Uqml2BgQtTSC36BQ09oF8t3AqMH65jNE9aP5I8JVW31nRJlBbzoOwTw6ssNlJFC
2HoAz3d3dYrYLZlQfV5atmO1ZFtAk8FILakZjFWlzDRXKPnUBDo5HzlqpKexsNFW
AFedwsPXjIsLXcPBriZilvuPXGcKTBgNXQJUTO7eygoPk8zYyfVUhfXwM9M5ye9x
97w+ymo38UeB7hb6M6D5uEjTQfpcNas+mixC1Xln2uod6M5eZg8B8gX0TVo2yICr
jdotb6V9HNRYmCclPLMfApUjZyGbcuYeCGmKmlKQDqUU1fjo4o3ViZ4eQfJ6Y+2k
/Q2SBdxQ27UrSHSWyQiKMd51CU3sOFfnJ4aKz/aUrqhulkZ3DKNa4bef2ThbpKkw
HvDak6JydSrljtwjy80cRqrqDXDsi5wmmKMqpgo4gNdMKV5613VqaIYQ2HaO6HLR
ou10qClrHVMLEfAy37dOnFPrWYi2Kg7VlepW7pAkMcyj3xnsAIogWXUuM2CFgSnt
RXLm772/yomf/OXWo2YxMWy3uf9EDJ6S/cD4OAPrHhfWc1wDREh8DhSHIVizN1vE
XpI27asrKnCH+b3ToKgT
=aB2c
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
