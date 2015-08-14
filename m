From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC v3 2/7] ASoC: hdmi: Remove obsolete dummy HDMI codec
Date: Fri, 14 Aug 2015 17:10:33 +0100
Message-ID: <20150814161033.GT10748@sirena.org.uk>
References: <cover.1439542916.git.jsarha@ti.com>
 <360a38c83ae2a24620da85b8496b745326d995de.1439542916.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="doRsZBpDQ+I4/+/t"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <360a38c83ae2a24620da85b8496b745326d995de.1439542916.git.jsarha-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, airlied-cv59FeDIM0c@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, liam.r.girdwood-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, peter.ujfalusi-l0cyMroinI0@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, moinejf-GANU6spQydw@public.gmane.org, rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--doRsZBpDQ+I4/+/t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2015 at 12:30:40PM +0300, Jyri Sarha wrote:
> The hdmi stub codec has not been used since refactoring of OMAP HDMI
> audio support.

grep tells me that the OMAP HDMI4 and HDMI5 drivers are still
registering this device in -next...=20

--doRsZBpDQ+I4/+/t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzhL4AAoJECTWi3JdVIfQA2sH/iRHy9tXvXl18WssR+F5ETe+
/Pav4+/qqNCsig/Z5Ngzn1OTfvV5dwKwBdPmk5TiApgWELW0itXuzYJykM+KurgO
oREX6GdJ0J9H24oA/MnwDXbuW1wIGlIv6o7kNu3hoMzD/tmtwPO9eco/hkGNrcWC
TOXEuodKAopae8G9895XSQdwPSLwOF4iNaK9iXnUjX5oRnDV9lATml4jGtYVB+v3
IjPxrZKCyr8Z7wLPUBmkodYN9Cej+DUWrf7BuWZz5J6AObmCtEEGzbFoRnZA/E/2
VFHF9pTJhv8q0+VTZCxRl/xOJCim9jL8jRAV6LzQcg0uLPNIVMMVZuEcyFZuBbI=
=+jMr
-----END PGP SIGNATURE-----

--doRsZBpDQ+I4/+/t--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
