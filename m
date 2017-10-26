From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
Date: Thu, 26 Oct 2017 09:08:15 +0200
Message-ID: <20171026070815.GA20634@amd>
References: <20171025203459.GA22035@amd>
 <3dbb966f-c279-2c57-d3c2-98ca7c04accd@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3dbb966f-c279-2c57-d3c2-98ca7c04accd@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2017-10-26 08:25:02, Filip Matijevi=C4=87 wrote:
> Hi Pavel,
>=20
> On 10/25/2017 10:34 PM, Pavel Machek wrote:
> > 3.5.3-nemo kernel seems to work
>=20
> I did take a quick look at the board-rm680.c since there are some
> conditional statements with regards to system revision but I didn't
> notice anything that might prevent it from booting.

Thanks.

> > If you have
> > any ideas, let me know.
>=20
> Last time I couldn't get output on serial I used CONFIG_DEBUG_LL,
> CONFIG_DEBUG_OMAP3UART3, CONFIG_EARLY_PRINTK... and ignore_loglevel
> earlyprintk kernel params to get output early enough - I guess you
> already tried that.

I realized I'm not getting output from the decompessor (even on "S"
machine), and enabled that.

But I'm _still_ not getting any output on decompressor... early
printing works ok on "S" but not on "P".

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnxid8ACgkQMOfwapXb+vL1ZgCfbfgfd/dcpLAHLE5ujEKjIhwd
YZsAoK5n5No6m2cmr7nQzqOthPfnnYKm
=MDHY
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
