From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC/PATCH 00/14] dt: omap hwmod-dt binding and omap3 i2c1 dt
 support
Date: Wed, 10 Aug 2011 10:56:31 +0530
Message-ID: <4E421687.1060409@ti.com>
References: <1312897232-4792-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:38169 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751228Ab1HJF0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Aug 2011 01:26:39 -0400
Received: by yxl31 with SMTP id 31so683915yxl.27
        for <linux-omap@vger.kernel.org>; Tue, 09 Aug 2011 22:26:37 -0700 (PDT)
In-Reply-To: <1312897232-4792-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 8/9/2011 7:40 PM, G, Manjunath Kondaiah wrote:
>
> This is in continuation of patch series posted at:
> http://lwn.net/Articles/451917/
>
> Patches from Kevin Hilman and others are consolidated along with this
> series since it will be part of ongoing work of decoupling pdev from
> omap_device.
> [There is latest version posted which will be rebased later]
>
> Apart from the above, the major feature included in this series is
> dt-hwmod binding and preparing omap hwmod framework for adapting omap
> drivers to support omap dt after aligning with Grant Likely
> <grant.likely@secretlab.ca>
>
> However, current hwmod-dt binding will be replaced with notifiers in
> generic board file and hwmod device pointer will be scanned and attached
> in notifier call.
>
> Used 3.0 stable kernel version for this patch series since latest mainline
> was broken for beagle boot last week.
>
> git://git.secretlab.ca/git/linux-2.6.git
> Branch: devicetree/test-3.0

Is there a reason why these are based on devicetree/test-3.0 and
not devicetree/test?

>
> G, Manjunath Kondaiah (6):
>    dt: omap: prepare hwmod to support dt
>    dt: Add pd_size to AUXDATA structure
>    dt: omap3: add soc file for handling i2c controllers
>    dt: omap3: beagle board: set clock freq for i2c devices
>    dt: omap3: add generic board file for dt support
>    dt: omap3: enable dt support for i2c1 controller
>
> Kevin Hilman (7):
>    OMAP: omap_device: replace _find_by_pdev() with to_omap_device()
>    OMAP: omap_device: replace debug/warning/error prints with dev_*
>      macros
>    OMAP3: beagle: don't touch omap_device internals
>    OMAP: McBSP: use existing macros for converting between devices
>    OMAP: omap_device: remove internal functions from omap_device.h
>    OMAP: omap_device: when building return platform_device instead of
>      omap_device
>    ARM: platform_device: pdev_archdata: add omap_device pointer
>
> Tony Lindgren (1):
>    omap2+: Use Kconfig symbol in Makefile instead of obj-y
>
>   arch/arm/boot/dts/omap3-beagle-nunchuck.dts   |   11 +--
>   arch/arm/boot/dts/omap3-beagle.dts            |   18 +++-
>   arch/arm/boot/dts/omap3-soc.dtsi              |   62 ++++++++++
>   arch/arm/include/asm/device.h                 |    5 +
>   arch/arm/mach-omap2/Kconfig                   |   11 ++
>   arch/arm/mach-omap2/Makefile                  |   77 ++++++-------
>   arch/arm/mach-omap2/board-omap3-dt.c          |   93 +++++++++++++++
>   arch/arm/mach-omap2/board-omap3beagle.c       |   40 ++-----
>   arch/arm/mach-omap2/devices.c                 |   44 ++++----
>   arch/arm/mach-omap2/display.c                 |    6 +-
>   arch/arm/mach-omap2/dma.c                     |   16 ++--
>   arch/arm/mach-omap2/gpio.c                    |    8 +-
>   arch/arm/mach-omap2/hsmmc.c                   |    8 +-
>   arch/arm/mach-omap2/hwspinlock.c              |    8 +-
>   arch/arm/mach-omap2/mcbsp.c                   |    8 +-
>   arch/arm/mach-omap2/pm.c                      |    8 +-
>   arch/arm/mach-omap2/serial.c                  |   12 +-
>   arch/arm/plat-omap/i2c.c                      |    8 +-
>   arch/arm/plat-omap/include/plat/omap_device.h |   17 ++-
>   arch/arm/plat-omap/mcbsp.c                    |    6 +-
>   arch/arm/plat-omap/omap_device.c              |  150 ++++++++++++++++---------
>   drivers/i2c/busses/i2c-omap.c                 |   23 ++++-
>   drivers/of/platform.c                         |   41 +++++++
>   include/linux/of_platform.h                   |    5 +
>   24 files changed, 469 insertions(+), 216 deletions(-)
>   create mode 100644 arch/arm/boot/dts/omap3-soc.dtsi
>   create mode 100644 arch/arm/mach-omap2/board-omap3-dt.c
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss

