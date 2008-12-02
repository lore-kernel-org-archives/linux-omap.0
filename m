From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Oops in MMC
Date: Tue, 2 Dec 2008 17:31:55 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B6F469A8@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301B6F46990@dbde02.ent.ti.com>
 <87y6yyvlgc.fsf@trdhcp146196.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37433 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751844AbYLBMCH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 07:02:07 -0500
In-Reply-To: <87y6yyvlgc.fsf@trdhcp146196.ntc.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: H=F6gander Jouni [mailto:jouni.hogander@nokia.com]=20
> Sent: Tuesday, December 02, 2008 5:27 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: Oops in MMC
>=20
> "ext Premi, Sanjeev" <premi@ti.com> writes:
>=20
> > Hi,
> >
> > I was trying to mount the filesystem from MMC card on OMAP3EVM.
> > Came across this oops.
> >
> > However, when I boot via ramdisk/NFS and mount=20
> /dev/mmcblk0p2; there is no oops.
> >
> > Anything missing in the configuration?
> >
> > Here is my snapshot menuconfig:
> >    --- MMC/SD/SDIO card support
> >    *** MMC/SD/SDIO Card Drivers ***
> >     <*>   MMC block device driver
> >     [*]     Use bounce buffer for simple hosts
> >     <*>   TI OMAP High Speed Multimedia Card Interface support
> >
> > Also:
> > # git-show --pretty=3Doneline
> > 5019ed843f3208482c64043e4052e89b3d5462a0 sync isp1301_omap with=20
> > mainlne
> >
> > Best regards,
> > Sanjeev
> >
> > Mounting NFS filesystems:  [  OK  ]
> > Mounting other filesystems:  [  OK  ]
> > Starting system logger: <1>Unhandled fault: external abort on=20
> > non-linefetch (0x1808) at 0xd809c104 Unhandled fault:=20
> external abort=20
> > on non-linefetch (0x1808) at
> > 0xd809c104
>=20
> This indicates that the driver is trying to access OMAP HSMMC=20
> module registers while the module has it's clocks disabled.=20
> So probably there is bug in HSMMC driver clock handling or in clockfw=
=2E

Appears to be so; but I was not sure why it hasn't been reported so far=
=2E I see many posts of Angstorm using MMC.

>=20
> --
> Jouni H=F6gander
>=20
>=20
> --
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
