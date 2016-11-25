From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: twl: drop of_match_ptr
Date: Fri, 25 Nov 2016 13:04:05 +0000
Message-ID: <20161125130405.rhk6njvgphu6l6ed@sirena.org.uk>
References: <20161125074900.7172-1-Nicolae_Rosia@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="suw7o74h5cxud5if"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161125074900.7172-1-Nicolae_Rosia@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolae Rosia <Nicolae_Rosia@mentor.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--suw7o74h5cxud5if
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 25, 2016 at 09:49:00AM +0200, Nicolae Rosia wrote:
> We can safely drop of_match_ptr since the driver
> depends on CONFIG_OF symbol

As with the previous patch I see no benefit here.  What's the reason for
doing this?

--suw7o74h5cxud5if
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYODbEAAoJECTWi3JdVIfQTFUH/2AwAS2gt2XFFxb1Ib9frHWD
3PTm5H5w/rTuU/PXCoISV2yW/6aJGn3xgYpoAxoNjGOJF+O4+g/Tvt0p3xmwq8Ad
+oX1Uwq6EBBJR8M10/v2QtQbQu2TIOF0TNMDTIfykwMXNfUQyiED7Z2jMX2sVxo8
/hDJ4U2YIrh+9AUf3VvBJuCodvfYN0GqDIQargEdkjp7QTmjWm12evq5FEkoOt8H
Gl7UpPtFretz8LaiC92jGDn+npy6ICLAxak2lBSAgNeLvsoSlEdsYkAKdg5x147l
y0y/L7XnZA2gKc+6X44vmBeay05pCOyZqYEcwJy13U0H09sSuMuH3dwiY0Ab3ps=
=mCRi
-----END PGP SIGNATURE-----

--suw7o74h5cxud5if--
