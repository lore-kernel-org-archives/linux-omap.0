From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.13 (and probably all recent) kernels refuse to boot on one
 Nokia N950, work or another
Date: Thu, 26 Oct 2017 09:27:59 +0200
Message-ID: <20171026072759.GC20634@amd>
References: <20171025203459.GA22035@amd>
 <3dbb966f-c279-2c57-d3c2-98ca7c04accd@gmail.com>
 <20171026070815.GA20634@amd>
 <20171026072113.z5bqer7os62ckf3z@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171026072113.z5bqer7os62ckf3z@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com
List-Id: linux-omap@vger.kernel.org


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Thu 2017-10-26 09:21:13, Pali Roh=C3=A1r wrote:
> On Thursday 26 October 2017 09:08:15 Pavel Machek wrote:
> > On Thu 2017-10-26 08:25:02, Filip Matijevi=C4=87 wrote:
> > > Last time I couldn't get output on serial I used CONFIG_DEBUG_LL,
> > > CONFIG_DEBUG_OMAP3UART3, CONFIG_EARLY_PRINTK... and ignore_loglevel
> > > earlyprintk kernel params to get output early enough - I guess you
> > > already tried that.
> >=20
> > I realized I'm not getting output from the decompessor (even on "S"
> > machine), and enabled that.
>=20
> That is because you have not enabled those EARLY PRINK or DEBUG LL.
> Similar thing is needed for N900 and IIRC in some of my linux-n900
> branches I have config for it. Plus it needs patching some arch/arm
> source files to make it working.

Do you have a patch? That would be very useful.

Seems like debugging in uncompressor was broken some time ago:

config DEBUG_UNCOMPRESS
        bool
		depends on ARCH_MULTIPLATFORM || PLAT_SAMSUNG ||         ARM_SINGLE_ARMV7M
	        default y if DEBUG_LL && !DEBUG_OMAP2PLUS_UART &&=20
		                     (!DEBUG_TEGRA_UART || !ZBOOT_ROM)
        && \!DEBUG_BRCMSTB_UART
			    =20

> > But I'm _still_ not getting any output on decompressor... early
> > printing works ok on "S" but not on "P".
>=20
> I guess there can be either problem with memory mapping and RAM size or
> with OMAP HS mode?

RAM size should be ok... how do I check for OMAP HS problems?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlnxjn8ACgkQMOfwapXb+vLatgCgw143c/ws3OiGJ4Hqefg7QAYg
WEIAnjTuZ0E+u6Dx7cl/bp7pOTVarQlk
=cFxH
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
