From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 0/7] ARM: OMAP: remove IP checks from SoC family
 detection
Date: Thu, 5 Jan 2012 11:15:58 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8071991@DBDE01.ent.ti.com>
References: <1325726206-11199-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51248 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755274Ab2AELQF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jan 2012 06:16:05 -0500
In-Reply-To: <1325726206-11199-1-git-send-email-khilman@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, January 05, 2012 6:47 AM
> To: linux-omap@vger.kernel.org
> Cc: Paul Walmsley; Hiremath, Vaibhav
> Subject: [PATCH 0/7] ARM: OMAP: remove IP checks from SoC family detection
> 
> Currently, our SoC detection is based on SoC family detection
> (using die ID) and the presence of specific IP blocks (or feature.)
> 
> This series begins the separation of the SoC family detection and
> specific IP detection.
> 
> Applies on top of Tony's current master branch and so far, it has only
> been compile tested using omap2plus_defconfig.
> 
I tested it on OMAP3EVM (AM37x) and AM3517EVM as well and it is booting up
for me.

Feel free to add my acked and/or tested by.


Just FYI, not related to the patch series at all, but I am getting into some issues with ramdisk mounting (which was working earlier, not sure). Probably I have to create fresh image and try...

Thanks,
Vaibhav

> Kevin
> 
> 
> Kevin Hilman (7):
>   ARM: OMAP: remove unused cpu_is macros that depend on specific IP
>     checks
>   ARM: OMAP3: clock data: replace 3503/3517 flag with AM35x flag for
>     UART4
>   ARM: OMAP3: clock data: treat all AM35x devices the same
>   ARM: OMAP: AM35x: remove redunant cpu_is checks for AM3505
>   ARM: OMAP: clock: remove unused CK_3505 flag
>   ARM: OMAP: remove unused cpu_is_omap3505()
>   ARM: OMAP: remove unused cpu_is_omap3530()
> 
>  arch/arm/mach-omap2/clock3xxx_data.c          |   16 +-------------
>  arch/arm/mach-omap2/hsmmc.c                   |    8 +++---
>  arch/arm/mach-omap2/usb-musb.c                |    2 +-
>  arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 +-
>  arch/arm/plat-omap/include/plat/clkdev_omap.h |    3 +-
>  arch/arm/plat-omap/include/plat/cpu.h         |   26 +-------------------
> -----
>  6 files changed, 10 insertions(+), 47 deletions(-)
> 
> --
> 1.7.8.2

