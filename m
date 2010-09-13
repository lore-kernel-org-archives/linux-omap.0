From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH 0/7] omap4: Fixes, hacks for es2.0
Date: Mon, 13 Sep 2010 20:36:14 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0315F02F22@dbde02.ent.ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
	<87fwxjx7qj.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD17EDFA@dbde02.ent.ti.com>
	<87y6bavrn3.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD17EE0A@dbde02.ent.ti.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0315F026BF@dbde02.ent.ti.com>
	<AANLkTimJ+tHk7ZPmPkuwHi2svU0Qw_SqGHazn4W=_ApC@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0315F0273D@dbde02.ent.ti.com>
 <AANLkTim6yki=wj73K1+Tv=SZ877YLXBrXrBCLnAn6P7o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36530 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751995Ab0IMPGX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 11:06:23 -0400
In-Reply-To: <AANLkTim6yki=wj73K1+Tv=SZ877YLXBrXrBCLnAn6P7o@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Salveti <rsalveti@rsalveti.net>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>



[snip]
> >> >
> >> > [Ghorai] I have tested MMC/SD boot using omap3_defconfig on ZOOM3,
> 4430
> >> ES2.0 SDP, Blaze and Panda and all booting fine.
> >> >
> >> > And omap_4430sdp_defconfig also ok omap4.
> >>
> >> Which Panda version are you using during your tests? I tried
> >> omap_4430sdp_defconfig using omap4-for-tony branch at my ES2.0 and I'm
> >> unable to detect the MMC.
> >>
> >> Do I need any other patch to make the MMC work with Panda?
> > [Ghorai] I have tested based on following tree/branch and using ES2.0
> PANDA only. Can you share bootlog enabling mmc/sd debug message?
> > http://dev.omapzoom.org/?p=santosh/kernel-omap4-
> base.git;a=shortlog;h=refs/heads/omap4-for-tony
> 
> My boot log:
> http://paste.ubuntu.com/491645/
> 
[Ghorai] can you use this bootargs?
setenv bootargs root=/dev/mmcblk0p2 rw rootwait mem=463M console=ttyS2,115200n8
And here is the log from my setup.
[    2.493194] Waiting for root device /dev/mmcblk0p2...
[    2.502960] mmc0: host does not support reading read-only switch. assuming write-enable.
[    2.523895] mmc0: new high speed SDHC card at address e1ed
[    2.531616] mmcblk0: mmc0:e1ed SD04G 3.75 GiB
[    2.539550]  mmcblk0: p1 p2
[    2.607360] EXT3-fs: barriers not enabled

> Using x-loader from
> http://gitorious.org/pandaboard/x-loader/commits/omap4_panda_L24.9 and
> upstream u-boot.
[Ghorai] can you try with this x-loader
https://docs.google.com/leaf?id=0B8fdjBBEQ4lDZGE3ZTBjNzEtOTQ0Ni00ZmFlLTlhODgtN2QzNjUwMzBkNDI2&hl=en
In the mean time I will try with yours!

> 
> Cheers,
> --
> Ricardo Salveti de Araujo
