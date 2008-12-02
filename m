From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: Oops in MMC
Date: Tue, 02 Dec 2008 13:57:23 +0200
Message-ID: <87y6yyvlgc.fsf@trdhcp146196.ntc.nokia.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301B6F46990@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:43460 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543AbYLBL5m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 06:57:42 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301B6F46990@dbde02.ent.ti.com>
	(ext Premi's message of "Tue, 2 Dec 2008 17:17:49 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"ext Premi, Sanjeev" <premi@ti.com> writes:

> Hi,
>
> I was trying to mount the filesystem from MMC card on OMAP3EVM.
> Came across this oops.
>
> However, when I boot via ramdisk/NFS and mount /dev/mmcblk0p2; there =
is no oops.
>
> Anything missing in the configuration?
>
> Here is my snapshot menuconfig:
>    --- MMC/SD/SDIO card support
>    *** MMC/SD/SDIO Card Drivers ***
>     <*>   MMC block device driver
>     [*]     Use bounce buffer for simple hosts
>     <*>   TI OMAP High Speed Multimedia Card Interface support
>
> Also:
> # git-show --pretty=3Doneline
> 5019ed843f3208482c64043e4052e89b3d5462a0 sync isp1301_omap with mainl=
ne
>
> Best regards,
> Sanjeev
>
> Mounting NFS filesystems:  [  OK  ]
> Mounting other filesystems:  [  OK  ]
> Starting system logger: <1>Unhandled fault: external abort on non-lin=
efetch (0x1808) at 0xd809c104
> Unhandled fault: external abort on non-linefetch (0x1808) at
> 0xd809c104

This indicates that the driver is trying to access OMAP HSMMC module
registers while the module has it's clocks disabled. So probably there
is bug in HSMMC driver clock handling or in clockfw.

--=20
Jouni H=C3=B6gander

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
