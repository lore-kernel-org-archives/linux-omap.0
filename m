From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3 2/6] dt-bindings: sound: add motorola,cpcap-audio-codec
Date: Wed, 26 Jul 2017 12:48:28 +0100
Message-ID: <20170726114827.pye3jm2b7x2nqo5v@sirena.org.uk>
References: <20170725151030.26863-1-sebastian.reichel@collabora.co.uk>
 <20170725151030.26863-3-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o5iifoliloomo6zz"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170725151030.26863-3-sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--o5iifoliloomo6zz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 25, 2017 at 05:10:26PM +0200, Sebastian Reichel wrote:
> Motorola CPCAP is a PMIC with audio functionality, that can be
> found on Motorola Droid 4 and probably a few other phones from
> Motorola's Droid series.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

> +&cpcap {
> +	audio-codec {
> +		compatible = "motorola,cpcap-audio-codec";
> +		vdd-supply = <&vaudio>;
> +	};
> +};

I'd expect supplies (especially generically named supplies like this) to
be looked up at the chip level - aside from my general concerns with MFD
subnodes like this in the case of supplies it's especially problematic
as it makes it harder to do the generic chip level hookup in the DT and
it precludes other parts of the chip using the same supply (which seems
especially likely with a generically named supply like this).

--o5iifoliloomo6zz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll4gYsACgkQJNaLcl1U
h9BCmgf/R4AwjM6YPKKHbFIyOvTJZVM6XeLdYKAQ83CNWXOk/qdASb80MFx8pEgQ
eRaNSoVLdeMkPMEiZXaGXpKnkGx9Dv+2nKYQ+9yjaPQhyyuKhHUyoyVWL0HUFfW0
E1bBkq9xRdUwZaeN+Xt+zULOkh9QH5Uq8l3W6lC8GowBvlkDHKXhfpoKHu0tLGln
zJevWQDlBN1sXqt1KZtDS7BSsoqjpnqyLuwRzkd8evJBiNQPlQ8mEfOrRXhV6ftF
hCZneccaMnB1Mu13m4Gix+BGWrL37F17/Yi84usNeZ50abzNMLEn+LjP0DS99nyq
ObGGx9/HTYJKwW+YCMWGHovMk+QZ8w==
=TVoh
-----END PGP SIGNATURE-----

--o5iifoliloomo6zz--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
