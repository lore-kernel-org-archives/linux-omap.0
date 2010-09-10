From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH 0/7] omap4: Fixes, hacks for es2.0
Date: Fri, 10 Sep 2010 12:44:02 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0315E3CDB8@dbde02.ent.ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59339 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295Ab0IJHOK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Sep 2010 03:14:10 -0400
In-Reply-To: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Shilimkar, Santosh
> Sent: Thursday, September 09, 2010 4:53 PM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com; khilman@deeprootsystems.com; Shilimkar, Santosh
> Subject: [PATCH 0/7] omap4: Fixes, hacks for es2.0
> 
> This series has few fixes, hacks to get omap4 es2.0 working
> on mainline. The patches are generated against the mainline
> 2.6.36-rc3.
> 
> 
> The series is boot tested tested on 4430 SDP, Blaze with
> omap_4430sdp_defconfig with file over NFS and MMC.
> 
> Also boot tested omap3_defconfig with ramdisk on OMAP4 and OMAP3
> SDPs. Same observation with Panda
> 
> With omap3_defconfig, MMC while mounting the rootfs over MMC, the
> boot hangs. Same observation with Panda

[Ghorai] Santosh,
It's booing in another Panda. I think that's a board issue. 

> 
> [    5.794616] regulator_init_complete: incomplete constraints, leaving
> VUSIM on
> [    5.802764] regulator_init_complete: incomplete constraints, leaving
> VPP on
> [    5.816131] twl_rtc twl_rtc: setting system clock to 2000-01-01
> 00:53:12 UTC (9      )
> [    5.849304] mmc0: new high speed MMC card at address 0001
> [    5.856323] mmcblk0: mmc0:0001 SEM08G 7.39 GiB
> [    5.862091]  mmcblk0: unknown partition table
> [    6.325500] omap_device: mmci-omap-hs.1: new worst case deactivate
> latency 0: 6
> [   18.424407] VFS: Cannot open root device "mmcblk0p2" or unknown-
> block(179,2)
> [   18.431823] Please append a correct "root=" boot option; here are the
> available      ons:
> [   18.440643] b300         7757824 mmcblk0 driver: mmcblk
> [   18.446166] Kernel panic - not syncing: VFS: Unable to mount root fs on
> unknown
> 
> All these patches are also available at:
> 	http://dev.omapzoom.org/?p=santosh/kernel-omap4-base.git;a=summary
> 	head: omap4-for-tony
> 
> David Anders (1):
>   omap4: Panda: Add DEBUG_LL support
> 
> Eric Dumazet (1):
>   KS8851: Correct RX packet allocation
> 
> Madhusudhan Chikkature (1):
>   omap4: Workaround for CMD line reset.
> 
> Santosh Shilimkar (4):
>   omap4: Update id.c and cpu.h for es2.0
>   omap4: Temporary fix silicon version detection
>   omap4: l2x0: Fix init parameter for ES2.0
>   omap4: Fix bootup crash observed with higher CPU clocks
> 
>  arch/arm/mach-omap2/id.c                     |   39
> +++++++++++++++++++++----
>  arch/arm/mach-omap2/omap4-common.c           |    5 ++-
>  arch/arm/plat-omap/dmtimer.c                 |    2 +-
>  arch/arm/plat-omap/include/plat/cpu.h        |    5 ++-
>  arch/arm/plat-omap/include/plat/uncompress.h |    1 +
>  drivers/mmc/host/omap_hsmmc.c                |    8 +++++
>  drivers/net/ks8851.c                         |   39 ++++++++++++++-------
> -----
>  7 files changed, 71 insertions(+), 28 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
