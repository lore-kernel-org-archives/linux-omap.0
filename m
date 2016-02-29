From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v5 00/26] memory: omap-gpmc: mtd: nand: Support GPMC NAND
 on non-OMAP platforms
Date: Mon, 29 Feb 2016 18:25:12 +0200
Message-ID: <56D470E8.4070106@ti.com>
References: <1455916548-3441-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455916548-3441-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org, javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org, fcooper-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Brian,

On 19/02/16 23:15, Roger Quadros wrote:
> Hi,
> 
> @Tony
> Patches 15 and 24 are new and will need your review.
> I've modified patch 22 to include the new am335x boards introduced since v4.4.
> 
> Patches are based on top of omap-for-v4.6/dt so that the DT changes apply cleanly.
> 
> @Brian
> If you can Ack the MTD related changes we can push the series (excluding DT patches)
> to an immutable branch and you can then pull it into l2-mtd.git

Gentle ping on this. Thanks.

cheers,
-roger

> 
> Patches tested on:
> dra-evm, am437x-gp-evm, beagleboard-c4, beagleboard-c4-legacyboot
> 
> Changelog:
> v5:
> -changed ready/busy# GPIO DT binding from "ready-gpio" to "rb-gpios".
> -use irqdomain for gpmc NAND interrupts: fifoevent and termcount
> 
> v4:
> -Warn if using older incompatible DT i.e. compatible property not present
> in nand node.
> -Applied Tony's patch to fix broken ethernet on torpedo.
> 
> v3:
> -Fixed and tested NAND using legacy boot on omap3-beagle.
> -Support rising and falling edge interrupts on WAITpins.
> -Update DT node of all gpmc users.
> 
> Patches summary:
> 
> We do a couple of things in this series which result in
> cleaner device tree implementation, faster perfomance and
> multi-platform support. As an added bonus we get to use the GPMC_WAIT
> pins as GPI/Interrupts.
> 
> - Establish a custom interface between NAND and GPMC driver. This is
> needed because all of the NAND registers sit in the GPMC register space.
> 
> - Clean up device tree support so that omap-gpmc IP and the omap2 NAND
> driver can be used on non-OMAP platforms. e.g. Keystone.
> 
> - Implement GPIOCHIP for the GPMC WAITPINS. SoCs can contain
> 2 to 4 of these and most of them would be unused otherwise. It also
> allows a cleaner implementation of NAND Ready pin status for the NAND driver.
> 
> - Implement GPMC IRQ domain to proivde the 2 NAND events and
> GPMC WAITPIN edge interrupts.
> 
> - Implement GPIOlib based NAND ready pin checking for OMAP NAND driver.
> On dra7-evm, Read speed increases from 13768 KiB/ to 17246 KiB/s.
> Write speed was unchanged at 7123 KiB/s.
> 
> This series is available at
> git-9UaJU3cA/F/QT0dZR+AlfA@public.gmane.org:rogerq/linux.git
> in branch
> for-v4.6/gpmc-v5
> 
> --
> cheers,
> -roger
> 
> Roger Quadros (26):
>   ARM: OMAP2+: gpmc: Add platform data
>   ARM: OMAP2+: gpmc: Add gpmc timings and settings to platform data
>   memory: omap-gpmc: Introduce GPMC to NAND interface
>   mtd: nand: omap2: Use gpmc_omap_get_nand_ops() to get NAND registers
>   memory: omap-gpmc: Add GPMC-NAND ops to get writebufferempty status
>   mtd: nand: omap2: Switch to using GPMC-NAND ops for writebuffer empty
>     check
>   memory: omap-gpmc: Implement IRQ domain for NAND IRQs
>   mtd: nand: omap: Copy platform data parameters to omap_nand_info data
>   mtd: nand: omap: Clean up device tree support
>   mtd: nand: omap: Update DT binding documentation
>   memory: omap-gpmc: Prevent mapping into 1st 16MB
>   memory: omap-gpmc: Move device tree binding to correct location
>   memory: omap-gpmc: Support general purpose input for WAITPINs
>   memory: omap-gpmc: Reserve WAITPIN if needed for WAIT monitoring
>   memory: omap-gpmc: Support WAIT pin edge interrupts
>   memory: omap-gpmc: Prevent GPMC_STATUS from being accessed via
>     gpmc_regs
>   mtd: nand: omap2: Implement NAND ready using gpiolib
>   ARM: dts: dra7: Fix NAND device nodes.
>   ARM: dts: dra7x-evm: Provide NAND ready pin
>   ARM: dts: am437x: Fix NAND device nodes
>   ARM: dts: am437x: Provide NAND ready pin
>   ARM: dts: am335x: Fix NAND device nodes
>   ARM: dts: am335x: Provide NAND ready pin
>   ARM: dts: dm814x: Fix gpmc and NAND node
>   ARM: dts: dm816x: Fix gpmc and NAND node
>   ARM: dts: omap3: Fix gpmc and NAND nodes
> 
>  Documentation/devicetree/bindings/bus/ti-gpmc.txt  | 130 ----
>  .../bindings/memory-controllers/omap-gpmc.txt      | 141 +++++
>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  19 +-
>  arch/arm/boot/dts/am335x-baltos-ir5221.dts         |  10 +-
>  arch/arm/boot/dts/am335x-chilisom.dtsi             |   9 +-
>  arch/arm/boot/dts/am335x-cm-t335.dts               |  10 +-
>  arch/arm/boot/dts/am335x-evm.dts                   |   8 +-
>  arch/arm/boot/dts/am335x-igep0033.dtsi             |   9 +-
>  arch/arm/boot/dts/am335x-phycore-som.dtsi          |   9 +-
>  arch/arm/boot/dts/am33xx.dtsi                      |   4 +
>  arch/arm/boot/dts/am4372.dtsi                      |   4 +
>  arch/arm/boot/dts/am437x-cm-t43.dts                |   7 +-
>  arch/arm/boot/dts/am437x-gp-evm.dts                |   9 +-
>  arch/arm/boot/dts/am43x-epos-evm.dts               |   9 +-
>  arch/arm/boot/dts/dm8148-evm.dts                   |   8 +-
>  arch/arm/boot/dts/dm814x.dtsi                      |   4 +
>  arch/arm/boot/dts/dm8168-evm.dts                   |   8 +-
>  arch/arm/boot/dts/dm816x.dtsi                      |   4 +
>  arch/arm/boot/dts/dra62x-j5eco-evm.dts             |   8 +-
>  arch/arm/boot/dts/dra7-evm.dts                     |   7 +-
>  arch/arm/boot/dts/dra7.dtsi                        |   4 +
>  arch/arm/boot/dts/dra72-evm.dts                    |   7 +-
>  arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts  |   3 +-
>  arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |   8 +-
>  arch/arm/boot/dts/omap3-beagle.dts                 |   5 +-
>  arch/arm/boot/dts/omap3-cm-t3x.dtsi                |   6 +-
>  arch/arm/boot/dts/omap3-devkit8000-common.dtsi     |   4 +
>  arch/arm/boot/dts/omap3-evm-37xx.dts               |   8 +-
>  arch/arm/boot/dts/omap3-gta04.dtsi                 |   4 +
>  arch/arm/boot/dts/omap3-igep.dtsi                  |   6 +-
>  arch/arm/boot/dts/omap3-igep0020-common.dtsi       |   4 +-
>  arch/arm/boot/dts/omap3-igep0030-common.dtsi       |   4 +
>  arch/arm/boot/dts/omap3-ldp.dts                    |  10 +-
>  arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |   6 +-
>  arch/arm/boot/dts/omap3-overo-base.dtsi            |   6 +-
>  arch/arm/boot/dts/omap3-pandora-common.dtsi        |   4 +
>  arch/arm/boot/dts/omap3-tao3530.dtsi               |   6 +-
>  arch/arm/boot/dts/omap3.dtsi                       |   4 +
>  arch/arm/boot/dts/omap3430-sdp.dts                 |   6 +-
>  arch/arm/mach-omap2/gpmc-nand.c                    |   7 +-
>  drivers/memory/Kconfig                             |   1 +
>  drivers/memory/omap-gpmc.c                         | 653 +++++++++++++--------
>  drivers/mtd/nand/omap2.c                           | 193 ++++--
>  include/linux/omap-gpmc.h                          | 177 ++----
>  include/linux/platform_data/gpmc-omap.h            | 167 ++++++
>  include/linux/platform_data/mtd-nand-omap2.h       |  12 +-
>  46 files changed, 1121 insertions(+), 611 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
>  create mode 100644 include/linux/platform_data/gpmc-omap.h
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
