From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: edma: Add dummy driver skeleton for edma3-tptc
Date: Wed, 4 Nov 2015 22:11:20 +0530
Message-ID: <20151104164120.GO12910@localhost>
References: <1446470500-27504-1-git-send-email-peter.ujfalusi@ti.com>
 <87egg54td4.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xaMk4Io5JJdpkLEb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87egg54td4.fsf@saruman.tx.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, nsekhar@ti.com, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org


--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2015 at 10:33:27AM -0600, Felipe Balbi wrote:
> Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
>=20
> > The eDMA3 TPTC does not need any software configuration, but it is a
> > separate IP block in the SoC. In order the omap hwmod core to be able to
> > handle the TPTC resources correctly in regards of PM we need to have a
> > driver loaded for it.
> > This patch will add a dummy driver skeleton without probe or remove
> > callbacks provided.
> >
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > Reported-by: Olof Johansson <olof@lixom.net>
>=20
> This fixes the problem I also reported on linux-omap [1]
>=20
> Tested-by: Felipe Balbi <balbi@ti.com>
>=20
> [1] http://marc.info/?l=3Dlinux-omap&m=3D144665429032014&w=3D2

Great, I was about to point you to this series, I will push this in -next
now

Thanks
--=20
~Vinod

--xaMk4Io5JJdpkLEb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWOjUwAAoJEHwUBw8lI4NHFuMP/1gAzmXLyjO44dPG/ZlF1uuT
/AdOZ7MFuICWUtRoqD2CorhwSGo8tDv4aAgFBrI0lz3j99XwP/RnpcBzA0KQy6ci
I4emMJyLTm+JXfsT94kP867t6MgwHfxdIDRTCKArITt42jlXv2OeIwCaXE/ODk0u
lTM4mtXNfEWYkwxiaxbHLDI+gdNzl58vSgQNZl2C8mNShXfIjF4qq2WjvgVVKWpy
NTQn89pe19qDXhh2EuSbtqOjRiALOgpbcd1j8glc+mlgt6tT3wXtlr/Gbv0r2u5z
Wpjtt9jATeKL+NkKbVPy54buBCDSaMHpeAj/vQltt2kVhbxD10ypcJEjU1bo63d0
0KkazQ3xNe8go2DHms7XdDY8s5J+MS0nyS57HJ/RUwL/sUROU2YTBOLwDYMpr8Ox
PjhZ0IQOfq9L/SfI4CRpEcM819A/hQ8tL7w5W+dz+aMIJs4R2fmeiJ6yQkdKvgHv
+X4ZaE9+mraqfmDfvkPG5v88N7jf1kvVXDIAFrE7rWYIhrfStzU/Qo1sEZsnsYNB
hyQu+XnGIQPhoI8FLbDRAEoMLGVVTB7KqxZK6erv4UZWHfJB+jAO2a48P0Kqe2Sy
28RRva9eNfHziiqiJ5IMAwjXzN4pVAAh3yDub+UOziHCaP3KcnE6rb4fwwJUZpYI
bMUnn8OSHPz2om4weI0B
=rznI
-----END PGP SIGNATURE-----

--xaMk4Io5JJdpkLEb--
