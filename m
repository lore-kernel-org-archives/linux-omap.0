From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8.2 1/1] ASoC: omap-mcbsp: Add PM QoS
 support for McBSP to prevent glitches
Date: Thu, 2 Feb 2017 11:06:55 +0000
Message-ID: <20170202110655.vdqm6lwq3fyqhphc@sirena.org.uk>
References: <20170127225337.17830-1-liam@networkimprov.net>
 <20170201200742.28977-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5697705231466894107=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170201200742.28977-1-liam@networkimprov.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Breck <liam@networkimprov.net>
Cc: alsa-devel@alsa-project.org, Matt Ranostay <matt@ranostay.consulting>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Breck <kernel@networkimprov.net>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--===============5697705231466894107==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ixzf55zgjuk54z75"
Content-Disposition: inline


--ixzf55zgjuk54z75
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2017 at 12:07:42PM -0800, Liam Breck wrote:
> From: Matt Ranostay <matt@ranostay.consulting>
>=20
> We can get audio errors if hitting deeper idle states on omaps:

I already applied this, if there's any changes needed please send
incremental changes.

--ixzf55zgjuk54z75
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliTEs4ACgkQJNaLcl1U
h9ByEgf/d/PnOiXWw01nSTvTyM45p3/Sb++/BDooYW5p8Dnf1/fSKE/wwOcBTgcA
tHAcqCn4LIKKV8UdB0vi71Uqs+wIfcbczciUrKb8+SHiLIf0JS4uK2mCE9BUuNkD
lYDBdINy/3ABfXHYy4AS4JEMZJaUjzX7nKMbPhcVxwtL9lRrsumM1mibmk0/mJS9
03YzzysOlH2S6hQdrWFvw9R7F+RX4W69V1a8NREZgxEUK2Y+FR7QWvFda6sY7dyw
UprYoWtWNeK9A8yAmJ2VORYrXnYtkocO6lbg9JiOCC1UE6hnYKsAu2wR7e+F1qQS
j5YtpRBTHjWleTAEcgsm/yhWpZ0SUA==
=Cn7a
-----END PGP SIGNATURE-----

--ixzf55zgjuk54z75--

--===============5697705231466894107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5697705231466894107==--
