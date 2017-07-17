From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 3/6] ASoC: codec: cpcap: new codec
Date: Mon, 17 Jul 2017 16:21:30 +0100
Message-ID: <20170717152130.hvch7fuw655xpfq5@sirena.org.uk>
References: <20170712151846.24621-1-sebastian.reichel@collabora.co.uk>
 <20170712151846.24621-4-sebastian.reichel@collabora.co.uk>
 <20170717092928.GH10026@atomide.com>
 <20170717141808.qsh2di4dzgirqiij@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hvlqovgsavkodh6q"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170717141808.qsh2di4dzgirqiij@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--hvlqovgsavkodh6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 17, 2017 at 04:18:08PM +0200, Sebastian Reichel wrote:
> On Mon, Jul 17, 2017 at 02:29:29AM -0700, Tony Lindgren wrote:

> > Should it also have depends on SND_AUDIO_GRAPH_CARD?

> The codec does not depend on audio graph card. You can
> also use it with (deprecated) simple card or a custom
> written one. In case of a custom written one it would
> make sense to add a dependency from the custom written
> one to SND_SOC_CPCAP. So I think we should not add such
> a dependency.

Right, the dependencies should go in the opposite direction.

--hvlqovgsavkodh6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlls1fkACgkQJNaLcl1U
h9DN1gf/VA1Ex0YDxPOKEH39+wuT6YokjrF9UC91dOGivT7oLX6b6LL7Z971vujW
NvD4fEH4+nPiJXalI9J1NM8Y4uKh4ChgGGY1lXu3Ev6xrGGdEZhbYVUSR7ny5bM0
Y/FaUuBmEhwm6ZWqHFEBGCTlwJG7Xq+8zMJw9+0HDyOl+w9qAPDomDXoNsi3eWxN
Ac9/jmKN43mb81BEUn1tj49LAwqFhln9O4lQt858JAjzucq6dk++nFHIvLaL/FfP
LVoY4Sb1OmgroLUc5h4axYy9Ay8EsGIScsbGHDq7nzHZYUzPgLp6IdLhALNmnsxU
rIlXFH6r7sFzYC5eV3nMYeXxblpZ1A==
=FNYw
-----END PGP SIGNATURE-----

--hvlqovgsavkodh6q--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
