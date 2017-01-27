From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Fri, 27 Jan 2017 20:29:09 +0100
Message-ID: <20170127192909.GD20571@amd>
References: <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
 <20170124175800.GA15070@amd> <20170124184526.GA25056@roeck-us.net>
 <20170125111233.GB3912@amd> <20170125120918.GA7936@pali>
 <1485481030.2469.15.camel@intel.com>
 <a6ce0873-9164-a965-a3e1-9eaaaec2201f@roeck-us.net>
 <1485488382.2469.27.camel@intel.com>
 <9146145b-7e21-c4de-a9cd-dad7bc74ee7a@roeck-us.net>
 <1485528033.2469.61.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5236796423291867187=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1485528033.2469.61.camel@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, abcloriens@gmail.com, Guenter Roeck <linux@roeck-us.net>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, fabio.estevam@nxp.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============5236796423291867187==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > That sounds like fun. Changing bq27200-0 to bq27200_0 is
> > > > Forbidden by
> > > > the ABI Police, but taking the entire device away is ok.
> > > >=20
> > > No. IMO, it depends on if the interface is used or not.
> > > If hwmon I/F is used, we can not take it away, nor change its name.
> > Even if the use doesn't depend on that name ?
> >=20
> when I said "the interface is used", I mean the name string is used.
> > >=20
> > > If thermal zone I/F is used, we can not change it's 'type' name to
> > > be
> > > compatible with new hwmon API.
> > >=20
> > You mean you can not fix the name to be compatible with libsensors.
> >=20
>=20
> We can try to convert it to a libsensor-compatible string, either for
> hwmon only, or for both thermal and hwmon. But this is an ABI change,
> right?
> And my understanding about the ABI change is that, if no one cares
> about it, we're okay, or else, this is a regression, and we need to
> fall back to the previous ABI immediately. In order to change it in a
> long run, we need to make a note in Documentation/ABI/, and change it
> sometime in the future (a couple of release cycles or even more).

If no one cares, you can get away with the change. So I guess that's
what we should try. In -rc1. We should _not_ do "this changes in 2
years" dance, as that would increase chance for someone to use the old
name.

So I guess changing to libsensor-compatible name in v4.11-rc0 (maybe
with note in the ABI documenation) is the best plan. If someone
complains, we'll have to revert and think about something else.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliLn4UACgkQMOfwapXb+vICqQCgmGgcXiiAVA4OtoLrEY48BKK0
qdcAoKRSxfuviDTNJ6GT9drWB+J6Fdgv
=1PfG
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--


--===============5236796423291867187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5236796423291867187==--
