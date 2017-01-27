From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Fri, 27 Jan 2017 20:02:33 +0100
Message-ID: <20170127190233.GA20571@amd>
References: <20170124073720.GB5603@amd>
 <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
 <20170124175800.GA15070@amd> <20170124184526.GA25056@roeck-us.net>
 <20170125111233.GB3912@amd> <20170125120918.GA7936@pali>
 <1485481030.2469.15.camel@intel.com>
 <a6ce0873-9164-a965-a3e1-9eaaaec2201f@roeck-us.net>
 <20170127110947.GA5335@amd>
 <74f6b75a-66b0-789f-658b-0e9f5cfed5a8@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4210300858833903264=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <74f6b75a-66b0-789f-658b-0e9f5cfed5a8@roeck-us.net>
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


--===============4210300858833903264==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >>That sounds like fun. Changing bq27200-0 to bq27200_0 is Forbidden by
> >>the ABI Police, but taking the entire device away is ok.
> >
> >Stop trying to break other people's systems. Thanks you.

> You still have not shown that it does. Actually, I am trying to _fix_
> other people's systems (those using libsensors).

No, I don't know that it does. Please avoid 1) calling me police and
2) claiming that taking away entire devices is okay (when it probably
is not).

And no, I don't know if anyone uses hwmon ABI on affected N900. [And
how many other devices are affected, '-' seems to be quite common
character in kernel names.] If I knew about concrete breakage, we'd
have very different discussion.

Well, so first things first. What about fixing libsensors to allow '-'
and '*' in the name?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliLmUkACgkQMOfwapXb+vL3tACgiiFPn5+g2zNxH6b+CCP9JEFv
KCEAoL05XmCvhHUeX+rOmjpNq9rtZy+4
=mcC5
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--


--===============4210300858833903264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4210300858833903264==--
