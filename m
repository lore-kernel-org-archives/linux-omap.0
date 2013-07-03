From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 4/8] wl12xx: use frequency instead of enumerations for
 pdata clocks
Date: Wed, 3 Jul 2013 17:16:59 +0300
Message-ID: <20130703141659.GQ15056@arwen.pp.htv.fi>
References: <1372860209-3504-1-git-send-email-coelho@ti.com>
 <1372860209-3504-5-git-send-email-coelho@ti.com>
Reply-To: balbi-l0cyMroinI0@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2644334406137520323=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1372860209-3504-5-git-send-email-coelho-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>
Cc: nm-l0cyMroinI0@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============2644334406137520323==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OrT4iOlIQZp3kw4S"
Content-Disposition: inline

--OrT4iOlIQZp3kw4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2013 at 05:03:25PM +0300, Luciano Coelho wrote:
> Instead of defining an enumeration with the FW specific values for the
> different clock rates, use the actual frequency instead.  Also add a
> boolean to specify whether the clock is XTAL or not.
>=20
> Change all board files to reflect this.
>=20
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Luciano Coelho <coelho-l0cyMroinI0@public.gmane.org>

Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

--=20
balbi

--OrT4iOlIQZp3kw4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR1DJbAAoJEIaOsuA1yqRER88P/i1Fbl2whPLiblQ/ycn8nTTs
YZM0bfxn7SXd9KRpR85jCB95iLdArWQAJRlCulgjGoGtRXbup1rGxbOVP7XqmbUl
Fr16lrVqAL+65JO8uh9p6Hkv59qFwytrHeOFNzHcR27W/JxKMgS6oZyu5lfOD1q2
ED0T0B4A0ONCn6v4+xIv6P7XCeuZgVTMFsTreGuMfeQpc4HSvcgp+SGwNGzKkl78
xn0It10iWyCna0gHYti700TfpX/Qv2qZoSpx8KqASgg+Y+6MvXDmv7KFaa+10xM8
iwMgwE2cwBv6TXcAKr+N4RdnAx25vAI/feqnds16Avcy+8tIqaLq2vOy0sj2AWol
XRJTCJob//oZrHG05GOiTQwfW44NxwMwAtmWQ28+hhVGt2UjkIT15VYI8PUDPrGT
sni4/pL78hndm+370PNCJT2KMuC5P6M5vqmNq/RI2+stBuHTUXqWCviQuiDJfTC3
wnLhxE4J04NNRjjFIRyulCj7iv84sQWUM2A4JsPxCYLTxNdy3A9bxJnujBZ6pYmH
hoZKo94ozIZIgT5cGUM2N9Ukw6u0VV5o8kEg8plgJMkdVXKlBEtDE/WKzvdWHim3
d3HXhVLHwGn1oDpWpTf/+/BMK/cmHdUWV4KzloO1niXhZk6SCiyfuOi5/D1JeYGp
uVCyQ5aJeVjqHE4eUKJ/
=z0st
-----END PGP SIGNATURE-----

--OrT4iOlIQZp3kw4S--

--===============2644334406137520323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2644334406137520323==--
