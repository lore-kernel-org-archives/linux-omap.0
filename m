From: Pavel Machek <pavel@ucw.cz>
Subject: Re: misc: bh1770glc: move sysfs interace to Documentation/ABI
Date: Tue, 2 Jan 2018 14:06:36 +0100
Message-ID: <20180102130636.GA20209@amd>
References: <20171226092957.GA3817@mordor.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171226092957.GA3817@mordor.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Aishwarya Pant <aishpant@gmail.com>, pali.rohar@gmail.com, sre@kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Samu Onkalo <samu.p.onkalo@nokia.com>, julia.lawall@lip6.fr, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-omap@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> In Documentation/misc-devices/bh1770glc.txt, there is a description of th=
e sysfs
> interface which could be moved to Documentation/ABI.
>=20
> Would such a change be useful?

Not at the moment.

> The ABI documentation format looks like the following:
>=20
> What:          (the full sysfs path of the attribute)
> Date:          (date of creation)
> KernelVersion: (kernel version it first showed up in)
> Contact:       (primary contact)
> Description:   (long description on usage)
>=20
> I am doing this in an exercise to move sysfs ABI interfaces (which are
> documented) to their right place i.e. in Documentation/ABI along with the=
 rest.

The interface should probably be changed to iio one, to be consistent
with other sensors such as Apds990x.

If you have the hardware, help would be welcome.

  	      	       	     	   	   		     	   	Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpLg9wACgkQMOfwapXb+vL3QQCcD5XpTv8BfJEGu2SkrHgyK84d
nWMAn2mwXdrAFKvDrUbEnc1Cb+Mdm8GH
=QqDj
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
