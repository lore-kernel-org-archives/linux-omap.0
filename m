From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Mon, 21 Mar 2016 15:53:47 +0100
Message-ID: <20160321145347.GA19391@earth>
References: <56EBD96A.8090505@ti.com>
 <1458306829.11841.2.camel@Nokia-N900>
 <20160318133641.GB16747@earth>
 <56EC0676.3000509@gmail.com>
 <20160318150404.GA30829@earth>
 <56ED12B5.9000103@gmail.com>
 <20160320051704.GA12934@earth>
 <20160321114521.GO2566@sirena.org.uk>
 <56EFF983.2050303@gmail.com>
 <20160321134515.GT2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160321134515.GT2566@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Mon, Mar 21, 2016 at 01:45:15PM +0000, Mark Brown wrote:
> On Mon, Mar 21, 2016 at 03:39:15PM +0200, Ivaylo Dimitrov wrote:
> > On 21.03.2016 13:45, Mark Brown wrote:
>=20
> > >No, if the voltage is variable we can't tell what the current
> > >constraints are without something telling us so we just don't vary the
> > >voltage until we're told to do this.  If we immediately lower the
> > >voltage to the minimum supported voltage that's going to break things.
>=20
> > There are constraints set by the board DTS. Isn't it reasonable the
> > framework to set the voltage to minimum voltage from the dts if the cur=
rent
> > set one is bellow it?
>=20
> Yes, if it's out of bounds for the constraints we should bring it
> up/down to the minimum/maximum (when copying people into a thread it's a
> good idea to explain what the problem you are trying to solve is,
> especially if you're throwing around bodges).

We have this regulator definition in omap3-n900.dts:

&vmmc2 {
	regulator-name =3D "V28_A";
	regulator-min-microvolt =3D <2800000>;
	regulator-max-microvolt =3D <3000000>;
	regulator-always-on; /* due VIO leak to AIC34 VDDs */
};

The regulator is enabled during probe, but the voltage is not
configured. The default reset voltage of the regulator is 2.6V.
So basically when the regulator is enabled, it uses a voltage,
which is out of the DT specified range.

We also have a second problem: If the system has been rebooted from
Nokia's stock kernel the regulator is left in STANDBY mode. Since
the mode is not configured during probe, it results in different
problems. According to my understanding it can be fixed trivially
by adding

&vmmc2 {
    regulator-initial-mode =3D <2>;
};

-- Sebastian

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW8Ar4AAoJENju1/PIO/qa52EP/AhoiLTRHmkeY9uFmpUrlJIq
jFTcf0yAwh2P8MPr+8yDoFLhFdkCDb+a8YqcpNU/Nv4KD7zyMhp0XB4aspbM6v9G
IgP9SPSzPNLUt/uuJpxOPHy/Rb2wZW9z+y9GoktzBtUsu5XQ91o81glTDP5fgLko
WFXlBFkifyJT/phTZqqfZ90kYARkFT9cyxjxw/r4NrYLKfSJb/nH/+6cHtXEoRaw
/GiYl6+PJl0s4F/1L7Y5mo3kqg34z3KbkZvv9DSGgzpKx+wf46+rn0v0hDyC1VkW
vMmpO5Bq4AAGHuF9NO/55IVy+3kGy/H4fbEjLyf5b8joACN4xcu8wNHjRsHfuwIk
2nQwOsNoyXJbE01eicOB5LFVBj3oxBlYOlIdpbqi83li7ZBtDaJ8AdSMTXXDHY2f
QTxyTdZKNJKlw0nHAoaeF6sREUR2Nt0OkQ+PP36MhL9Qn8ek92qajEiiyN20FwlU
ZTAiARWHhr6wxfY4H98l4jRkaTHqij3l5UYS2zgWf735gC4THZ9UNK2oa5cu4wOf
qAhftqD8+xH+20JtAQV/gkoDzrXya2oVQbYei/6fK2mlukJ0QQelEdLS8wm1k+LZ
XCVKzSeWT1J+z813KQLFWWUWzj0JAh/PzCtLEm7oH5DtjQIHAXRtP8qc2+dUNgWV
6lGmVvrRWPkDhWpTCSlO
=n//h
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
