From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv5,
	5/5] ARM: dts: omap4-droid4: add soundcard
Date: Fri, 23 Mar 2018 15:11:07 +0100
Message-ID: <20180323141107.GB23658@amd>
References: <20180223200254.25685-6-sebastian.reichel@collabora.co.uk>
 <20180322204804.GA26871@amd>
 <20180322234832.o24ut5ahon46mdu4@earth.universe>
 <20180323100930.GA21644@amd>
 <20180323103006.alymgb3ywftb4gek@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2054007461423125893=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180323103006.alymgb3ywftb4gek@earth.universe>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


--===============2054007461423125893==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Any more ideas? :-)
>=20
> Make sure, that the device was not proped properly (cat
> /proc/asound/cards) and post the real error? :)

Oh and, audio now works for me, so

Tested-by: Pavel Machek <pavel@ucw.cz>

for the series.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq1CvsACgkQMOfwapXb+vKxXwCfTytipVc3xGXvXOwWxZs6IaIl
npsAn3MkVEAatodpRCjq0aXU5w39na7W
=83Zg
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--

--===============2054007461423125893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2054007461423125893==--
