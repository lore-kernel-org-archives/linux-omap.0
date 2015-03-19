From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Patch to parameterize DMA_MIN_BYTES for omap2-mcspi
Date: Thu, 19 Mar 2015 18:51:29 +0000
Message-ID: <20150319185129.GZ2869@sirena.org.uk>
References: <1426741501.10003.6.camel@midgaarde>
 <550AC256.4070509@ti.com>
 <CAAQQ3un3k-0nY8xaOXKbmCznOk69ZEhbWLd5ZZV1_=rQLOyspg@mail.gmail.com>
 <550AF7F6.7080200@ti.com>
 <1426786080.13824.23.camel@symus-gk-mint>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SqEPCaGsKgsesFh5"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426786080.13824.23.camel@symus-gk-mint>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg Knight <g.knight-+7FPL3kuI1+B+jHODAdFcQ@public.gmane.org>
Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--SqEPCaGsKgsesFh5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2015 at 01:28:00PM -0400, Greg Knight wrote:

> Changing DMA_MIN_BYTES to, say, "dma_min_time_ms" sounds reasonable to
> me. I don't know how to compute it completely accurately as some SPI

You probably need both - there's often a hard limit where the FIFO size
in the hardware becomes a limit for DMA as well as a soft limit on top
of that for performance reasons.

> implementations I've seen seem to like to inject little delays between
> bytes for some reason, but a reasonable enough estimate should just be
> spi_transfer_time_ms = (bits * 1000) / spi_clock_speed.

> I would like to have the ability to configure it without a kernel
> recompile, though. Would a kernel param (module_param) be acceptable for
> this application?

Exposing it as a sysfs or debugfs file might make more sense if you were
going to do this.  Is that required after merge though?  It seems like
this is something where we've perhaps been tuning the wrong parameter
(transfer size instead of runtime), or need to investigate dynamic
tuning.

--SqEPCaGsKgsesFh5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCxqxAAoJECTWi3JdVIfQ5McH/2f8kHC+aLzCMV8M8TCLNm9S
1ZbulLycQpi7apyTsEsCSfbpD587TNa4OD6fCBD+1b6XQEwR5FMQMII92O9CevhN
4TcvN6p8AX30ECI0ytuI7hW3baljybKRe/npNVBlMibiCv5eUDjdEwo6lu9nFCjf
zUu9sBCvIr5gFbX8uztNM+z0eImCMziFZq7T1HfPG0aEzjzpODd5JiWs5Gu9aRqE
2hSnEr3YMuRzloE1FpGGIQEX1hO/e27Hd+3a0+RVYag6Mosf6pXxbKbTm0dPsg0O
mxiaBAtYTFeLPvdjxo/01OcRw40KnkuwPttub7DBz/eD+WXPqNF4/xzWq5F5JmQ=
=mJVX
-----END PGP SIGNATURE-----

--SqEPCaGsKgsesFh5--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
