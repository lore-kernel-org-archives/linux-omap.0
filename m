From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Fri, 27 Jan 2017 20:12:47 +0100
Message-ID: <20170127191247.GC20571@amd>
References: <20170124175800.GA15070@amd> <20170124184526.GA25056@roeck-us.net>
 <20170125111233.GB3912@amd> <20170125120918.GA7936@pali>
 <1485481030.2469.15.camel@intel.com>
 <a6ce0873-9164-a965-a3e1-9eaaaec2201f@roeck-us.net>
 <1485488382.2469.27.camel@intel.com>
 <9146145b-7e21-c4de-a9cd-dad7bc74ee7a@roeck-us.net>
 <1485528033.2469.61.camel@intel.com>
 <20170127172039.GA2498@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3856001036334574465=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170127172039.GA2498@roeck-us.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, abcloriens@gmail.com, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, fabio.estevam@nxp.com, Zhang Rui <rui.zhang@intel.com>, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============3856001036334574465==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline


--iFRdW5/EC4oqxDHL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-01-27 09:20:39, Guenter Roeck wrote:
> On Fri, Jan 27, 2017 at 10:40:33PM +0800, Zhang Rui wrote:
> > > >=20
> > > > If thermal zone I/F is used, we can not change it's 'type' name to
> > > > be
> > > > compatible with new hwmon API.
> > > >=20
> > > You mean you can not fix the name to be compatible with libsensors.
> > >=20
> >=20
> > We can try to convert it to a libsensor-compatible string, either for
> > hwmon only, or for both thermal and hwmon. But this is an ABI change,
> > right?
>=20
> Let's go back to the basics.
>=20
> Fact is that the thermal subsystem registers hwmon devices with 'name'
> attributes which violate the documented hardware monitoring ABI.
> I think we can consider this undisputed.
>=20
> The rest is pretty much all opinion.
>=20
> Is a change in a driver to stop violating a documented ABI an ABI change
> or a bug fix ? In other words, does a driver violating a documented ABI
> make that ABI violation part of the ABI ?

It can be both. But "no regressions" takes precedence over
"documentation".

> Quite interesting questions. My take is that it is a bug fix, others
> apparently have the strong opinion that potential users of such an ABI
> violation have priority, and that a violation of a documented ABI _does_
> make this violation part of the ABI.

"Potential" users you can work around. "Real" users are problem.

And yes, I have strong opinion about release candidates. Outside that,
see my next mail.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliLm68ACgkQMOfwapXb+vJzLgCghD6Js6boy2DvwoCjrUxWygNM
IwQAn2qZk/EK8JBnxMecaKoZc7iYKzIi
=8UjF
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--


--===============3856001036334574465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3856001036334574465==--
