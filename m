From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/39] ARM: dts: Convert OMAP boards to use IOPAD pinmux
 macros
Date: Fri, 13 Nov 2015 06:47:43 -0800
Message-ID: <20151113144742.GB2517@atomide.com>
References: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447390457-1158-1-git-send-email-javier@osg.samsung.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, "Andrew F. Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier@osg.samsung.com> [151112 20:55]:
> Hello Tony,
> 
> This series converts all the remaining OMAP boards that didn't use the
> IOPAD macros to specify the padconf register addresses. The only board
> that I left was arch/arm/boot/dts/am335x-boneblack.dts because Andrew
> already posted a patch for that DTS [0].
> 
> I built tested all the DTBs that are build by omap2plus_defconfig and
> the md5 checksum was the same before and after the patches so there's
> no functional change and is only to make the DTS more readable.

Yes great. Being able to compare the register against the documentation
helps quite a bit. I plan on applying this series before anything else
after -rc1 as it may require other patches to be rebased.

> Patch #1 should be acked by the pinctrl maintainer and picked through
> the linux-omap tree to maintain bisectability.
> 
> [0]: https://lkml.org/lkml/2015/10/24/114

OK let's wait for Linus to take a look at it.

Tony



> Javier Martinez Canillas (39):
>   pinctrl: Move am4372 and dra7 macros to the the SoC header files
>   ARM: dts: am335x-baltos-ir5221: Remove leftover pinctrl lines
>   ARM: dts: am335x-baltos-ir5221: Use AM33XX_IOPAD pinmux macro
>   ARM: dts: am335x-bone-common: Use AM33XX_IOPAD pinmux macro
>   ARM: dts: am335x-bonegreen: Use AM33XX_IOPAD pinmux macro
>   ARM: dts: am335x-chiliboard: Use AM33XX_IOPAD pinmux macro
>   ARM: dts: am335x-chilisom: Use AM33XX_IOPAD pinmux macro
>   ARM: dts: am335x-evm: Use AM33XX_IOPAD pinmux macro
>   ARM: dts: am335x-evmsk: Use AM33XX_IOPAD pinmux macro
>   ARM: dts: am335x-lxm: Use AM33XX_IOPAD pinmux macro
>   ARM: dts: am335x-nano: Use AM33XX_IOPAD pinmux macro
>   ARM: dts: am335x-pepper: Use AM33XX_IOPAD pinmux macro
>   ARM: dts: am335x-phycore-som: Use AM33XX_IOPAD pinmux macro
>   ARM: dts: am335x-wega: Use AM33XX_IOPAD pinmux macro
>   ARM: dts: am3517-craneboard: Use OMAP3_CORE1_IOPAD pinmux macro
>   ARM: dts: am437x-gp-evm: Use AM4372_IOPAD pinmux macro
>   ARM: dts: am437x-idk-evm: Use AM4372_IOPAD pinmux macro
>   ARM: dts: am437x-sk-evm: Use AM4372_IOPAD pinmux macro
>   ARM: dts: am43x-epos-evm: Use AM4372_IOPAD pinmux macro
>   ARM: dts: am57xx-beagle-x15: Use DRA7XX_CORE_IOPAD pinmux macro
>   ARM: dts: dra7-evm: Use DRA7XX_CORE_IOPAD pinmux macro
>   ARM: dts: dra72-evm: Use DRA7XX_CORE_IOPAD pinmux macro
>   ARM: dts: omap3-beagle: Use OMAP3_*_IOPAD pinmux macros
>   ARM: dts: omap3-beagle-xm: Use OMAP3_*_IOPAD pinmux macros
>   ARM: dts: omap3-evm-37xx: Use OMAP3_*_IOPAD pinmux macros
>   ARM: dts: omap3-ldp: Use OMAP3_CORE1_IOPAD pinmux macro
>   ARM: dts: omap3-n900: Use OMAP3_CORE1_IOPAD pinmux macro
>   ARM: dts: omap3-n9: Use OMAP3_CORE1_IOPAD pinmux macro
>   ARM: dts: omap3-zoom3: Use OMAP3_*_IOPAD pinmux macros
>   ARM: dts: twl4030: Use OMAP3_CORE1_IOPAD pinmux macro
>   ARM: dts: omap4-panda-a4: Use OMAP4_IOPAD pinmux macro
>   ARM: dts: omap4-panda-common: Use OMAP4_IOPAD pinmux macro
>   ARM: dts: omap4-panda-es: Use OMAP4_IOPAD pinmux macro
>   ARM: dts: omap4-sdp: Use OMAP4_IOPAD pinmux macro
>   ARM: dts: omap4-sdp-es23plus: Use OMAP4_IOPAD pinmux macro
>   ARM: dts: twl6030: Use OMAP4_IOPAD pinmux macro
>   ARM: dts: omap5-board-common: Use OMAP5_IOPAD pinmux macro
>   ARM: dts: omap5-cm-t54: Use OMAP5_IOPAD pinmux macro
>   ARM: dts: omap5-uevm.dts: Use OMAP5_IOPAD pinmux macro
> 
>  arch/arm/boot/dts/am335x-baltos-ir5221.dts | 186 +++++++-------
>  arch/arm/boot/dts/am335x-bone-common.dtsi  | 104 ++++----
>  arch/arm/boot/dts/am335x-bonegreen.dts     |   4 +-
>  arch/arm/boot/dts/am335x-chiliboard.dts    |  20 +-
>  arch/arm/boot/dts/am335x-chilisom.dtsi     |  80 +++---
>  arch/arm/boot/dts/am335x-evm.dts           | 220 ++++++++---------
>  arch/arm/boot/dts/am335x-evmsk.dts         | 278 ++++++++++-----------
>  arch/arm/boot/dts/am335x-lxm.dts           | 120 ++++-----
>  arch/arm/boot/dts/am335x-nano.dts          | 140 +++++------
>  arch/arm/boot/dts/am335x-pepper.dts        | 200 +++++++--------
>  arch/arm/boot/dts/am335x-phycore-som.dtsi  |  60 ++---
>  arch/arm/boot/dts/am335x-wega.dtsi         |  58 ++---
>  arch/arm/boot/dts/am3517-craneboard.dts    |   2 +-
>  arch/arm/boot/dts/am437x-gp-evm.dts        | 380 ++++++++++++++---------------
>  arch/arm/boot/dts/am437x-idk-evm.dts       | 128 +++++-----
>  arch/arm/boot/dts/am437x-sk-evm.dts        | 298 +++++++++++-----------
>  arch/arm/boot/dts/am43x-epos-evm.dts       | 246 +++++++++----------
>  arch/arm/boot/dts/am57xx-beagle-x15.dts    | 198 +++++++--------
>  arch/arm/boot/dts/dra7-evm.dts             | 254 +++++++++----------
>  arch/arm/boot/dts/dra72-evm.dts            | 200 +++++++--------
>  arch/arm/boot/dts/omap3-beagle-xm.dts      |  18 +-
>  arch/arm/boot/dts/omap3-beagle.dts         |  64 ++---
>  arch/arm/boot/dts/omap3-evm-37xx.dts       |  54 ++--
>  arch/arm/boot/dts/omap3-ldp.dts            |  42 ++--
>  arch/arm/boot/dts/omap3-n900.dts           | 106 ++++----
>  arch/arm/boot/dts/omap3-n950-n9.dtsi       |  12 +-
>  arch/arm/boot/dts/omap3-zoom3.dts          |  60 ++---
>  arch/arm/boot/dts/omap4-panda-a4.dts       |   6 +-
>  arch/arm/boot/dts/omap4-panda-common.dtsi  | 164 ++++++-------
>  arch/arm/boot/dts/omap4-panda-es.dts       |  10 +-
>  arch/arm/boot/dts/omap4-sdp-es23plus.dts   |   6 +-
>  arch/arm/boot/dts/omap4-sdp.dts            | 110 ++++-----
>  arch/arm/boot/dts/omap5-board-common.dtsi  |  94 +++----
>  arch/arm/boot/dts/omap5-cm-t54.dts         |   2 +-
>  arch/arm/boot/dts/omap5-uevm.dts           |   4 +-
>  arch/arm/boot/dts/twl4030_omap3.dtsi       |   2 +-
>  arch/arm/boot/dts/twl6030_omap4.dtsi       |   4 +-
>  include/dt-bindings/pinctrl/am43xx.h       |   6 +
>  include/dt-bindings/pinctrl/dra.h          |   6 +
>  include/dt-bindings/pinctrl/omap.h         |   2 -
>  40 files changed, 1977 insertions(+), 1971 deletions(-)
> 
> -- 
> 2.4.3
> 
