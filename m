From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 00/17] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Fri, 15 Apr 2016 12:34:04 +0300
Message-ID: <5710B58C.7050108@ti.com>
References: <1460023715-19332-1-git-send-email-rogerq@ti.com>
 <20160413212500.GD5995@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160413212500.GD5995-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony & Boris,

On 14/04/16 00:25, Tony Lindgren wrote:
> * Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [160407 03:10]:
>> Hi,
>>
>> As this series has cross dependency between omap and mtd subsystems,
>> I'll set up a immutable branch which omap-soc and l2-mtd must
>> merge in together to avoid any conflicts/breakage during integration.
>>
>> Brian has acked all mtd patches. Tony needs to give his Ack for the
>> gpmc driver part and then I can provide the immutable branch.
> 
> Looks good to me, please feel free to add:
> 
> Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> 

I've added Tony and Rob's Acked-by tags and pushed the patches at the
below PULL request.

Please take this into omap-soc and l2-mtd trees. Thanks.

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:rogerq/linux.git for-v4.7/gpmc-mtd-common

for you to fetch changes up to 10f22ee367c4aff7841da6a83c10445d7d6328d9:

  mtd: nand: omap2: Implement NAND ready using gpiolib (2016-04-15 11:55:37 +0300)

----------------------------------------------------------------
Roger Quadros (17):
      ARM: OMAP2+: gpmc: Add platform data
      ARM: OMAP2+: gpmc: Add gpmc timings and settings to platform data
      memory: omap-gpmc: Introduce GPMC to NAND interface
      memory: omap-gpmc: Add GPMC-NAND ops to get writebufferempty status
      memory: omap-gpmc: Implement IRQ domain for NAND IRQs
      mtd: nand: omap: Use gpmc_omap_get_nand_ops() to get NAND registers
      mtd: nand: omap: Switch to using GPMC-NAND ops for writebuffer empty check
      mtd: nand: omap: Copy platform data parameters to omap_nand_info data
      mtd: nand: omap: Clean up device tree support
      mtd: nand: omap: Update DT binding documentation
      memory: omap-gpmc: Prevent mapping into 1st 16MB
      memory: omap-gpmc: Move device tree binding to correct location
      memory: omap-gpmc: Support general purpose input for WAITPINs
      memory: omap-gpmc: Reserve WAITPIN if needed for WAIT monitoring
      memory: omap-gpmc: Support WAIT pin edge interrupts
      memory: omap-gpmc: Prevent GPMC_STATUS from being accessed via gpmc_regs
      mtd: nand: omap2: Implement NAND ready using gpiolib

 Documentation/devicetree/bindings/{bus/ti-gpmc.txt => memory-controllers/omap-gpmc.txt} |  17 +++
 Documentation/devicetree/bindings/mtd/gpmc-nand.txt                                     |  19 +++-
 arch/arm/mach-omap2/gpmc-nand.c                                                         |   7 +-
 drivers/memory/Kconfig                                                                  |   1 +
 drivers/memory/omap-gpmc.c                                                              | 655 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------
 drivers/mtd/nand/omap2.c                                                                | 194 +++++++++++++++++++++++++++-------
 include/linux/omap-gpmc.h                                                               | 172 ++++++------------------------
 include/linux/platform_data/gpmc-omap.h                                                 | 172 ++++++++++++++++++++++++++++++
 include/linux/platform_data/mtd-nand-omap2.h                                            |  12 ++-
 9 files changed, 817 insertions(+), 432 deletions(-)
 rename Documentation/devicetree/bindings/{bus/ti-gpmc.txt => memory-controllers/omap-gpmc.txt} (89%)
 create mode 100644 include/linux/platform_data/gpmc-omap.h

--
cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
