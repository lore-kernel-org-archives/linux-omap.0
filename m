From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2] arm: dts: gta04: add gps support
Date: Thu, 31 Jan 2019 17:41:03 +0100
Message-ID: <20190131174015.544a00f3@kemnade.info>
References: <20190129073843.14979-1-andreas@kemnade.info>
        <20190130090434.GM3691@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vgmloT8=KlyDOyf+POR3ria"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130090434.GM3691@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-omap@vger.kernel.org

--Sig_/vgmloT8=KlyDOyf+POR3ria
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Jan 2019 10:04:34 +0100
Johan Hovold <johan@kernel.org> wrote:

> On Tue, Jan 29, 2019 at 08:38:43AM +0100, Andreas Kemnade wrote:
> > The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
> > which one is mounted so use the compatibility entry for w2sg0004
> > for all which will work for both.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > Changes in v2:
> > - some s/gps/gnss/
> > - not added vcc-supply because the regulator is not modelled
> >   in dts at all =20
>=20
> I strongly suggest not sending revised patches before people have a
> chance to comment on your previous version and resolve any issues that
> may have been raised.

for technical check there was already some small team review ahead,
so I expect only formality issues and not something complicated and
was not mentally prepared for more discussion.

At that point I had the impression that I am not allowed to have
such driverless things into dtb, so I had the impression that I have
to follow two conflicting rules at the same time.
That leads to the impression that I worked a long way into a dead end
which made me quite angry so I was not as contructive as I should be.

Regards,
Andreas

--Sig_/vgmloT8=KlyDOyf+POR3ria
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlxTJR8ACgkQl4jFM1s/
ye/4WxAApY3EPVu2dFHryhqT6YYsMDk+N6f2ERAo9HcBNIbOPGiz6FshPM7OygZU
cpK/MUzxU/9Arar1F5zn31BfmQhsFlAEfyk5YLTq1k6qkCwkKcOQfeQT5eOvTh5w
qJLJKGlQVX3nUz6gbANxUsRS9zhPrfbYjuI/lkEesOANXl95wBgTxouQb1TSK3Qz
csKxCMXYAe2xEfaUcaC/bTPMSuxBCdra3O8o4m1rbMwc4cOihSUcuisKSkhv3402
IBK3S4ctKd5UCaxmaEum90rjGkQ6l56EjJVrKC2L9IyrqA5pv9aet7ei4fS59NHg
ciF9gjtw3eeqVM52byHQv5pv+enQE+y74wVuOr1BTUVHe3Uon8Io7JLWJ0aaSe3w
ob3L66BYsqaR/Ub4J/TM4PGDXwTHNhpCGx2XayyDuGqPqiMWL40A8NEWSYQAfem8
BUKT18OrjmUZjKu5vdqm3nzMqL/7L5Cm0jUGl1FWBPajNZbTBaSRSQxhjDzJTSuu
B1vwirWlPelzFwtpy1cfcyVt5z8LVInQU3518EJJRwDohDuTkpKCjsO9SVT13FRw
8t3/jAk9paA2SIOPZtRJvhHw0pUDsvMqoRQr3qqcamp3GAC/2MpzgDWDjjMN/7US
3M0i/neoH3f1gP8uIppD7ScNlwLgTOHtz0w5bhPV3rvZF2ZGr+0=
=2Hfv
-----END PGP SIGNATURE-----

--Sig_/vgmloT8=KlyDOyf+POR3ria--
