From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Thu, 25 Dec 2014 22:42:46 -0600
Message-ID: <20141226044246.GB7661@saruman>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
 <54991A25.2030804@compulab.co.il>
 <20141223161936.GA9147@saruman>
 <549AA94A.8030209@compulab.co.il>
 <20141224154948.GA423@saruman>
 <20141224190401.GN23854@atomide.com>
 <549BE333.9060709@compulab.co.il>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49106 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbaLZEng (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Dec 2014 23:43:36 -0500
Content-Disposition: inline
In-Reply-To: <549BE333.9060709@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 25, 2014 at 12:13:07PM +0200, Igor Grinberg wrote:
> Hi Tony,
>=20
> On 12/24/14 21:04, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [141224 07:52]:
> >> Hi,
> >>
> >> On Wed, Dec 24, 2014 at 01:53:46PM +0200, Igor Grinberg wrote:
> >>> -----BEGIN PGP SIGNED MESSAGE-----
> >>> Hash: SHA1
> >>>
> >>> On 12/23/14 18:19, Felipe Balbi wrote:
> >>>> On Tue, Dec 23, 2014 at 09:30:45AM +0200, Igor Grinberg wrote:
> >>>>> Hi Felipe,
> >>>>>
> >>>>> On 12/22/14 20:05, Felipe Balbi wrote:
> >>>>>
> >>>>> [...]
> >>>>>
> >>>>>>  CONFIG_SCSI_SCAN_ASYNC=3Dy
> >>>>>> -CONFIG_ATA=3Dy
> >>>>>> -CONFIG_SATA_AHCI_PLATFORM=3Dy
> >>>>>> -CONFIG_MD=3Dy
> >>>>>> +CONFIG_ATA=3Dm
> >>>>>> +CONFIG_SATA_AHCI_PLATFORM=3Dm
> >>>>>
> >>>>> Isn't this needed for the rootfs on SATA devices?
> >>>>
> >>>> there's no known boards with rootfs on SATA. Until then, we can redu=
ce
> >>>> the size.
> >>>
> >>> What makes you say so?
> >>> The decision for rootfs on SATA is taken dynamically.
> >>> OMAP5 boards (specifically cm-t54) can have rootfs on SATA...
> >>
> >> I'll leave the decision to Tony. Even though they _can_, they really
> >> don't and IIRC, OMAP5's SATA has so many silicon errata that it'd be
> >> annoying to find that special device which works (e.g it can't negotia=
te
> >> lower speeds with SATA III devices and it won't support SATA I).
>=20
> Yet, it is not that buggy and at least until now, I di not get any
> reports about badly working SATA from customers...
>=20
> >>
> >> As of today, we don't know of anybody really shipping anything with
> >> rootfs on SATA and distros would rather ship initiramfs than a giant
> >> zImage anyway.
>=20
> So, you just continue to ignore what I'm saying... even after I point
> to a device...

you pointed a device which *can* have rootfs on SATA, not one which
*has* rootfs on SATA, there's a very big difference there.

> Is it SATA that makes it so giant?
> Because I find it worth having in SATA than spare some more k's...

that's your point of view. As Tony mentioned, we have a very standard
way of dealing with this which is initramfs and x86 has been using that
for the past 15+ years.

> >> Tony, your call.
> >=20
> > I think we should move omap2plus_defconfig to be mostly modular and
> > usable for distros as a base. Most distros prefer to build almost
> > everything as loadable modules. And my preference is that we should
> > only keep the minimum rootfs for devices and serial support as
> > built-in and rely on initramfs for most drivers. And slowly move
> > also the remaining built-in drivers to be loadable modules.
> >=20
> > The reasons for having drivers as loadable modules are many. It
> > allows distros to use the same kernel for all the devices without
> > bloating the kernel. It makes developing drivers easier as just the
> > module needs to be reloaded. And loadable modules protect us from
> > cross-framework spaghetti calls in the kernel as the interfaces are=20
> > clearly defined.
> >=20
> > Are there people really using SATA as rootfs right now on omaps?
>=20
> Yes. That is exactly my point.

read your email, you said it *CAN* have rootfs on SATA.

> > If it's only something that will be more widely used in the future,
> > then I suggest we make it into a loadable module, and presume
> > initramfs and loadable module also for any new devices. The same
> > way x86 has been doing with distros for years.
>=20
> The difference from x86 is that we're in embedded here and

bullshit, you would never ship a product with omap2plus_defconfig. You'd
build your own at which point you would switch SATA to built-in.

> although initramfs is a kind of option, but it means, you need to
> load even more data during the boot process... it is annoying and
> I would not want to use it on embedded.

make your own defconfig.

> (BTW, x86_64_defconfig has it compiled in...)
>=20
> We can also, split the defconfig as it was some time ago... but I
> would not want to go that direction...
>=20
> If we go the initramfs way, then why not also load MMC from it?
> That will also reduce kernel size... (but add initramfs size)

I'm fine with that. The difference is that people have been relying on
MMC built-in for the past 10+ years, since the old OMAP1 MMC driver,
changing that now is likely to cause some "my board won't boot anymore"
bug reports.

> I'm sure you will find making the MMC a loadable module inconvenient.
> That how I find making the SATA a loadable module...
>=20
> Right now, we tell our customers that they can use mainline with
> omap2plus_defconfig.

that's the worst thing you can do. You should at a minimum provide your
customers with a more minimal rootfs. Why would you have your customers
build MUSB on an OMAP5 board ? Why would they build 5 different
network device drivers ? Why would they build almost every single PMIC
we ever used ? The list goes on and on.

--=20
balbi

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUnOdGAAoJEIaOsuA1yqREI9YQAJ7BveXnogOiorgBWauKsEnh
EWTME+sLZUfKT4fvx38MUFjqVTMnHJ+wZnrXt3xVbr8FgJx4C1g+G+FrjLHhRCG1
6QnWKWEpEzEPIcTPd40mdeKMIAL/6Sg1gT9TNuj4qhFneClz+aG32ItKkkmp2ab+
G4FegCXMUpwnwNqtRUue90MlusQ6moifpjEQOPpxfZQgRZSk3ekkNorWN1LSYHy3
S/gWyg51eMRjUoKbziBchbBEuIko5gxIrMaK585bjcwcc0w/j3Rfv9AC0mwGX7kZ
XNQz17LqzPdkL1Vn6iRAJmLWeVPQw9DaD4oKHPfyvjP4urt9eBOT6K/V3+wLgSRC
CCh1rtjYtf4wrNqxII9o+PYpSdjHJmuqiLmmgkFDeLzEkGjAlMSVHr2kQ3l+jXj3
Vn0flzgDKgGA0XekpuyFpKnK3znAOOD70bnBAzcjrRiwxGsjBwjSfvhu4V6BzOZw
VirSK9uq4pm/qb0zEIazw7pbSDN1RC0fOlL2LiomKpzHBZ1AJomURssEWy2wq78C
SD7lIZmxPDvE82LdiZIhchCSJJXayIlAM021YJObMqoFsa2pSiQGPZZ+DYbuLEgj
cAMnDK+mBk9HtLY1pG7xVGgwLZnzjdIqaptSnJLAAdAsKbcjwgkF4iYcgNAXyiKy
rYlwMTArNrXwxlXnq4Fe
=RTvA
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
