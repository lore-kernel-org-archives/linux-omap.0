From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/2] mtd: devices: m25p80: Enable spi-nor bounce
 buffer support
Date: Wed, 1 Mar 2017 15:52:09 +0000
Message-ID: <20170301155209.bohcksub6ahhrevu@sirena.org.uk>
References: <20170227120839.16545-1-vigneshr@ti.com>
 <20170227120839.16545-3-vigneshr@ti.com>
 <aa967f6a-0526-3e33-1de7-fbe7d4264f34@nod.at>
 <8f999a27-c3ce-2650-452c-b21c3e44989d@ti.com>
 <aeaf87ca-e8f5-72d0-997d-494df86abf68@atmel.com>
 <a6c61bf7-1f26-41db-9a6b-bcae87274cb9@ti.com>
 <8a2c9b3b-dd5f-fca7-fa5c-690e5bed949f@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cq3rmfw4qyxojziq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8a2c9b3b-dd5f-fca7-fa5c-690e5bed949f@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: Vignesh R <vigneshr@ti.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Frode Isaksen <fisaksen@baylibre.com>, linux-spi@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--cq3rmfw4qyxojziq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 01, 2017 at 03:21:24PM +0100, Cyrille Pitchen wrote:

> Besides, some SPI controller drivers may already use their own bounce
> buffer for other reasons. Then for those controllers, it would be one
> more copy.

They probably shouldn't, there's a lot of legacy drivers that do all
sorts of fun stuff but if people are having performance problems we
should probably be putting pressure on the driver users to improve
things.  Anything that has a bounce buffer probably isn't going to say
it can do DMA though...

> Then I don't whether we should:
> 1 -  extend in SPI sub-system API to tell us if the SPI controller can
> deal with non-kmalloc'd buffer for DMA transfers

I don't think we can tell any better than anything else really.  We
could tell if a driver has a bounce buffer or is PIO based but that's
not the whole story so it's not ideal.

> or

> 2 - get the answer at a system-wide level.

That seems better.  It'd be really good if we had a function we could
call that'd do the mappings including any bounce buffering that's needed
rather than having to think about it in the subsystems.

--cq3rmfw4qyxojziq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAli27igACgkQJNaLcl1U
h9At3gf9E9D98TLp2AltzHU7qQ8z7eek0DJ/JcFYfqVa6Lv8Xr6T57m+iuSPnB1P
c8Eb8QjEg4a7HnNODDlqHFAQkbGcl+XJBhBheWuqrFqWv6gzSYtRlHZMlqZFKPp5
wNluYMTQjMFqx2FJ3qa9y+ESOkgV0hl4X8/2PEXu4Z8yaAVC66GviXFYi5usfdTY
VRrVGDX03diQ7xpB//Ly23/1RykvZ/mkZdQYYpXaK6Lszh2D/TZFM2oJmPOjhYlM
VkhmMzpiJtBWA2N8wIU56bhHWM0thINX6nE/SO09sk6q+ZQdj+MxHqEFOMzmTBD5
EiTlN78kCmYHzQOXgloiI587eza1PA==
=lB5b
-----END PGP SIGNATURE-----

--cq3rmfw4qyxojziq--
