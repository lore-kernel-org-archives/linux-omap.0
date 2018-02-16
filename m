From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv4 2/4] ASoC: codec: cpcap: new codec
Date: Fri, 16 Feb 2018 14:27:16 +0000
Message-ID: <20180216142716.GJ5886@sirena.org.uk>
References: <20180214220741.28306-1-sebastian.reichel@collabora.co.uk>
 <20180214220741.28306-3-sebastian.reichel@collabora.co.uk>
 <20180216113901.GC5886@sirena.org.uk>
 <20180216135113.akicejkodhbjpp2w@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cN519qCC4CN1mUcX"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180216135113.akicejkodhbjpp2w-SfvFxonMDyemK9LvCR3Hrw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--cN519qCC4CN1mUcX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 16, 2018 at 02:51:13PM +0100, Sebastian Reichel wrote:
> On Fri, Feb 16, 2018 at 11:39:01AM +0000, Mark Brown wrote:

> > We don't have default lines like this for other MFDs...

> Is there a reason not to add them? It looks very useful to me:

Consistency.  It's a lot easier to apply a single rule to everything
than it is to have to individually think through and discuss the
decisions on every individual driver, especially when there will
inevitably be some cases where there are conflicting requirements from
different users.  As you said in the rest of your mail hand configuring
kernels is already a very specialist thing at the best of times.

--cN519qCC4CN1mUcX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqG6kQACgkQJNaLcl1U
h9AoCgf8CQYEgUAvlLn8toKeaZlwqe64eR8eKRYIUVGLT6JyPh9GGPFh3I7JhPgV
fMakHQyW/Vw6OGthmS76ziyoAifgwww89o07qxjoOvJfnuVy2M1/wdaIcCOFfQZN
hcLxYd6NnsoXBbIXuDWPSUWaxEUc9N7uH6fNeZFppv6DjEYaI+bunj/dTCJxvVnC
5Q3R/+dVEoEEdK1Q41N3sjPypgjZc7D8xP+wXcmix9CBN7yZsBmJJMSCnfK214VD
MXv8u0ahaR4SVTq7LeBUeQtFp7cW1y72BeAAZ+uQSb6iPxuE58OlInneT6uLc+B8
MYWeCW5cs79YSTGAQuxomCRerXUAOw==
=qpom
-----END PGP SIGNATURE-----

--cN519qCC4CN1mUcX--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
