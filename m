From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] OMAP: board-files: fix i2c_bus for tfp410
Date: Fri, 16 Nov 2012 15:51:55 +0200
Message-ID: <20121116135155.GE18527@arwen.pp.htv.fi>
References: <1353068553-26897-1-git-send-email-tomi.valkeinen@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Lb0e7rgc7IsuDeGj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44336 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751382Ab2KPN6U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Nov 2012 08:58:20 -0500
Content-Disposition: inline
In-Reply-To: <1353068553-26897-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, stable@vger.kernel.org, linux-i2c@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--Lb0e7rgc7IsuDeGj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 16, 2012 at 02:22:33PM +0200, Tomi Valkeinen wrote:
> The i2c handling in tfp410 driver, which handles converting parallel RGB
> to DVI, was changed in 958f2717b84e88bf833d996997fda8f73276f2af. The

commit summary should be added in () after commit hash. This would look
like:

'was changed in 958f271 (OMAPDSS: TFP410: pdata rewrite).'

> patch changed what value the driver considers as invalid/undefined.
> Before the patch 0 was the invalid value, but as 0 is a valid bus
                  ^
		  missing comma (,) character here.

> number, the patch changed this to -1.
>=20
> However, the fact was missed that many board files do not define the bus
> number at all, thus it's left to 0. This causes the driver to fail to
> get the i2c bus, exiting from the driver's probe with an error, meaning
> that the DVI output does not work for those boards.
>=20
> This patch fixes the issue by changing the i2c_bus number field in the
> driver's platform data from u16 to int, and setting the bus number to -1
> in the board files for the boards that did not define the bus. The
> exception is devkit8000, for which the bus is set to 1, which is the
> correct bus for that board.
>=20
> The bug exists in v3.5+ kernels.
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reported-by: Thomas Weber <thomas@tomweber.eu>
> [for v3.5, v3.6 stable kernels]
> Cc: stable@vger.kernel.org

This format is peculiar. Usually people use:

Cc: stable@vger.kernel.org # v3.5 v3.6

To be fair, the whole i2c_bus_num looks like a big hackery introduced by
the way panel drivers are written for OMAP DSS.

TFP410 is an I2C client, not an OMAPDSS client. After a quick look at
the driver, there's is no such thing as a DSS bus, so looks like you
should have an I2C driver for TFP410 and the whole DSS stuff should be
just a list of clients, but not a struct bus at all.

The fact that you have to pass the I2C bus number down to the panel
driver is already a big indication of how wrong this is, IMHO.

--=20
balbi

--Lb0e7rgc7IsuDeGj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQpkT7AAoJEIaOsuA1yqREHYcP/RuuvWlsnAGKP88vhBEumRe+
a8S4gNpnUV7LXkchDLYNGMBRyopI4tvLN3H+EFG1nllzqHZj6PtMwTaCSfpDnavM
di0vcoRM55Wy8Yz6MCIsBF6jIoMoTMr4zCupQkqN0Q9lzb8vT8px96M/D3TfZiq4
QfPCeO32xYffbqlNd0ie1PLL0G2IHXEBwB5odk4QApuJUXlzrl0cBhBSA5xAHvY5
1sxtYdpUYst7+KGrdH97iPSFF+WTk4WJKQol5goKyIouRs1Yv28wr4zVZkz2dXkz
2nfxPuU2pkbFWmzz2bfqq7atwS+Qgc0x/vextSpECwaF+vSIRwNlyyMYA4ze1htf
1NUbPR26TJLwfYNtdZlv59rK+ykV/OBc15Fh4S9+9rDwcDHCenX05gWW3rbmsgxt
O2BiojPXSvj1eU8F0d3ClCaN5HFq54hQEf6TGoURBil4j1K2Q1mozktIbp1eSZ98
VuFTY45OD1q/LPMCCK0QhP3jtZ+q9wKuuYu8Pfvi7mBlZeuHJPiroOhr088lesGw
50i4k/iIESkrYsjtrMDmJwcBqTf+bfY0kqM8UehNzNROph/mlVIEdKz5PTAhgl7f
8RJ1lnbOx2v7bfrskI9OF5C3FoF9DIc6wI99Vxhfjbb+r0LrKsPBVjbxh7dolRff
C5XxZL6hqc/KYXlazw5O
=0pgw
-----END PGP SIGNATURE-----

--Lb0e7rgc7IsuDeGj--
