From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: Fix sparse warning in
	be32_to_cpup() call
Date: Thu, 17 Sep 2015 10:22:29 +0100
Message-ID: <20150917092229.GO11268@sirena.org.uk>
References: <1442476977-4284-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3361085661062179566=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1442476977-4284-1-git-send-email-jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============3361085661062179566==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vxa5joy26gVGOrvU"
Content-Disposition: inline


--Vxa5joy26gVGOrvU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2015 at 11:02:57AM +0300, Jyri Sarha wrote:

>  	val /=3D sizeof(u32);
>  	for (i =3D 0; i < val; i++)
> -		if (be32_to_cpup(&of_slot_mask[i]))
> +		if (be32_to_cpup((__be32 *)&of_slot_mask[i]))
>  			*mask |=3D (1 << i);
> =20

There was no changelog and this is setting off alarm bells since the
cast just smashes warnings - are you sure we're not missing some other
annotations and that a cast is the best thing here?

--Vxa5joy26gVGOrvU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV+oZUAAoJECTWi3JdVIfQeV0H/3ws61qPG0hlrb0vdaqniexC
H2Q0iIBfA31S3R3d7lcNPbbiZeXvTxsH0dguTPmZTzdW3++qys4ZMqHu2o7KC65F
YiGd0nXpsx9gaYxGHeLWNdSgrfjBgA63JXHNGKr5341xFfteJRgI3W1fd1nfBp1Z
HAUI0BBiXV58bUwMGOt3Ro2MYIgR7GN8L1zlOg75uOHwji2h8VtAfcpqmNBuGC7G
doNiNA6bpo3CltamikipTse0x+zdM+0oVV53mwW1zAppcAtA8J+ELahacpA+ePrX
29BjV6E2C3qP5EriTKGoF/XGM8I1asOToMiZXtkGCJKRLaQgCP3QmDaK25VroDU=
=Qc0R
-----END PGP SIGNATURE-----

--Vxa5joy26gVGOrvU--

--===============3361085661062179566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3361085661062179566==--
