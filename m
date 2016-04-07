From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: fix dma transfer for vmalloced buffer
Date: Thu, 7 Apr 2016 10:57:48 -0700
Message-ID: <20160407175748.GY1924@sirena.org.uk>
References: <1458576021-4373-1-git-send-email-akinobu.mita@gmail.com>
 <CAC5umyj0zbwqt0Tmbubh0=URYvrvtWLO0q1ym1F2c7a84vRHjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mlvFMpb4NrD3AMcD"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAC5umyj0zbwqt0Tmbubh0=URYvrvtWLO0q1ym1F2c7a84vRHjg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--mlvFMpb4NrD3AMcD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 07, 2016 at 09:17:29PM +0900, Akinobu Mita wrote:
> 2016-03-22 1:00 GMT+09:00 Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:

> >                 if ((l & OMAP2_MCSPI_CHCONF_TURBO) && mcspi->fifo_depth == 0)
> >                         dma_count -= es;

> The actual transfer length can be smaller than xfer->len by above line.
> And the last word is filled after dma transfer completion.

> So this patch is broken.  Could you revert remove this from your
> development tree?
> I don't find a way how to fix it without copy and pasting a lot of
> line from spi core.

Can you please send a patch doing the revert and explaining why we can't
do this in the changelog?  That might help someone else looking at this
to figure it out in future, or at least stop them trying the same thing
and running into problems.

--mlvFMpb4NrD3AMcD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXBp+bAAoJECTWi3JdVIfQD34H/jvRDRdGqyOY+pxENMA1DW7U
+oGrqlcTzQST5tQpEj3nTIStjnNmeWCU0MLvYFfm+cyxYx6WPhl8Hsq/Xsr8hQRt
VwdU331q2tidS7/5+aSsDhxMEaF3Esx9APOlFGaCguCP36eRhPJAM4Dinx8S+vxl
jC3QlYStoZwO+XzSF+eAe34zKP1wzs23b/Q0DWoJmNWaTltyN0ocXTm8R+vDBuX4
Czz6OqQRcYc2+umw+S/Deys2gJCYqUC54yFM/R+JXdtFfIAG9XUnn3/koiaD2hFJ
Dq4qoW38GeoU7Bup62bVqpv02JGbkhBAU1O9H4ggfJ8M19L91oz8+UJnxNV1ias=
=Mlm6
-----END PGP SIGNATURE-----

--mlvFMpb4NrD3AMcD--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
