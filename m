From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 1/3] ASoC: codec: cpcap: new codec
Date: Tue, 11 Jul 2017 14:13:31 +0200
Message-ID: <20170711121331.7q5bhfrylwwwyyte@earth>
References: <20170707164229.5868-1-sebastian.reichel@collabora.co.uk>
 <20170707164229.5868-2-sebastian.reichel@collabora.co.uk>
 <20170710175152.2jglyjezvptamreq@sirena.org.uk>
 <20170711051540.GV3730@atomide.com>
 <20170711104911.wmzmt5fjkzghwljz@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6527179532664384158=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170711104911.wmzmt5fjkzghwljz@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org


--===============6527179532664384158==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4tfxbgrb2biabhwv"
Content-Disposition: inline


--4tfxbgrb2biabhwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 11, 2017 at 11:49:11AM +0100, Mark Brown wrote:
> On Mon, Jul 10, 2017 at 10:15:41PM -0700, Tony Lindgren wrote:
> > * Mark Brown <broonie@kernel.org> [170710 10:52]:
>=20
> > > If this is part of a MFD shouldn't the parent device register it with=
out
> > > it needing to be in the DT?
>=20
> > Having the MFD core part just do devm_of_platform_populate() leaves out
> > dependencies between the MFD core and it's child devices.
>=20
> > There are also a lot of board specific configuration to be done for many
> > child devices such as ADC wiring, GPIO pins used, and macro firmware
> > usage.
>=20
> > Not sure what all board specific stuff needs to be configured for this
> > driver yet, but it seems at least the macro interrupt wiring needs to
> > be configured. I would not be surprised to find GPIOs or ADC being used
> > for some connector detection too.
>=20
> We can use subnodes without compatible strings, that's not a problem,
> but having to have compatible strings means we're encoding the way Linux
> splits device drivers up into the DT which might not work for other OSs
> or even future versions of Linux.  For example with CODEC drivers it's
> common to have a good chunk of clock control in there which we might at
> some point want to move over to the clock subsystem.

How is having a subnode without a compatible property different?
Sure we will bind the driver manually and make our code (a little
bit) more complex, but we still encoded the way Linux splits the
device into DT. My understanding is, that adding a node without a
compatible value is almost always not ok.

-- Sebastian

--4tfxbgrb2biabhwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllkwOkACgkQ2O7X88g7
+pqWdA/+JKo7S+MZtCH5vKEnPLPr2IIF5Nfsm8N+e9BzylE/3N1ZWT6/Vjfb0w7M
EpPWLGGT1zAOYFCV2ayx69uTeBarX4mjBFPlkZL/Rf6iDYuzmcKzuhXJSnZ6aAwr
s/txq4vm9TU7KCgGklla8st/4FsuqeeqS99RHFkEuY5sFXresW1T/xlRFue09sjp
GKo7QAzWyFbKqNWGKdMcETGHQ5/gXPLYHjaQVPH1AYLRDAG1DjO8M5z+DDNq9fiY
ro3BeFEdN1mCWraPI5B7Zp9awnXwJut0xKlCLDcpl8x/dmAFPV2GXMGDslN7zrBz
RUGz+oetfMFlcUnXwre1uWSJ4y/Vouwt3Q5Sd4ptAhZkNTE2H5nzT1j7VSFCHmRA
dcnSa1Tti0kpuDB49MO8QfZTRy937lEBZvV7JNTT3VSWkG5hsJotq87biOfmWfzH
fumO1Vsf03QKMtnsavQ3Ya+qG1ZFK2qN+C1h1pkh4wZNgsFrO7snOGTGZ4Y0KlsS
5dGhzlP5dOd0hdiTVp/i2YPNDAfduN79+v2aUZ58wGoBachcEJJ2dz2f60H01yJR
Jq5zbASShnB6XRWnRSjelDXHx9sfqx1ytku8RSvnx7SucRvUf6sO1YjT0YSQ6H6f
KLufghKamFzt5XLyDzRIMruo5Rhcp6t0tmIaJMk94Mj3yDaS0SE=
=qw1m
-----END PGP SIGNATURE-----

--4tfxbgrb2biabhwv--

--===============6527179532664384158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6527179532664384158==--
