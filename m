From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/2] mtd: devices: m25p80: Enable spi-nor bounce
 buffer support
Date: Thu, 2 Mar 2017 17:00:41 +0000
Message-ID: <20170302170041.hfix33mhzgqydmvh@sirena.org.uk>
References: <20170227120839.16545-1-vigneshr@ti.com>
 <20170227120839.16545-3-vigneshr@ti.com>
 <aa967f6a-0526-3e33-1de7-fbe7d4264f34@nod.at>
 <8f999a27-c3ce-2650-452c-b21c3e44989d@ti.com>
 <aeaf87ca-e8f5-72d0-997d-494df86abf68@atmel.com>
 <a6c61bf7-1f26-41db-9a6b-bcae87274cb9@ti.com>
 <20170301175506.202cb478@bbrezillon>
 <09ffe06d-565d-afe8-8b7d-d1a0b575595b@baylibre.com>
 <4cd22ddd-b108-f697-0bde-ad844a386e62@ti.com>
 <20170302152921.1c031b57@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1829258472272304209=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20170302152921.1c031b57@bbrezillon>
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


--===============1829258472272304209==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dimhxuakwsly4kwb"
Content-Disposition: inline


--dimhxuakwsly4kwb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 02, 2017 at 03:29:21PM +0100, Boris Brezillon wrote:
> Vignesh R <vigneshr@ti.com> wrote:

> > Or SPI core can be extended in a way similar to this RFC. That is, SPI
> > master driver will set a flag to request SPI core to use of bounce
> > buffer for vmalloc'd buffers. And spi_map_buf() just uses bounce buffer
> > in case buf does not belong to kmalloc region based on the flag.

> That's a better approach IMHO. Note that the decision should not only

I don't understand how the driver is supposed to tell if it might need a
bounce buffer due to where the memory is allocated and the caches used
by the particular system it is used on?  The suggestion to pass via
scatterlists seems a bit more likely to work but even then I'm not clear
that drivers doing PIO would play well.

> be based on the buffer type, but also on the transfer length and/or
> whether the controller supports transferring non physically contiguous
> buffers.

The reason most drivers only look at the transfer length when deciding
that they can DMA is that most controllers are paired with DMA
controllers that are sensibly implemented, the only factor they're
selecting on is the copybreak for performance.

--dimhxuakwsly4kwb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAli4T7gACgkQJNaLcl1U
h9DkeQf+Je/mIX+uX365cUiNExxxlw3ghoWdng0aEQUX8yQqkakX2384XdrSynVq
HyiMRD0tOdSmnRJK3wjLtD+DinEpktUtlxs1y+hlckAJdLMQGDHiEJcMF4AU50rj
yaoPdW5N1o9UrmqEPleN72Eoau7VmwSOiA6LhpeZ+4wL1C8dT+BGZmaEQ9UV2GTX
vr2CcTureD11SrCYcKTU1uKG2nYdgiOo2S3GsveISWAcjowviFdEc3PZmW5BE0kp
E595bLWdEzhPIK2kuaVgqmz1rCpryuVtUVMQm3eOwWyY/LajrtVKY1CSxkMAQOIG
z2jGLojhxjbTr6tT0uDy31G3CSLJCg==
=abQ9
-----END PGP SIGNATURE-----

--dimhxuakwsly4kwb--


--===============1829258472272304209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============1829258472272304209==--
