From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 0/4] LogicPD minimal board support for LV_SOM and
 Torpedo
Date: Tue, 28 Sep 2010 10:19:09 -0700
Message-ID: <20100928171908.GE3117@atomide.com>
References: <1285603550-6382-1-git-send-email-tim.nordell@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1285603550-6382-1-git-send-email-tim.nordell@logicpd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tim Nordell <tim.nordell@logicpd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tim Nordell <tim.nordell@logicpd.com> [100927 08:57]:
> This was tested (and based) against 2.6.36-rc5
> 
> Difference from patch v3 1/4:
>  - Merged DEBUG_LL support patch (patch v3 5/5) into first patch
>  - Added "select OMAP_PACKAGE_CBB" into Kconfig for both boards
> 
> Tim Nordell (4):
>   Adding LogicPD OMAP3 board support
>   ARM: OMAP3LOGIC: Adding SDMMC support
>   ARM: OMAP3: Add generic smsc911x support when connected to GPMC
>   ARM: OMAP3LOGIC: Added SMSC Ethernet board support
> 
>  arch/arm/mach-omap2/Kconfig                     |   20 ++
>  arch/arm/mach-omap2/Makefile                    |    7 +
>  arch/arm/mach-omap2/board-omap3logic.c          |  244 +++++++++++++++++++++++
>  arch/arm/mach-omap2/gpmc-smsc911x.c             |  113 +++++++++++
>  arch/arm/plat-omap/include/plat/gpmc-smsc911x.h |   35 ++++
>  arch/arm/plat-omap/include/plat/uncompress.h    |    2 +
>  6 files changed, 421 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-omap3logic.c
>  create mode 100644 arch/arm/mach-omap2/gpmc-smsc911x.c
>  create mode 100644 arch/arm/plat-omap/include/plat/gpmc-smsc911x.h

Thanks, queuing all of them for the upcoming merge window.
I've updated the MMC related patch with the following to
keep it compiling with the MMC related platform init changes.

Regards,

Tony

--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -26,6 +26,7 @@
 #include <linux/regulator/machine.h>
 
 #include <linux/i2c/twl.h>
+#include <linux/mmc/host.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -112,7 +113,7 @@ static struct omap2_hsmmc_info __initdata board_mmc_info[] = {
 	{
 		.name		= "external",
 		.mmc		= 1,
-		.wires		= 4,
+		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
 	},
