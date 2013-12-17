From: Balaji T K <balajitk@ti.com>
Subject: Re: mmc only working when used in U-Boot
Date: Tue, 17 Dec 2013 19:18:12 +0530
Message-ID: <52B0561C.5050300@ti.com>
References: <52B05478.1040606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54271 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929Ab3LQNsQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Dec 2013 08:48:16 -0500
In-Reply-To: <52B05478.1040606@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stefan Roese <stefan.roese@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On Tuesday 17 December 2013 07:11 PM, Stefan Roese wrote:
> Hi!
>
> I've noticed on a custom OMAP3530 board, that the SDcard (mmc1) is only
> detected, when its previously used in U-Boot (e.g. by "mmc rescan"). So
> I tested on beagleboard and it behaved identical.
>
> Here the boot log with U-Boot scanning mmc before Linux booting:
>
> root@generic-armv7a:~# dmesg | grep mmc
> [    2.225006] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc@4809c000[0]'
> [    2.234100] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc@4809c000[0]'
> [    2.260040] omap_hsmmc 4809c000.mmc: pins are not configured from the driver
> [    2.398071] mmc0: host does not support reading read-only switch. assuming write-enable.
> [    2.408416] mmc0: new high speed SD card at address 0007
> [    2.419128] mmcblk0: mmc0:0007 SD02G 1.90 GiB
> [    2.426025]  mmcblk0: p1 p2
> [   10.241638] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data mode. Opts: (null)
> [   10.256011] FAT-fs (mmcblk0p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
>
> Here the boot log without U-Boot touching mmc before Linux booting:
>
> root@generic-armv7a:~# dmesg | grep mmc
> [    2.162689] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc@4809c000[0]'
> [    2.171936] of_get_named_gpiod_flags: can't parse gpios property of node '/ocp/mmc@4809c000[0]'
> [    2.197906] omap_hsmmc 4809c000.mmc: pins are not configured from the driver
>
> I also added the pin mux'es for the mmc to the dts and the last message
> is gone. But this doesn't help with mmc detection.
>
> BTW: This is on latest mainline Linux.
>
> Somehow U-Boot configured/enables something that is missing in the
> Linux driver. Is this a known issue? Any ideas?
>

If you are using dt boot, mostly likely it is because of missing pbias
configuration.

> Thanks,
> Stefan
>

