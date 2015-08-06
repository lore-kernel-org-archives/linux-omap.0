From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
Date: Thu, 6 Aug 2015 19:20:29 +0100
Message-ID: <20150806182029.GD20873@sirena.org.uk>
References: <20150804155148.GR20873@sirena.org.uk>
 <55C0FD98.1090107@ti.com>
 <20150805115013.GJ20873@sirena.org.uk>
 <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
 <20150805124412.GN20873@sirena.org.uk>
 <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
 <20150806090202.GO20873@sirena.org.uk>
 <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com>
 <20150806102225.GI7576@n2100.arm.linux.org.uk>
 <55C35233.2000105@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/WOH3aHYQbLswZnX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C35233.2000105@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Michal Suchanek <hramrach@gmail.com>, devicetree <devicetree@vger.kernel.org>, Brian Norris <computersforpeace@gmail.com>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Huang Shijie <b32955@freescale.com>, MTD Maling List <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--/WOH3aHYQbLswZnX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2015 at 05:55:23PM +0530, Vignesh R wrote:

> 1.Write to flash config register via config port to switch to QUAD MODE
> (or any mode that flash supports).
> 2. Populate QSPI_SPI_SETUP_REGx with flash read command, number of
> address bytes to use and dummy bytes required.

These things being constant for a given flash?

> 3. Switch to memory mapped port by writing to QSPI_SPI_SWITCH_REG.
> 4. Now, its possible to perform read from 0x5C000000 to 0x5FFFFFFF using
> memcpy. The qspi controller hardware will communicate over SPI bus and
> get the data. This data is directly sent to RAM via SoC's interconnect.

Presumably if it's done via memcpy() it won't go direct to RAM but
rather be bounced through the CPU which is a bit interesting for
performance (it might help, but it does mean that there's a core stalled
waiting for the flash which might not be the best use of resources if
there's other things it can be getting on with).  With DMA it'd be a
direct to memory transfer though.

> Advantages of memory mapped port are: improved read performance,
> MEM_TO_MEM DMA support can be added (ti-qspi hardware as such does not
> provide DMA events).

DMA would definitely help here.

> I just need to know whether the user that requested the transfer is
> m25p80 driver. If yes, ti-qspi driver can take advantage of memory
> mapped interface, else just use config port to access SPI bus directly.

You don't *really* care if it's that specific user so much as that it's
that particular pattern.

> Writing separate driver based on spi-nor framework to interface with
> m25p80 is not an option because, I would lose the ability to interface
> with non-flash devices.

You could, however, expose an explicit flash mapping interface for this
functionality.  That does seem like it's going to be an awful lot easier=20
and help with keeping things like DMA support out of the driver and in
the core (which would be useful if there's other controllers with the
same functionality, I seem to recall that there are).

> The spi_message that is received in transfer_one_message() is too
> generic to imply the slave device that is on the other side of the wire.
> IMO, the read command does not imply that the slave is m25p80 flash
> (besides the read opcodes vary across vendors of m25p80 and across modes).

Again, it doesn't matter if it's actually a read command only that it's
got a compatible format on the bus.

--/WOH3aHYQbLswZnX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVw6VsAAoJECTWi3JdVIfQo5kH/jhi48J/GzyKzpi6siPcw1Zf
9XvGK+lnjE0cifv7vsMLqlSe5q+MHcBGFo0v2HJ3sGsNX2nROE7soj8TiLroee22
k6GYn0+k/5pNHEQ3eGjkOElD/GCmGGkSQkRkuvJDjj2gfsaQ2Qs2uH5jl6bkTdgM
9rNYnFJf/tVf1Ct4mQpjXuDJqX22+NZmE5HpWt7nnmZz/+WrUAqFuQfSaSoG7AVD
HCHBYHrj13/p5L5XfcMsTX+jHqsfuMVCJRhGtyfOOmzD/ftZczg8XNmp3KBRg3vd
k6/sGgTqhcV7uJDqlCxbhc/6nWddP9LuPG7CeadvSxNz+DXoh992m9BnKikv0UE=
=lR6+
-----END PGP SIGNATURE-----

--/WOH3aHYQbLswZnX--
