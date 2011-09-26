From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V3 0/4] Introducing TI's New SoC/board AM335XEVM
Date: Mon, 26 Sep 2011 14:51:43 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404EC9429FC@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1316529142-27564-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48819 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835Ab1IZJVz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Sep 2011 05:21:55 -0400
In-Reply-To: <1316529142-27564-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Tuesday, September 20, 2011 8:02 PM
> To: linux-omap@vger.kernel.org
> Cc: Hilman, Kevin; paul@pwsan.com; tony@atomide.com; linux-arm-
> kernel@lists.infradead.org; Hiremath, Vaibhav
> Subject: [PATCH-V3 0/4] Introducing TI's New SoC/board AM335XEVM
> 
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> This patch set adds support for AM335x device having
> Cortex-A8 MPU.
> 
> AM335X is treated as another OMAP3 variant, where,
> along with existing cpu class OMAP34XX, new cpu class AM33XX is created
> and the respective type is AM335X, which is newly added device in the
> family.
> This means, cpu_is_omap34xx(), cpu_is_am33xx() and
> cpu_is_am335x() checks return success for AM335X.
> 
> Also, I have validated OMAP3 boot test with this patch-series on OMAP3EVM.
> 
> Changes from V1(RFC):
> 	- Created separate cpu/SoC class for AM33XX family of devices,
>           due to all known facts. This is been mentioned in main-chain
>             https://patchwork.kernel.org/patch/1056312/
> 	- BUG Fix in debug-macro.S, which was leading to build failure.
> 	    https://patchwork.kernel.org/patch/1056302/
> 
> Changes from V2(RFC):
> 	- Rebased against Paul's OMAP_CHIP* cleanup patches
> 	  git://git.pwsan.com/linux-2.6 omap_chip_remove_cleanup_3.2
> 	- Removed dependancy on Hemant's submitted patches for TI814X
> 	  support, in order to get it upstream.
> 
> Afzal Mohammed (4):
>   arm:omap:am33xx: Update common omap platform files
>   arm:omap:am33xx: Update common OMAP machine specific sources
>   arm:omap:am33xx: Create board support and enable build for AM335XEVM
>   arm:omap:am33xx: Add low level debugging support
> 
>  arch/arm/mach-omap2/Kconfig                    |   10 ++++
>  arch/arm/mach-omap2/Makefile                   |    2 +
>  arch/arm/mach-omap2/board-am335xevm.c          |   57
> ++++++++++++++++++++++++
>  arch/arm/mach-omap2/clock.c                    |    2 +-
>  arch/arm/mach-omap2/clock.h                    |    2 +-
>  arch/arm/mach-omap2/clock3xxx_data.c           |    6 ++-
>  arch/arm/mach-omap2/common.c                   |   16 +++++++
>  arch/arm/mach-omap2/id.c                       |   10 +++-
>  arch/arm/mach-omap2/include/mach/debug-macro.S |   22 +++++++++
>  arch/arm/mach-omap2/io.c                       |   25 ++++++++++
>  arch/arm/mach-omap2/opp2xxx.h                  |    2 +-
>  arch/arm/mach-omap2/serial.c                   |    6 +-
>  arch/arm/plat-omap/include/plat/am33xx.h       |   25 ++++++++++
>  arch/arm/plat-omap/include/plat/clkdev_omap.h  |    1 +
>  arch/arm/plat-omap/include/plat/clock.h        |    3 +-
>  arch/arm/plat-omap/include/plat/common.h       |    1 +
>  arch/arm/plat-omap/include/plat/cpu.h          |   25 ++++++++++
>  arch/arm/plat-omap/include/plat/hardware.h     |    1 +
>  arch/arm/plat-omap/include/plat/io.h           |   20 ++++++++
>  arch/arm/plat-omap/include/plat/omap34xx.h     |    2 +
>  arch/arm/plat-omap/include/plat/serial.h       |    4 ++
>  arch/arm/plat-omap/include/plat/uncompress.h   |    6 +++
>  arch/arm/plat-omap/io.c                        |    5 ++
>  23 files changed, 243 insertions(+), 10 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-am335xevm.c
>  create mode 100644 arch/arm/plat-omap/include/plat/am33xx.h

Tony,

Any update or comment on this patch-set? 


Thanks,
Vaibhav
