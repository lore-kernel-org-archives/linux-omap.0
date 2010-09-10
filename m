From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/7] omap4: Fixes, hacks for es2.0
Date: Fri, 10 Sep 2010 20:41:46 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD17EF8E@dbde02.ent.ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
	<87fwxjx7qj.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD17EDFA@dbde02.ent.ti.com>
	<87y6bavrn3.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD17EE0A@dbde02.ent.ti.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0315F026BF@dbde02.ent.ti.com>
 <AANLkTimJ+tHk7ZPmPkuwHi2svU0Qw_SqGHazn4W=_ApC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47884 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315Ab0IJPMA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Sep 2010 11:12:00 -0400
In-Reply-To: <AANLkTimJ+tHk7ZPmPkuwHi2svU0Qw_SqGHazn4W=_ApC@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Salveti <rsalveti@rsalveti.net>, "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Ricardo Salveti [mailto:rsalveti@rsalveti.net]
> Sent: Friday, September 10, 2010 8:34 PM
> To: Ghorai, Sukumar
> Cc: Shilimkar, Santosh; Kevin Hilman; linux-omap@vger.kernel.org;
> tony@atomide.com
> Subject: Re: [PATCH 0/7] omap4: Fixes, hacks for es2.0
>=20
> On Fri, Sep 10, 2010 at 7:30 AM, Ghorai, Sukumar <s-ghorai@ti.com> wr=
ote:
> >
> >
> >> -----Original Message-----
> > [..snip..]
> >> > >>
> >> > >> > The series is boot tested tested on 4430 SDP, Blaze with
> >> > >> > omap_4430sdp_defconfig with file over NFS and MMC.
> >> > >> >
> >> > >> > Also boot tested omap3_defconfig with ramdisk on OMAP4 and =
OMAP3
> >> > >> > SDPs. Same observation with Panda
> >> > >> >
> >> > >> > With omap3_defconfig, MMC while mounting the rootfs over MM=
C,
> the
> >> > >> > boot hangs. Same observation with Panda
> >> > >>
> >> > >> On my ES2.0 Panda, rootfs on MMC is now working with this ser=
ies.
> >> > >>
> >> > > I observed the same with MMC. Ramdisk boot worked for me on PA=
NDA.
> >> >
> >> > Note that I said "now working". =A0I think you read my message a=
s "not
> >> > working."
> >> >
> >> Yes I read it otherway ... Second time today :)
> >>
> >> > IOW, rootfs on MMC *is* working for me on my es2.0 Panda. =A0 I =
applied
> >> > your series to current l-o master, and it works.
> >> >
> >> Cool!!
> >
> > [Ghorai] I have tested MMC/SD boot using omap3_defconfig on ZOOM3, =
4430
> ES2.0 SDP, Blaze and Panda and all booting fine.
> >
> > And omap_4430sdp_defconfig also ok omap4.
>=20
> Which Panda version are you using during your tests? I tried
> omap_4430sdp_defconfig using omap4-for-tony branch at my ES2.0 and I'=
m
> unable to detect the MMC.
>=20
> Do I need any other patch to make the MMC work with Panda?
>=20
You don't need any more patches for kernel. Just use latest
Panda boot-loaders and it should work.

Regards,
Santosh


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
