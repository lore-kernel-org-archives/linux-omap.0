From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/2] mtd: devices: m25p80: Enable spi-nor bounce
 buffer support
Date: Fri, 3 Mar 2017 12:50:07 +0000
Message-ID: <20170303125007.xekpiyvvvfgwto6p@sirena.org.uk>
References: <aa967f6a-0526-3e33-1de7-fbe7d4264f34@nod.at>
 <8f999a27-c3ce-2650-452c-b21c3e44989d@ti.com>
 <aeaf87ca-e8f5-72d0-997d-494df86abf68@atmel.com>
 <a6c61bf7-1f26-41db-9a6b-bcae87274cb9@ti.com>
 <20170301175506.202cb478@bbrezillon>
 <09ffe06d-565d-afe8-8b7d-d1a0b575595b@baylibre.com>
 <4cd22ddd-b108-f697-0bde-ad844a386e62@ti.com>
 <20170302152921.1c031b57@bbrezillon>
 <20170302170041.hfix33mhzgqydmvh@sirena.org.uk>
 <20170302204900.2ab4bf65@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0025993703843556284=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20170302204900.2ab4bf65@bbrezillon>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Frode Isaksen <fisaksen@baylibre.com>, linux-omap@vger.kernel.org, Vignesh R <vigneshr@ti.com>, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============0025993703843556284==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="orjnje3x2lgg3nh7"
Content-Disposition: inline


--orjnje3x2lgg3nh7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 02, 2017 at 08:49:00PM +0100, Boris Brezillon wrote:

> 1/ for big transfers, dynamically allocating a bounce buffer on demand
>    (and freeing it after the DMA operation) might fail, or might induce
>    some latency, especially when the system is under high mem pressure.
>    Allocating these bounce buffers once during the SPI device driver
>    ->probe() guarantees that the bounce buffer will always be available
>    when needed, but OTOH, we don't know if it's really needed.

Yeah, but then the bounces are going to slow things down anyway.  This
does seem fixable if we do something with caching the buffer once we
create it, and if it's implemented elsewhere the same problem will
exist.  We can't just allocate the maximum possible buffer size because
some devices have effectively unlimited transfer sizes so you could
waste huge amounts of memory, especially in the common case where we
don't use vmalloc() at all.

> 2/ only the SPI and/or DMA engine know when using DMA with a bounce
>    buffer is better than using PIO mode. The limit is probably
>    different from the DMA vs PIO mode (dma_min_len <
>    dma_bounce_min_len). Thanks to ->can_dma() we can let drivers decide
>    when preparing the buffer for a DMA transfer is needed.

I'm not so worried about that, the numbers are basically an educated
guess anyway.  It's a concern though, yes.

> 3/ if the DMA engine does not support chaining DMA descriptor, and the
>    vmalloc-ed buffer spans several non-contiguous pages, doing DMA
>    is simply not possible. That one can probably handled with the
>    ->can_dma() hook too.

Anything that doesn't support chaining is in trouble already (or should
be soon hopefully), but mostly the controllers will have no idea about
that as they're just asking their DMA controller to do things.  We'd be
better off having the core query the capabilities of the DMA controllers
directly.

> >  The suggestion to pass via
> > scatterlists seems a bit more likely to work but even then I'm not clear
> > that drivers doing PIO would play well.

> You mean that SPI device drivers would directly pass an sg list instead
> of a virtual pointer? Not sure that would help, we're just moving the
> decision one level up without providing more information to help decide
> what to do.

I think the idea was to ensure you only use one mapping type at once.

--orjnje3x2lgg3nh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAli5Zn8ACgkQJNaLcl1U
h9CTXAf+Lu3iYHxq+1CUTFPDcoKroaC9B1Mhpj3vG1ZON/K+ZUjtd4kGF/tGQLDk
yYu6zqv7KgeDvmet4WirUwuFXzirtExPAyJmTAz4Hgc/vc2mJr9owcjzsrdIZAIY
rIAKRR17qCrbebKJPivvgMANgyMHX8yqoeeHQu1dLdPJmqhokUdLvjr800oTHK7q
cm+uAqkzbhYIUBrkutYG3SYFoTy/m1+8b2B6Fpl+yIBkVumGpKSxqehTouP2jtmh
cku0qICvexRBUntESgU5XQo8A6uocElEu00+QWbDS3xXWM08F04+GgXNCCz+kyFl
wTY/hjjj8i5Zo6IeOM1G35pfZ65blg==
=gugT
-----END PGP SIGNATURE-----

--orjnje3x2lgg3nh7--


--===============0025993703843556284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============0025993703843556284==--
