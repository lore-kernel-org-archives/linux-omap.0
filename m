From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Tue, 4 Aug 2015 16:51:48 +0100
Message-ID: <20150804155148.GR20873@sirena.org.uk>
References: <1438072876-16338-1-git-send-email-vigneshr@ti.com>
 <1438072876-16338-2-git-send-email-vigneshr@ti.com>
 <20150731181745.GM20873@sirena.org.uk>
 <55BEF4AF.5090704@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zYaYz6F2svGt3wno"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55BEF4AF.5090704@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Huang Shijie <b32955@freescale.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--zYaYz6F2svGt3wno
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2015 at 10:27:19AM +0530, Vignesh R wrote:

> @use_mmap_mode: Some SPI controller chips are optimized for interacting
> with serial flash memories. These chips have memory mapped interface,
> through which entire serial flash memory slave can be read/written as if
> though they are physical memories (like RAM). Using this interface,
> flash can be accessed using memcpy() function and the spi controller
> hardware will take care of communicating with serial flash over SPI.
> Setting this flag will indicate the SPI controller driver that the
> spi_message is from mtd layer to read from/write to flash. The SPI
> master driver can then appropriately switch the controller to memory
> mapped interface to read from/write to flash, based on this flag (See
> drivers/spi/spi-ti-qspi.c for example).
> NOTE: If the SPI controller chip lacks memory mapped interface, then the
> driver will ignore this flag and use normal SPI protocol to read
> from/write to flash. Communication with non-flash SPI devices is not
> possible using the memory mapped interface.

I still can't tell from the above what this interface is supposed to do.
It sounds like the use of memory mapped mode is supposed to be
transparent to users, it should just affect how the controller interacts
with the hardware, but if that's the case why do we need to expose it to
users at all?  Shouldn't the driver just use memory mapped mode if it's
faster?

--zYaYz6F2svGt3wno
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVwN+UAAoJECTWi3JdVIfQYvEH/AxbIEh4Z3wk0/fRXRwuE2N6
M8CdBC7sVqTzidzqFY1PyXOc8tHIxlYHUEEG9Fx/yC1oOW0NJNVV+8FOJj4HVC0N
unGPXMEH/PaBAZYAeaiGYUZg7sGzUVcAX2QqA594NJpcaG5stX/0wrcshiTBofEc
0ebxHQy9WAxvOUGhB0DJDn4m/j34+42krz+O2OI7nGMm2p/0G1r1EobuHejHCEyQ
i8cpQbdngVQYIUrhLtiGUSYppfC0qB70Nw97H0WXEaIuF9zQ4CtIsJpnAlCMKznw
BLF0obMgtKkOHqA9TyzrosVBzOb+EYjHkSQyWRs/tt/r+qwh+Qt8i06sq4gaQ7o=
=VgSn
-----END PGP SIGNATURE-----

--zYaYz6F2svGt3wno--
