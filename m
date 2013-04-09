From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH V3 1/2] ARM: OMAP: board-4430sdp: Provide regulator to
 pwm-backlight
Date: Tue, 9 Apr 2013 09:56:02 +0200
Message-ID: <20130409075602.GA27255@avionic-0098.mockup.avionic-design.de>
References: <1363214006-10662-1-git-send-email-achew@nvidia.com>
 <1363214006-10662-2-git-send-email-achew@nvidia.com>
 <20130408214624.GZ10155@atomide.com>
 <20130408215616.GA25124@avionic-0098.mockup.avionic-design.de>
 <20130408221657.GC10155@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:50426 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935241Ab3DIH4G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 03:56:06 -0400
Content-Disposition: inline
In-Reply-To: <20130408221657.GC10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andrew Chew <achew@nvidia.com>, peter.ujfalusi@ti.com, acourbot@nvidia.com, linux-omap@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2013 at 03:16:57PM -0700, Tony Lindgren wrote:
> * Thierry Reding <thierry.reding@avionic-design.de> [130408 15:01]:
> > On Mon, Apr 08, 2013 at 02:46:24PM -0700, Tony Lindgren wrote:
> > > * Andrew Chew <achew@nvidia.com> [130313 15:37]:
> > > > The pwm-backlight driver now takes a mandatory regulator that is go=
tten
> > > > during driver probe.  Initialize a dummy regulator to satisfy this
> > > > requirement.
> > > >=20
> > > > Signed-off-by: Andrew Chew <achew@nvidia.com>
> > > > ---
> > > > Changed the device name of the backlight regulator supply to "pwm-b=
acklight",
> > > > per Peter's comment.
> > > >=20
> > > > Changed the name of the regulator to "backlight-enable", per Thierr=
y's
> > > > suggestion.
> > >=20
> > > Thanks applying into omap-for-v3.10/board. Note that I'm not taking t=
he
> > > second one, that should be resent to the related driver maintainers.
> > > You can get that list by running scripts/get_maintainer.pl against it.
> >=20
> > The plan was to take these all through one tree, preferably the PWM tree
> > because it's all PWM related and the pwm-backlight change will go
> > through that tree as well. Technically these individual patches can be
> > applied as is and aren't harmful, but keeping track of the dependencies
> > might be difficult if they go in via separate trees.
>=20
> Registering the regulator alone should not do anything. Also the driver
> should do the right thing if the regulator is not yet registered.
>=20
> Can you please check your driver patch so the driver won't do anything
> if the regulator is not (yet) registered and repost it alone as I've
> already applied the board-*.c change.

That's not the way that the regulator subsystem works, unfortunately.
There's no way you can distinguish between the case where a regulator
just hasn't been registered yet, or whether it's missing. That's the
whole reason why we need to add the dummy regulators in the first
place.

> The reason why we want to do queue these patches separately is to cut
> away the dependency between drivers and the core arch/arm changes.=20
> Otherwise we'll end up with pointless merge conflicts as we've seen
> earlier several times with the USB patches for example.

We could possibly postpone merging the pwm-backlight changes until all
other patches have been merged. If you have this in you for-3.10 branch
I guess it will go into linux-next when the 3.9 merge window closes? If
so I could possibly base my for-3.10 branch on your branch if you can
provide a stable one that you can guarantee not to rebase. There are
other alternatives too, but certainly the easiest would've been to take
all patches through the PWM tree. The potential for merge conflicts
should be rather minimal.

Thierry

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRY8mSAAoJEN0jrNd/PrOhvRsP/2fGKe6fqgsyi5sKkK7/ZG9E
4brBQLO1zcdExJmFtwntJL2HOTCZ5Fz80rOl5z+wQbhf2h8Z2a72EgUbx/tMd1Yi
PxfSFCm6tJ3yrVp7vBDy9UahXjdiEZr9RPg/eeirSdITNdSyhNJ8qfOLRGODpIzF
bDCk05PNSaMkyk1jEa4EDf/s3NFPeqO3c2rfg+7uW9RsGHcKUCZWjaETvDdwG+J3
FwkHgmh4dqasOUIDZDv+Hs5w2W1r3yg5DGWlAbTZwTriLyovCfnYHHycLw0GhpG+
pvNg/7RQ5KoyVrCNqiEqUzyLe20TyMjC2Ya9dVYMTu9Mr9NvdPU9USfc4AUCTq15
cvWFfQg6gXjWkQb+aQhqmxpo55nhd/g0l8IbsKr1ByjVLWGbmapEBaXHM6YKQy/o
ZcuHAeMpY7Y5jUh7ySSxH11NFqAO4J/lHqdtFS9SAtQ3O1vrrLvuAapHfLuKqnzC
AuLv9NbfqYmhbI1U4hcNwCfYUtfbtQij038qEOkUAnARPKMQof6RvkyvKEaC1OGn
iSHcvZGXPKqKYWfCmtFOcLYf6+DNtgkCrkOT5HmwEunQ9S8BbKVZfDcnia/zQX2j
E0Px4f1OkL1Ms/2MdKWmCLfeD6LkyJHiMldLhQzu8XOb26htMzgkY0AaX5W/gkwe
rVoimepS43MgftMbFCWD
=8H5P
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
