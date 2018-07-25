From: Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [Letux-kernel] [PATCH 09/32] ARM: dts: omap3-gta04: make NAND
 partitions compatible with recent U-Boot
Date: Wed, 25 Jul 2018 18:27:45 +0200
Message-ID: <20180725182745.6e436abc@aktux>
References: <cover.1532501910.git.hns@goldelico.com>
        <8dcf3efd3270451314a663c125841ca87ed2b387.1532501910.git.hns@goldelico.com>
        <20180725080735.GA7467@lenoch>
        <EECC7962-DEAB-4C21-98A7-EBAE4AEA312B@goldelico.com>
        <20180725083305.GB8303@lenoch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/EvVVwApYBji=RIuQBH6+p31"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725083305.GB8303@lenoch>
Sender: linux-kernel-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Sig_/EvVVwApYBji=RIuQBH6+p31
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Jul 2018 10:33:05 +0200
Ladislav Michl <ladis@linux-mips.org> wrote:

> On Wed, Jul 25, 2018 at 10:18:28AM +0200, H. Nikolaus Schaller wrote:
> >  =20
> > > Am 25.07.2018 um 10:07 schrieb Ladislav Michl <ladis@linux-mips.org>:
> > >=20
> > > On Wed, Jul 25, 2018 at 08:58:41AM +0200, H. Nikolaus Schaller wrote:=
 =20
> > >> Vendor defined U-Boot has changed the partition scheme a while ago:
> > >>=20
> > >> * kernel partition 6MB
> > >> * file system partition uses the remainder up to end of the NAND
> > >> * increased size of the environment partition (to get an OneNAND com=
patible base address)
> > >> * shrink the U-Boot partition
> > >>=20
> > >> Let's be compatible (e.g. Debian kernel built from upstream). =20
> > >=20
> > > That, in fact, is breaking compatibility. =20
> >=20
> > With what? Nobody is using the old u-boot partition scheme any more
> > (it is >5 years old).
> >  =20
> > > So once you are touching this
> > > what about relying on partitioning provided by bootloader just to pre=
vent
> > > something like this happening again? =20
> >=20
> > Well, we define what compatible means here (since we are the vendor).
> > And people complain with us. We simply recommend them to upgrade the
> > boot-loader. =20
>=20
> Fair enough. Suggestion was to remove partitioning scheme from DTB alltog=
ether
> and let U-Boot provide one. But you being vendor you decide, of course :)
> (I'd use only two partitions: MLO and UBI, latter one with BCH8, and store
> everything in UBI volumes. That's a bit more flexible approach)
>=20
hmm, so using mtdparts kernel commandline parameter? Somehow it sounds
to be sane to not have partition tables in kernel. What only is needed
is to have a nice transition scheme for systems in the wild, can
commandline mtdparts overwrite dtb? So dtb is a fallback?
But I think all that is a future improvement?

Regards,
Andreas

--Sig_/EvVVwApYBji=RIuQBH6+p31
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAltYpQEACgkQfb1qx03i
kyS/cBAAiJDfHrQ1C/NH2CyAl4MhuKBmq0Y5OF9pA7skcJ2o9CFkNEIwVsh0Uhpb
+5XaAB5JfiFp5Ec/fF8dbRrr9SN8+n9N4DynnHyxC4GtwR7ENFkojSLtYxYq+iCe
UtvJBwdztUOlS5ZU14DcHWVrG4eGXcVAiNU65Fy5NTnrxQMvDSuM7gz9jPWCnhft
n/Dy1UZERTnbC15yakXwHY/IGmqTHv/6edVt2SEtsVi2+fFnafwdpZDccAHOxbdb
Ukpt1xnUZj7NoNdKsLlXyWHNmAJ3jGWr4JM8CVl+ljV2jetKv97zNFcH1yN+DHQe
zD4DMvmG5O9+Op+MX+c0Op32tAslHLS2gDPZ3jS2vkIKMJD6Wy3DAu5NU1BYjqfp
APqO96G+1TYejdIiZTD8q/PAPSCp3/pJvJcnJaMHsXY2nFZpTgLKELQ2gB7on3le
u8bU3hzQIZS0Jgr3nEI8DVcq6qBLpTfj34KNzq5PwPhFr9oHQ+bBa2y3OD0vsLnL
PXJOkXW5DacLuVpnztAdLmY4r+uE9qizAk2TFFN3ytWdipuh4vVqK3JTsl/yUqf4
qHrpXnrL5L+MYW59q6VxhbIdUrWMfjXd8k+gZ6+hGmFf9waWyHf3tGzxpn/1Yby9
sFCv2S/XaSvAMauNxidH9iENvjfne7UQJdBwmPjx+YBwVw1mZxM=
=Y4Fy
-----END PGP SIGNATURE-----

--Sig_/EvVVwApYBji=RIuQBH6+p31--
