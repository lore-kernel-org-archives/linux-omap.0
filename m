From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: SPI regression in today's Linux next
Date: Tue, 17 Oct 2017 19:46:48 +0100
Message-ID: <20171017184648.pudjzcah7ywlloud@sirena.co.uk>
References: <20171017143454.GA4394@atomide.com>
 <20171017144021.r7aydswer7anb5ha@sirena.co.uk>
 <20171017145901.GB4394@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bxvci3muadliujcb"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171017145901.GB4394-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--bxvci3muadliujcb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 17, 2017 at 07:59:02AM -0700, Tony Lindgren wrote:
> * Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [171017 07:41]:

> > There's a fix already.

> OK so with next-20171016, revert 9ce70d49fa80 and pick
> 226584aedd from the spi.git tree. Seems to work for me.

Right, indeed - it'll appear in -next as soon as I've finished it for
today.

--bxvci3muadliujcb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnmUBgACgkQJNaLcl1U
h9BO2wf/VFuZD1JXoUX+LDxfANYB82pGFNYxOr7+lBUNvm7343U/reixq/ZVStgL
4OjBfB+M7V16RFqFV2u9NyGPid8Ilx8KHg/joq7tlOWAVdc4ksdAdw7s1K+TsHze
k74wXy41yPGub3WzBeyTvj1UGvM0EXcDb6izZH6Df+pTNJie3IzG03r0t1nG7+vL
y6pwJuHERrszO6fT65ih6L5T5HE3TsPbrXVBTZ8lrCcf0Y786vdIUIKuM4sH258C
yQe4P6W93xhM9QgrOMNmmwRnHg+BQ3j1kVulOB9gaCQEtS2aELSTBo6COhMyuDSg
gv25b+stsQbCDHVD4jw1HLoV4joH4w==
=h60B
-----END PGP SIGNATURE-----

--bxvci3muadliujcb--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
