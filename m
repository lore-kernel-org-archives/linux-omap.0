From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/22] ARM: omap1: move perseus spi pinconf to board file
Date: Fri, 9 Aug 2019 13:01:37 +0100
Message-ID: <20190809120137.GB3963@sirena.co.uk>
References: <20190808212234.2213262-1-arnd@arndb.de>
 <20190808212234.2213262-8-arnd@arndb.de>
 <20190808222408.GS3795@sirena.co.uk>
 <CAK8P3a0qTvDFMj4GrKfD=2mkPpKN=eRJ--mp0r7mqAH+b2r=kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8666528492479128516=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK8P3a0qTvDFMj4GrKfD=2mkPpKN=eRJ--mp0r7mqAH+b2r=kg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Boris Brezillon <bbrezillon@kernel.org>
List-Id: linux-omap@vger.kernel.org


--===============8666528492479128516==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 09, 2019 at 01:29:13PM +0200, Arnd Bergmann wrote:
> On Fri, Aug 9, 2019 at 12:24 AM Mark Brown <broonie@kernel.org> wrote:

> > On Thu, Aug 08, 2019 at 11:22:16PM +0200, Arnd Bergmann wrote:
> > > The driver has always had a FIXME about this, and it seems
> > > like this trivial code move avoids a mach header inclusion,
> > > so just do it.

> > This appears to be part of a series but I've no cover letter or anything
> > else from it.  What's the story for dependencies and merging?

> Sorry for missing you on the cover letter. The patch is part of a series
> to make omap1 part of ARCH_MULTIPLATFORM. I'd like to merge the entire
> series through the arm-soc tree to avoid dependencies:

Acked-by: Mark Brown <broonie@kernel.org>

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1NYKAACgkQJNaLcl1U
h9D0Mgf/YWgKanEmJ6JDhVz0YRrbGtKA8AWG2fRI2pGeEytOfrDSw7hneA7X5s8z
h4/FRWERBh3ITDppRQSAK0n/A9qeD5rERsYSRCqAoMWMLKEkvuYwyCWwZQgdtH33
SNzuCxSqJYCuGS7xhq4K3rAm6f7xKmiZdznNEw85e5ko/vKsep9rvM/GypIE4eFH
q8p6nexDb6VAQrJoaq6APDLZxygD6QNvokmhM0rjgSpX7VIwBwuYJOKhO9+dwglw
9sQ/rq8KIuYpIWQ1idwf7c3NCGeJ9kbhjaHC31QhDZlSYRyV1mtmoocSCkU3Hg2D
rA7q8CGPt8k2fysNcaxG/yrZBUY4QA==
=ujey
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--


--===============8666528492479128516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8666528492479128516==--
