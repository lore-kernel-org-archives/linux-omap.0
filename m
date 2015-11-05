From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/5] spi: introduce mmap read support for spi flash
 devices
Date: Thu, 5 Nov 2015 15:29:43 +0000
Message-ID: <20151105152943.GP18409@sirena.org.uk>
References: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
 <1446545174-14193-2-git-send-email-vigneshr@ti.com>
 <20151104143915.GI1717@sirena.org.uk>
 <563B4BB0.9020206@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1LW0Rr0Uq98qh6Rv"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <563B4BB0.9020206@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Michal Suchanek <hramrach@gmail.com>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--1LW0Rr0Uq98qh6Rv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2015 at 05:59:36PM +0530, Vignesh R wrote:
> On 11/04/2015 08:09 PM, Mark Brown wrote:

> > It's a bit worrying that this doesn't sync with the message queue except
> > via the mutex: this means that we might be out of order with respect to
> > any asynchronous transfers that are happening on the device.  I'm not
> > sure that this is a practical problem, though there is some risk of
> > unfair scheduling that would have to be under extreme load and it might
> > make sense to prioritise reads anyway.

> Since mmap interface is used only by mtd flash drivers and since almost
> all mtd flash devices use synchronous transfers (spi_sync()), IMO, there
> wont be out of order problem wrt mtd flashes.
> But mmap read might delay transfers queued for non mtd flash devices. It
> is difficult to wait for all transfers already queued to be pumped out
> by __spi_pump_messages() and then do the mmap transfer. Do you have any
> thoughts on how to sync with message queue?

Like I say I think it probably doesn't matter.  The main issue would be
with other devices sharing the bus with a flash chip.

--1LW0Rr0Uq98qh6Rv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWO3XmAAoJECTWi3JdVIfQ8H4H/3upAPiXLF/N9hkvlFj/e0Da
K8r42KaKguWp+Y3ERjZgOx+Y/KBHfR3yj/ugXa6pi+yqPx48AxB3m0bxQp9dENK8
qTzW9/paC7WWZCM9ShGZQoMvhLvqQZbzjxDkofQz43WBv4P+SC+6rJSSJrENe7KK
zg8rZCRtGpSQcJp7W113ugTkr81cri9DtCv9mYDUADHgfmJFA2k7Oa6QExN5I91d
duuFw09PJV6ajNwY2lA7LF+2OJLyTkE+WGoQq5fet9+7HDi0ronHcVBk9GnCCnu/
EJ4zsJ7PplNUAuTKwRGM8HfEzLee1UVRx40BDyz8LKXGAs9NygPpuobv8K3jTAY=
=UrfS
-----END PGP SIGNATURE-----

--1LW0Rr0Uq98qh6Rv--
