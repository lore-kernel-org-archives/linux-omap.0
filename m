From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH RFC v2 0/2] Fix simple-card *-master DT
 parameter handling
Date: Wed, 12 Mar 2014 12:30:23 +0000
Message-ID: <20140312123023.GP28112@sirena.org.uk>
References: <cover.1394451329.git.jsarha@ti.com>
 <877g80rzgg.wl%kuninori.morimoto.gx@gmail.com>
 <CAHPCO9FmL__LmUyMRhsy2mnPNAV0h--aMY=GBJjL9TBrAqWSFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X5d84+NUkZX3FbP/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45342 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbaCLMaf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2014 08:30:35 -0400
Content-Disposition: inline
In-Reply-To: <CAHPCO9FmL__LmUyMRhsy2mnPNAV0h--aMY=GBJjL9TBrAqWSFw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Richard Lee <superlibj8301@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, peter.ujfalusi@ti.com, bcousson@baylibre.com


--X5d84+NUkZX3FbP/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2014 at 01:00:02PM +0800, Richard Lee wrote:

> But, IMO, if you want the CPU DAI be CBS_CFS and CODEC be CBM_CFM,
> you could just do it like this:
>          simple-audio-card,cpu {
>                  ...
>          };
>=20
>          simple-audio-card,codec {
>                  ...
>                  bitclock-master;
>                  frame-master;
>          };

> and vice versa.

> Thanks,

> (I could find this mails in my Freescale acount, so I will reply it here.)

Yes, that'd been what I'd thought the binding did (and it's what Jyri's
patch makes it do).

--X5d84+NUkZX3FbP/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIFNbAAoJELSic+t+oim9xXQP/30AiyGMsrU6iIKlmF+x56xd
BDcmTNdecYO2SrcY8MkFAZnHqR26gtE0H9QwVCrPXryFy/uICga3P645kvYcvaF6
c9PPvXX8+U+XOYht8fv3EKt1VBXydCMSQfCTvqJPYFWpS4A7AKzI0PCWX8jT20pf
4dDFl+YZ3XOqhuXGf1GvnFdm/se6CaJfJBAKvRXNmAI94Grl2XwChqsAkFydxvzc
Al803SwJMz4oNm1fmCiqniZdLWpPHVgkaKGZu0qshMbxwJgWPBndkQOtFPX9wbpC
NTURHfaXLlTXx04Abi7lgRREPk/qkPINkVdYN62vXBXSoacacGBjK0H7wF46jvHE
SoS+7RByiOSxTpb/Ua+Cej77eFe1CCdSJreH4jzFZQ45C8Ld+yAmmcnjJdURFg2A
HoVsTMIo6vdv9K+8Kc3pvZTDv45pJkwJcROw0pHsHzVU44bjv+iWnCxp9shW8Re+
EI9GEGxsephhvC82AIRivZ34AlVCQyUd4D7+n14GTb4N+ElgKD1ynDM7mUZ4xGrk
Up5xCsd6y6RfInCBbRP9+XOqx0hJHYkEYEsvzUf5CKW2oHJQ2gcGccm4S51vbobd
Br3Pa/XKcea4MNMBWAElgR2BAulClU9nXBFUkEL8dlbA+klCLHeuErUV8ncH0GlL
3WD4PAhcm0dxDsDgXKGu
=Dqwd
-----END PGP SIGNATURE-----

--X5d84+NUkZX3FbP/--
