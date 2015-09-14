From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] spi: introduce mmap read support for spi flash
 devices
Date: Mon, 14 Sep 2015 19:37:44 +0100
Message-ID: <20150914183744.GF12027@sirena.org.uk>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-2-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fC9kceC3Ynf/5ezY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441355402-6837-2-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, hramrach@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--fC9kceC3Ynf/5ezY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 04, 2015 at 01:59:58PM +0530, Vignesh R wrote:
> In addition to providing direct access to SPI bus, some spi controller
> hardwares (like ti-qspi) provide special memory mapped port
> to accesses SPI flash devices in order to increase read performance.
> This means the controller can automatically send the SPI signals
> required to read data from the SPI flash device.

Sorry, also meant to say here: as I kind of indicated in response to the
flash patch I'd expect to see the SPI core know something about this and
export an API for this which is integrated with things like the existing
message queue.

--fC9kceC3Ynf/5ezY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV9xP3AAoJECTWi3JdVIfQVdsIAIaKztku1w9l7oUknpHXmGwH
FpSTCB2fOR/Xc7hQAx547MKaa4GIa7F/ktQsNuDuBzxS67/zBa3gEdlizep+0yCB
AtLpKhEIsVADiVmstVEzHsbVCeNc2W7/gN+qd+Rh4F/xsEwwzeF1vTbuU1mNaX70
t4n0E6v24u+yVEzqEEhczoJ+4kbsIICPd4hgllVKrK0JLQtAT8BS9kmXOVajik9h
Ldkeoc5Njh1MaYhMZ0tCXfImEzo91zZHXMfUCtrParR47HKbEgXej//NuS4/PHC3
fLs6IGP0/o0JikbFCMzo77Sq3z2okfA6pfQ2sFa5EFbEaPJIHVu+H1S7YDlRrXs=
=p9SY
-----END PGP SIGNATURE-----

--fC9kceC3Ynf/5ezY--
