From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Fri, 27 Jan 2017 20:06:51 +0100
Message-ID: <20170127190651.GB20571@amd>
References: <20170124175800.GA15070@amd> <20170124184526.GA25056@roeck-us.net>
 <20170125111233.GB3912@amd> <20170125120918.GA7936@pali>
 <1485481030.2469.15.camel@intel.com>
 <a6ce0873-9164-a965-a3e1-9eaaaec2201f@roeck-us.net>
 <1485488382.2469.27.camel@intel.com>
 <9146145b-7e21-c4de-a9cd-dad7bc74ee7a@roeck-us.net>
 <20170127111626.GB5335@amd>
 <37154fca-5cfd-7f65-0f9b-14b979a094e6@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2329430353364632611=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <37154fca-5cfd-7f65-0f9b-14b979a094e6@roeck-us.net>
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


--===============2329430353364632611==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-01-27 06:13:43, Guenter Roeck wrote:
> On 01/27/2017 03:16 AM, Pavel Machek wrote:
> >Hi!
> >
> >>>>That sounds like fun. Changing bq27200-0 to bq27200_0 is Forbidden by
> >>>>the ABI Police, but taking the entire device away is ok.
> >
> >Changing bq27200-0 to bq27200_0 is forbidden in -rc6 time. If you
> >believe noone depends on the name, argue your case, and it might be
> >possible to change it in -rc0.
> >
> >If someone uses the name, they care about the device, and you can't
> >take it away.
> >
> >>>No. IMO, it depends on if the interface is used or not.
> >>>If hwmon I/F is used, we can not take it away, nor change its name.
> >>
> >>Even if the use doesn't depend on that name ?
> >
> >If the use doesn't depend on the name, you may get away with changing
> >the name. (But not in -rc6.)
> >
> >>>If thermal zone I/F is used, we can not change it's 'type' name to be
> >>>compatible with new hwmon API.
> >>
> >>You mean you can not fix the name to be compatible with libsensors.
> >>
> >>Makes me wonder if there shouldn't be a rule that exploits must not
> >>be fixed if already exploited.
> >
> >That is not useful argumentation.
>=20
> Oh, but it is. Providing a valid name is a bug fix for me. For you it is
> an ABI change. So the ultimate question is what counts as an ABI change
> and what counts as a bug fix.

You may not fix bugs if it breaks someone's configuration. Now,
obviously security is something we can't sacrifice. But if docs don't
match the code.. we fix the docs, not the code.

Do you want to call me? I'll give you cellphone number.

									Pavel


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliLmksACgkQMOfwapXb+vJg5ACdHeMNnAOtzNUTLhP1rJReJcio
FSYAnRdLB1Cu9WoHIQRWeVuBhnQkU2cc
=UJEl
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--


--===============2329430353364632611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2329430353364632611==--
