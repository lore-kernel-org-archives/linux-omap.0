Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7AD3BE16A;
	Mon, 14 Sep 2026 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394921; cv=none; b=moIxstt6DhaXLcWR08zkhBf02n+YTI3ZqZBSxf+roW9pjo0Lt2gzK4XpL+xUWrQhmnugr01aLaWafuXOxAv29+zGldGGYEr/TCTQQzIvHB0PrG8yBNqR0hvOrUQXhxG5knOUj9U6G8HG7GHOkfYesaCrby2s2EzSiXhUyyBP5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394921; c=relaxed/simple;
	bh=iFRt2jnjkbPFx1gQEvSTKxnuipUBNmUrn/V+BF0BDbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oY1MuGwFt9f6N6ApRdUh9L3o5UNvphyIrGpuA9C23GTzFtpeAQRqHDAhIznV25Z9QGlixa1BhaAr3uNGBFLI9GZR4elSrtKHI3rnl+sx2nNoFEb93/SpxqstmBIdyoTATeiih21t8ZtYO2+mQzF1qwBBoDeWuJEEcjDwILHJCJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5b8egLl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5b8egLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96C01F000FF;
	Mon, 14 Sep 2026 14:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789394918;
	bh=9GnhsWilQxzqdTa1jgZAUDf+GXIGrJYRdT7lriz3cds=;
	h=From:To:Cc:Subject:Date;
	b=W5b8egLljogSijA5JI47rfQX3gyyCc/Ht1eA0EX2CK0Alf4ae4pSVf7vfMVCZ5SAJ
	 kYU8suAlWyil+ZoTPTjcprttSDhTYop48U+kU6M3gvvveLvXc2/isKuxqRG/0ZcElF
	 pnxpb76Jl5JFE9D7oOYmHooXO+0pY9fji48h5IthiQ9c8/+/kH6oVIie7/uWVO9xYM
	 bcWZazNtKo2NI9gXUfsVxeWajvDtSSzCOdngz0aKgsoHbTbqWfjBql07qL3MXDutTQ
	 tVsIGk3GJRznQpW3EumO1EfwxcmZjBmru2qlYvA85YMuhGdfw5Si6CwyY0utCFCDag
	 3QipBDYU86Vag==
From: Arnd Bergmann <arnd@kernel.org>
To: soc@lists.linux.dev
Cc: Arnd Bergmann <arnd@arndb.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Stefan Agner <stefan@agner.ch>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Kristoffer Ericson <kristoffer.ericson@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-omap@vger.kernel.org
Subject: [PATCH v2 00/14] ARM: deprecated platform removal
Date: Mon, 14 Sep 2026 16:08:02 +0200
Message-ID: <20260914140821.1805449-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

In the 7.3 kernel, I marked a number of platforms and features as
deprecated, with the plan to keep these around for the LTS kernel, but
remove them in 7.4, see [1].

Cleaning out the deprecated platform code has turned into a larger effort
than I expected, currently standing at 300 patches, with a lot of them
still in need of being split up into smaller ones, see [2] for a current
snapshot.

The first series here removes just the bits in arch/arm/mach-*/, plus
the portions that directly depend on the removed Kconfig symbols where
these are trivial to remove.

The parts that are not included are those that remove architectural
features and device drivers that become unused after this part,

This also gives everyone a chance to voice their objections in case
that some of the removed platform code does have active users after all,
before all the corresponding drivers are gone.

     Arnd

Changes since v1 [3]:

 - minor cleanups and fixes based on feedback
 - skipped riscpc patch, which is still under discussion
 - added patch to remove plat-orion, folding the remaining
   PCI support into mach-orion5x
 - added patch to remove Integrator/CM1136JF-S

Links:
[1] https://lore.kernel.org/all/20260701212353.2196041-1-arnd@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=board-remove-7.3
[3] https://lore.kernel.org/lkml/20260908152808.3928630-1-arnd@kernel.org/T/#t

Arnd Bergmann (14):
  ARM: remove sa1100 platform
  ARM: remove footbridge
  ARM: remove legacy pxa board files
  ARM: orion/dove/mv78xx0: remove all board files
  ARM: orion5x: fold plat-orion/pcie.c and hw_pci into pci.c
  ARM: omap2: remove omap24xx support
  ARM: imx: remove i.MX31 SoC support
  ARM: versatile: remove Integrator/CM1136JF-S option
  ARM: imx: remove nommu support
  ARM: lpc18xx: remove entire platform
  ARM: stm32: remove stm32f4/f7/h7 MCU support
  ARM: versatile: remove mps2 support
  ARM: at91: remove samv7 support
  ARM: axxia: remove entire platform

 Documentation/arch/arm/index.rst              |    9 -
 Documentation/arch/arm/marvell.rst            |   15 +-
 Documentation/arch/arm/microchip.rst          |   39 -
 Documentation/arch/arm/netwinder.rst          |   85 -
 Documentation/arch/arm/sa1100/assabet.rst     |  301 ---
 Documentation/arch/arm/sa1100/cerf.rst        |   35 -
 Documentation/arch/arm/sa1100/index.rst       |   13 -
 Documentation/arch/arm/sa1100/lart.rst        |   15 -
 Documentation/arch/arm/sa1100/serial_uart.rst |   51 -
 Documentation/arch/arm/stm32/overview.rst     |    8 +-
 .../arch/arm/stm32/stm32f429-overview.rst     |   25 -
 .../arch/arm/stm32/stm32f746-overview.rst     |   32 -
 .../arch/arm/stm32/stm32f769-overview.rst     |   34 -
 .../arch/arm/stm32/stm32h743-overview.rst     |   33 -
 .../arch/arm/stm32/stm32h750-overview.rst     |   34 -
 .../devicetree/bindings/arm/atmel-at91.yaml   |   39 -
 .../devicetree/bindings/arm/axxia.yaml        |   23 -
 MAINTAINERS                                   |   48 -
 arch/arm/Kconfig                              |   63 +-
 arch/arm/Kconfig.debug                        |  104 +-
 arch/arm/Makefile                             |   15 -
 arch/arm/boot/bootp/Makefile                  |    2 -
 arch/arm/boot/compressed/Makefile             |    8 -
 arch/arm/boot/compressed/head-sa1100.S        |   45 -
 arch/arm/boot/compressed/head-sharpsl.S       |  151 --
 arch/arm/boot/compressed/head.S               |    7 -
 arch/arm/boot/dts/arm/Makefile                |    3 -
 arch/arm/boot/dts/arm/mps2-an385.dts          |   92 -
 arch/arm/boot/dts/arm/mps2-an399.dts          |   92 -
 arch/arm/boot/dts/arm/mps2.dtsi               |  220 --
 arch/arm/boot/dts/intel/Makefile              |    1 -
 arch/arm/boot/dts/intel/axm/Makefile          |    5 -
 .../boot/dts/intel/axm/axm5516-amarillo.dts   |   47 -
 arch/arm/boot/dts/intel/axm/axm5516-cpus.dtsi |  200 --
 arch/arm/boot/dts/intel/axm/axm55xx.dtsi      |  200 --
 arch/arm/boot/dts/nxp/imx/Makefile            |    5 -
 arch/arm/boot/dts/nxp/imx/imx31-bug.dts       |   22 -
 arch/arm/boot/dts/nxp/imx/imx31-lite.dts      |  178 --
 arch/arm/boot/dts/nxp/imx/imx31.dtsi          |  371 ----
 arch/arm/boot/dts/nxp/imx/imxrt1050-evk.dts   |   72 -
 arch/arm/boot/dts/nxp/imx/imxrt1050-pinfunc.h |  993 ---------
 arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi      |  160 --
 arch/arm/boot/dts/nxp/imx/imxrt1170-pinfunc.h | 1561 --------------
 arch/arm/boot/dts/nxp/lpc/Makefile            |    5 -
 arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi        |  543 -----
 arch/arm/boot/dts/nxp/lpc/lpc4337-ciaa.dts    |  221 --
 .../boot/dts/nxp/lpc/lpc4350-hitex-eval.dts   |  485 -----
 arch/arm/boot/dts/nxp/lpc/lpc4350.dtsi        |   48 -
 .../dts/nxp/lpc/lpc4357-ea4357-devkit.dts     |  624 ------
 .../boot/dts/nxp/lpc/lpc4357-myd-lpc4357.dts  |  621 ------
 arch/arm/boot/dts/nxp/lpc/lpc4357.dtsi        |   52 -
 arch/arm/boot/dts/nxp/vf/Makefile             |    2 -
 arch/arm/boot/dts/nxp/vf/vf610m4-colibri.dts  |   61 -
 arch/arm/boot/dts/nxp/vf/vf610m4-cosmic.dts   |   88 -
 arch/arm/boot/dts/nxp/vf/vf610m4.dtsi         |   61 -
 arch/arm/boot/dts/st/Makefile                 |   11 -
 arch/arm/boot/dts/st/stm32429i-eval.dts       |  349 ----
 arch/arm/boot/dts/st/stm32746g-eval.dts       |  236 ---
 arch/arm/boot/dts/st/stm32f4-pinctrl.dtsi     |  482 -----
 arch/arm/boot/dts/st/stm32f429-disco.dts      |  243 ---
 arch/arm/boot/dts/st/stm32f429-pinctrl.dtsi   |   91 -
 arch/arm/boot/dts/st/stm32f429.dtsi           |  800 --------
 arch/arm/boot/dts/st/stm32f469-disco.dts      |  260 ---
 arch/arm/boot/dts/st/stm32f469-pinctrl.dtsi   |   92 -
 arch/arm/boot/dts/st/stm32f469.dtsi           |   18 -
 arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi     |  436 ----
 arch/arm/boot/dts/st/stm32f746-disco.dts      |  234 ---
 arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi   |   55 -
 arch/arm/boot/dts/st/stm32f746.dtsi           |  727 -------
 .../dts/st/stm32f769-disco-mb1166-reva09.dts  |   13 -
 arch/arm/boot/dts/st/stm32f769-disco.dts      |  243 ---
 arch/arm/boot/dts/st/stm32f769-pinctrl.dtsi   |   55 -
 arch/arm/boot/dts/st/stm32f769.dtsi           |   37 -
 arch/arm/boot/dts/st/stm32h7-pinctrl.dtsi     |  301 ---
 arch/arm/boot/dts/st/stm32h743.dtsi           |  738 -------
 arch/arm/boot/dts/st/stm32h743i-disco.dts     |  145 --
 arch/arm/boot/dts/st/stm32h743i-eval.dts      |  185 --
 arch/arm/boot/dts/st/stm32h747i-disco.dts     |  149 --
 arch/arm/boot/dts/st/stm32h750.dtsi           |    6 -
 arch/arm/boot/dts/st/stm32h750i-art-pi.dts    |  229 ---
 arch/arm/boot/dts/ti/omap/Makefile            |    6 -
 arch/arm/boot/dts/ti/omap/omap2.dtsi          |  338 ----
 .../arm/boot/dts/ti/omap/omap2420-clocks.dtsi |  267 ---
 arch/arm/boot/dts/ti/omap/omap2420-h4.dts     |   63 -
 arch/arm/boot/dts/ti/omap/omap2420-n800.dts   |    9 -
 .../boot/dts/ti/omap/omap2420-n810-wimax.dts  |    9 -
 arch/arm/boot/dts/ti/omap/omap2420-n810.dts   |   75 -
 .../dts/ti/omap/omap2420-n8x0-common.dtsi     |  123 --
 arch/arm/boot/dts/ti/omap/omap2420.dtsi       |  262 ---
 .../arm/boot/dts/ti/omap/omap2430-clocks.dtsi |  341 ----
 arch/arm/boot/dts/ti/omap/omap2430-sdp.dts    |   70 -
 arch/arm/boot/dts/ti/omap/omap2430.dtsi       |  366 ----
 .../arm/boot/dts/ti/omap/omap24xx-clocks.dtsi | 1241 ------------
 arch/arm/common/Kconfig                       |   13 -
 arch/arm/common/Makefile                      |    4 -
 arch/arm/common/locomo.c                      |  886 --------
 arch/arm/common/sa1111.c                      | 1413 -------------
 arch/arm/common/scoop.c                       |  269 ---
 arch/arm/common/sharpsl_param.c               |   63 -
 arch/arm/configs/am200epdkit_defconfig        |   91 -
 arch/arm/configs/assabet_defconfig            |   57 -
 arch/arm/configs/axm55xx_defconfig            |  231 ---
 arch/arm/configs/collie_defconfig             |   87 -
 arch/arm/configs/dove_defconfig               |  134 --
 arch/arm/configs/footbridge_defconfig         |  114 --
 arch/arm/configs/h3600_defconfig              |   63 -
 arch/arm/configs/imx_v6_v7_defconfig          |    1 -
 arch/arm/configs/imxrt_defconfig              |   35 -
 arch/arm/configs/jornada720_defconfig         |   95 -
 arch/arm/configs/lpc18xx_defconfig            |  158 --
 arch/arm/configs/mps2_defconfig               |  102 -
 arch/arm/configs/mv78xx0_defconfig            |  120 --
 arch/arm/configs/neponset_defconfig           |   88 -
 arch/arm/configs/netwinder_defconfig          |   88 -
 arch/arm/configs/omap2plus_defconfig          |    4 -
 arch/arm/configs/spitz_defconfig              |  237 ---
 arch/arm/configs/stm32_defconfig              |   80 -
 arch/arm/configs/vf610m4_defconfig            |   39 -
 arch/arm/include/asm/cputype.h                |    4 -
 arch/arm/include/asm/hardware/dec21285.h      |  138 --
 arch/arm/include/asm/hardware/locomo.h        |  217 --
 arch/arm/include/asm/hardware/sa1111.h        |  442 ----
 arch/arm/include/asm/hardware/scoop.h         |   67 -
 arch/arm/include/asm/hardware/ssp.h           |   25 -
 arch/arm/include/asm/mach/pci.h               |   86 -
 arch/arm/include/asm/mach/sharpsl_param.h     |   33 -
 arch/arm/include/asm/pci.h                    |    3 -
 arch/arm/include/debug/dc21285.S              |   41 -
 arch/arm/include/debug/imx-uart.h             |   10 -
 arch/arm/include/debug/sa1100.S               |   67 -
 arch/arm/kernel/atags_parse.c                 |   18 -
 arch/arm/kernel/bios32.c                      |  254 ---
 arch/arm/kernel/head.S                        |   10 -
 arch/arm/mach-at91/Kconfig                    |   11 +-
 arch/arm/mach-at91/Makefile                   |    1 -
 arch/arm/mach-at91/samv7.c                    |   17 -
 arch/arm/mach-axxia/Kconfig                   |   17 -
 arch/arm/mach-axxia/Makefile                  |    3 -
 arch/arm/mach-axxia/axxia.c                   |   19 -
 arch/arm/mach-axxia/platsmp.c                 |   87 -
 arch/arm/mach-dove/Kconfig                    |   32 -
 arch/arm/mach-dove/Makefile                   |    7 -
 arch/arm/mach-dove/bridge-regs.h              |   50 -
 arch/arm/mach-dove/cm-a510.c                  |   94 -
 arch/arm/mach-dove/common.c                   |  449 ----
 arch/arm/mach-dove/common.h                   |   46 -
 arch/arm/mach-dove/dove.h                     |  185 --
 arch/arm/mach-dove/irq.c                      |   81 -
 arch/arm/mach-dove/irqs.h                     |   89 -
 arch/arm/mach-dove/mpp.c                      |  159 --
 arch/arm/mach-dove/mpp.h                      |  197 --
 arch/arm/mach-dove/pcie.c                     |  226 ---
 arch/arm/mach-dove/pm.h                       |   58 -
 arch/arm/mach-footbridge/Kconfig              |   57 -
 arch/arm/mach-footbridge/Makefile             |   18 -
 arch/arm/mach-footbridge/common.c             |  280 ---
 arch/arm/mach-footbridge/common.h             |   15 -
 arch/arm/mach-footbridge/dc21285-timer.c      |  136 --
 arch/arm/mach-footbridge/dc21285.c            |  360 ----
 arch/arm/mach-footbridge/dma-isa.c            |  230 ---
 arch/arm/mach-footbridge/ebsa285-pci.c        |   48 -
 arch/arm/mach-footbridge/ebsa285.c            |  124 --
 .../mach-footbridge/include/mach/hardware.h   |   90 -
 arch/arm/mach-footbridge/include/mach/irqs.h  |   97 -
 .../mach-footbridge/include/mach/isa-dma.h    |   18 -
 .../arm/mach-footbridge/include/mach/memory.h |   26 -
 .../mach-footbridge/include/mach/uncompress.h |   34 -
 arch/arm/mach-footbridge/isa-irq.c            |  177 --
 arch/arm/mach-footbridge/isa-rtc.c            |   57 -
 arch/arm/mach-footbridge/isa-timer.c          |   36 -
 arch/arm/mach-footbridge/isa.c                |   94 -
 arch/arm/mach-footbridge/netwinder-hw.c       |  772 -------
 arch/arm/mach-footbridge/netwinder-pci.c      |   62 -
 arch/arm/mach-imx/Kconfig                     |   38 +-
 arch/arm/mach-imx/Makefile                    |    4 -
 arch/arm/mach-imx/common.h                    |    2 -
 arch/arm/mach-imx/cpu-imx31.c                 |   72 -
 arch/arm/mach-imx/mach-imx31.c                |   18 -
 arch/arm/mach-imx/mach-imx7d-cm4.c            |   18 -
 arch/arm/mach-imx/mach-imxrt.c                |   19 -
 arch/arm/mach-imx/mach-vf610.c                |    1 -
 arch/arm/mach-imx/mm-imx3.c                   |   44 -
 arch/arm/mach-lpc18xx/Makefile                |    2 -
 arch/arm/mach-lpc18xx/board-dt.c              |   19 -
 arch/arm/mach-mv78xx0/Kconfig                 |   27 -
 arch/arm/mach-mv78xx0/Makefile                |    5 -
 arch/arm/mach-mv78xx0/bridge-regs.h           |   31 -
 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c     |  183 --
 arch/arm/mach-mv78xx0/common.c                |  444 ----
 arch/arm/mach-mv78xx0/common.h                |   54 -
 arch/arm/mach-mv78xx0/irq.c                   |   69 -
 arch/arm/mach-mv78xx0/irqs.h                  |   87 -
 arch/arm/mach-mv78xx0/mpp.c                   |   34 -
 arch/arm/mach-mv78xx0/mpp.h                   |  337 ---
 arch/arm/mach-mv78xx0/mv78xx0.h               |  134 --
 arch/arm/mach-mv78xx0/pcie.c                  |  280 ---
 arch/arm/mach-mvebu/Makefile                  |    2 -
 arch/arm/mach-omap2/Kconfig                   |   62 +-
 arch/arm/mach-omap2/Makefile                  |   63 +-
 arch/arm/mach-omap2/board-generic.c           |   34 -
 arch/arm/mach-omap2/board-n8x0.c              |  512 -----
 arch/arm/mach-omap2/clkt2xxx_dpll.c           |   56 -
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c       |  194 --
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c  |  259 ---
 arch/arm/mach-omap2/clock.c                   |   12 +-
 arch/arm/mach-omap2/clock2xxx.h               |   17 -
 arch/arm/mach-omap2/clockdomain.c             |    4 +-
 arch/arm/mach-omap2/clockdomain.h             |    5 -
 arch/arm/mach-omap2/clockdomains2420_data.c   |  154 --
 arch/arm/mach-omap2/clockdomains2430_data.c   |  181 --
 .../mach-omap2/clockdomains2xxx_3xxx_data.c   |   29 +-
 arch/arm/mach-omap2/cm-regbits-24xx.h         |   51 -
 arch/arm/mach-omap2/cm2xxx.c                  |  302 ---
 arch/arm/mach-omap2/cm2xxx.h                  |   60 -
 arch/arm/mach-omap2/cm_common.c               |   12 -
 arch/arm/mach-omap2/common-board-devices.h    |   11 -
 arch/arm/mach-omap2/common.h                  |   12 -
 arch/arm/mach-omap2/control.h                 |   56 -
 arch/arm/mach-omap2/display.c                 |    4 +-
 arch/arm/mach-omap2/dma.c                     |   53 +-
 arch/arm/mach-omap2/fb.c                      |   14 +-
 arch/arm/mach-omap2/gpmc.h                    |   10 -
 arch/arm/mach-omap2/i2c.c                     |    2 +-
 arch/arm/mach-omap2/id.c                      |   80 +-
 arch/arm/mach-omap2/io.c                      |  140 +-
 arch/arm/mach-omap2/iomap.h                   |   46 -
 arch/arm/mach-omap2/l3_2xxx.h                 |   15 -
 arch/arm/mach-omap2/l4_2xxx.h                 |   19 -
 arch/arm/mach-omap2/mmc.h                     |   18 -
 arch/arm/mach-omap2/msdi.c                    |   75 -
 arch/arm/mach-omap2/omap2-restart.c           |   62 -
 arch/arm/mach-omap2/omap24xx.h                |   73 -
 arch/arm/mach-omap2/omap_hwmod.c              |   20 +-
 arch/arm/mach-omap2/omap_hwmod.h              |    2 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c    |  402 ----
 arch/arm/mach-omap2/omap_hwmod_2430_data.c    |  606 ------
 .../omap_hwmod_2xxx_interconnect_data.c       |  256 ---
 .../mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  668 ------
 arch/arm/mach-omap2/omap_hwmod_common_data.h  |   66 -
 arch/arm/mach-omap2/opp2420_data.c            |  131 --
 arch/arm/mach-omap2/opp2430_data.c            |  136 --
 arch/arm/mach-omap2/opp2xxx.h                 |  430 ----
 arch/arm/mach-omap2/pdata-quirks.c            |   37 +-
 arch/arm/mach-omap2/pm.h                      |    5 -
 arch/arm/mach-omap2/powerdomain.h             |    3 -
 arch/arm/mach-omap2/powerdomains2xxx_data.c   |  134 --
 arch/arm/mach-omap2/prcm-common.h             |  147 --
 arch/arm/mach-omap2/prm-regbits-24xx.h        |   39 -
 arch/arm/mach-omap2/prm2xxx.c                 |  229 ---
 arch/arm/mach-omap2/prm2xxx.h                 |  128 --
 arch/arm/mach-omap2/prm2xxx_3xxx.c            |    1 -
 arch/arm/mach-omap2/prm_common.c              |   11 -
 arch/arm/mach-omap2/sdrc.h                    |   21 -
 arch/arm/mach-omap2/sdrc2xxx.c                |  164 --
 arch/arm/mach-omap2/sleep24xx.S               |   91 -
 arch/arm/mach-omap2/soc.h                     |   59 -
 arch/arm/mach-omap2/sram.c                    |  159 +-
 arch/arm/mach-omap2/sram.h                    |   32 -
 arch/arm/mach-omap2/sram242x.S                |  317 ---
 arch/arm/mach-omap2/sram243x.S                |  317 ---
 arch/arm/mach-omap2/usb-tusb6010.c            |  217 --
 arch/arm/mach-omap2/usb-tusb6010.h            |   12 -
 arch/arm/mach-omap2/voltage.h                 |    1 -
 arch/arm/mach-omap2/voltagedomains2xxx_data.c |   29 -
 arch/arm/mach-orion5x/Kconfig                 |   95 -
 arch/arm/mach-orion5x/Makefile                |   13 +-
 arch/arm/mach-orion5x/board-d2net.c           |    2 -
 arch/arm/mach-orion5x/board-dt.c              |    4 +-
 arch/arm/mach-orion5x/board-mss2.c            |    1 -
 arch/arm/mach-orion5x/board-rd88f5182.c       |    1 -
 arch/arm/mach-orion5x/common.c                |  238 +--
 arch/arm/mach-orion5x/common.h                |   34 +-
 arch/arm/mach-orion5x/dns323-setup.c          |  757 -------
 arch/arm/mach-orion5x/irq.c                   |   51 -
 arch/arm/mach-orion5x/irqs.h                  |    9 -
 arch/arm/mach-orion5x/kurobox_pro-setup.c     |  407 ----
 arch/arm/mach-orion5x/mpp.c                   |   41 -
 arch/arm/mach-orion5x/mpp.h                   |  130 --
 arch/arm/mach-orion5x/mv2120-setup.c          |  256 ---
 arch/arm/mach-orion5x/net2big-setup.c         |  444 ----
 arch/arm/mach-orion5x/pci.c                   |  429 +++-
 .../arm/mach-orion5x/terastation_pro2-setup.c |  366 ----
 arch/arm/mach-orion5x/ts209-setup.c           |  331 ---
 arch/arm/mach-orion5x/ts409-setup.c           |  329 ---
 arch/arm/mach-orion5x/ts78xx-fpga.h           |   42 -
 arch/arm/mach-orion5x/ts78xx-setup.c          |  574 ------
 arch/arm/mach-orion5x/tsx09-common.c          |  129 --
 arch/arm/mach-orion5x/tsx09-common.h          |   21 -
 arch/arm/mach-pxa/Kconfig                     |   89 -
 arch/arm/mach-pxa/Makefile                    |    8 -
 arch/arm/mach-pxa/am200epd.c                  |  395 ----
 arch/arm/mach-pxa/am300epd.c                  |  296 ---
 arch/arm/mach-pxa/devices.c                   |  705 -------
 arch/arm/mach-pxa/devices.h                   |   68 -
 arch/arm/mach-pxa/generic.h                   |    5 -
 arch/arm/mach-pxa/gumstix.c                   |  237 ---
 arch/arm/mach-pxa/gumstix.h                   |   89 -
 arch/arm/mach-pxa/pxa25x.c                    |   59 -
 arch/arm/mach-pxa/pxa27x.c                    |   77 -
 arch/arm/mach-pxa/pxa300.c                    |    1 -
 arch/arm/mach-pxa/pxa320.c                    |    1 -
 arch/arm/mach-pxa/pxa3xx.c                    |    6 -
 arch/arm/mach-pxa/sharpsl_pm.c                |  941 ---------
 arch/arm/mach-pxa/sharpsl_pm.h                |  108 -
 arch/arm/mach-pxa/spitz.c                     | 1174 -----------
 arch/arm/mach-pxa/spitz.h                     |  185 --
 arch/arm/mach-pxa/spitz_pm.c                  |  257 ---
 arch/arm/mach-sa1100/Kconfig                  |   92 -
 arch/arm/mach-sa1100/Makefile                 |   20 -
 arch/arm/mach-sa1100/assabet.c                |  770 -------
 arch/arm/mach-sa1100/clock.c                  |  145 --
 arch/arm/mach-sa1100/collie.c                 |  447 ----
 arch/arm/mach-sa1100/generic.c                |  470 -----
 arch/arm/mach-sa1100/generic.h                |   58 -
 arch/arm/mach-sa1100/h3600.c                  |  134 --
 arch/arm/mach-sa1100/h3xxx.c                  |  305 ---
 arch/arm/mach-sa1100/include/mach/SA-1100.h   | 1798 -----------------
 arch/arm/mach-sa1100/include/mach/assabet.h   |   99 -
 arch/arm/mach-sa1100/include/mach/bitfield.h  |  113 --
 arch/arm/mach-sa1100/include/mach/collie.h    |   94 -
 arch/arm/mach-sa1100/include/mach/generic.h   |    1 -
 arch/arm/mach-sa1100/include/mach/h3xxx.h     |   81 -
 arch/arm/mach-sa1100/include/mach/hardware.h  |   56 -
 arch/arm/mach-sa1100/include/mach/irqs.h      |  101 -
 .../arm/mach-sa1100/include/mach/jornada720.h |   28 -
 arch/arm/mach-sa1100/include/mach/memory.h    |   37 -
 arch/arm/mach-sa1100/include/mach/mtd-xip.h   |   23 -
 arch/arm/mach-sa1100/include/mach/neponset.h  |   31 -
 arch/arm/mach-sa1100/include/mach/reset.h     |   18 -
 .../arm/mach-sa1100/include/mach/uncompress.h |   52 -
 arch/arm/mach-sa1100/jornada720.c             |  380 ----
 arch/arm/mach-sa1100/jornada720_ssp.c         |  202 --
 arch/arm/mach-sa1100/neponset.c               |  438 ----
 arch/arm/mach-sa1100/pm.c                     |  128 --
 arch/arm/mach-sa1100/sleep.S                  |  143 --
 arch/arm/mach-sa1100/ssp.c                    |  240 ---
 arch/arm/mach-stm32/Kconfig                   |   38 +-
 arch/arm/mach-stm32/board-dt.c                |    7 -
 arch/arm/mach-versatile/Kconfig               |   10 -
 arch/arm/mach-versatile/Makefile              |    3 -
 arch/arm/mach-versatile/v2m-mps2.c            |   17 -
 arch/arm/mm/Kconfig                           |    2 +-
 arch/arm/mm/init.c                            |    5 -
 arch/arm/mm/ioremap.c                         |    1 -
 arch/arm/mm/mmu.c                             |   16 -
 arch/arm/plat-orion/Makefile                  |    9 -
 arch/arm/plat-orion/common.c                  |  826 --------
 arch/arm/plat-orion/gpio.c                    |  616 ------
 arch/arm/plat-orion/include/plat/addr-map.h   |   54 -
 arch/arm/plat-orion/include/plat/common.h     |  104 -
 arch/arm/plat-orion/include/plat/irq.h        |   15 -
 arch/arm/plat-orion/include/plat/mpp.h        |   34 -
 arch/arm/plat-orion/include/plat/orion-gpio.h |   38 -
 arch/arm/plat-orion/include/plat/pcie.h       |   34 -
 arch/arm/plat-orion/include/plat/time.h       |   20 -
 arch/arm/plat-orion/irq.c                     |   39 -
 arch/arm/plat-orion/mpp.c                     |   82 -
 arch/arm/plat-orion/pcie.c                    |  288 ---
 arch/arm/plat-orion/time.c                    |  238 ---
 drivers/ata/Kconfig                           |    3 +-
 drivers/crypto/Kconfig                        |    2 +-
 drivers/i2c/busses/Kconfig                    |    2 +-
 drivers/media/platform/ti/omap/Kconfig        |    4 +-
 drivers/mmc/host/Kconfig                      |    2 +-
 drivers/mtd/nand/onenand/Kconfig              |    4 +-
 drivers/pci/controller/Kconfig                |    2 +-
 drivers/pci/controller/pci-mvebu.c            |    5 -
 drivers/phy/marvell/Kconfig                   |    2 +-
 drivers/rtc/Kconfig                           |    8 +-
 drivers/rtc/rtc-sa1100.c                      |   17 +-
 drivers/soc/Makefile                          |    1 -
 drivers/soc/atmel/soc.c                       |   36 -
 drivers/soc/atmel/soc.h                       |   26 -
 drivers/thermal/Kconfig                       |    2 +-
 drivers/video/console/Kconfig                 |    6 +-
 drivers/video/console/dummycon.c              |    6 -
 drivers/video/fbdev/cyber2000fb.c             |   10 -
 drivers/video/fbdev/omap2/omapfb/Kconfig      |    2 +-
 drivers/watchdog/Kconfig                      |   14 +-
 include/linux/clk/ti.h                        |    8 -
 sound/soc/kirkwood/Kconfig                    |    2 +-
 381 files changed, 567 insertions(+), 55511 deletions(-)
 delete mode 100644 Documentation/arch/arm/netwinder.rst
 delete mode 100644 Documentation/arch/arm/sa1100/assabet.rst
 delete mode 100644 Documentation/arch/arm/sa1100/cerf.rst
 delete mode 100644 Documentation/arch/arm/sa1100/index.rst
 delete mode 100644 Documentation/arch/arm/sa1100/lart.rst
 delete mode 100644 Documentation/arch/arm/sa1100/serial_uart.rst
 delete mode 100644 Documentation/arch/arm/stm32/stm32f429-overview.rst
 delete mode 100644 Documentation/arch/arm/stm32/stm32f746-overview.rst
 delete mode 100644 Documentation/arch/arm/stm32/stm32f769-overview.rst
 delete mode 100644 Documentation/arch/arm/stm32/stm32h743-overview.rst
 delete mode 100644 Documentation/arch/arm/stm32/stm32h750-overview.rst
 delete mode 100644 Documentation/devicetree/bindings/arm/axxia.yaml
 delete mode 100644 arch/arm/boot/compressed/head-sa1100.S
 delete mode 100644 arch/arm/boot/compressed/head-sharpsl.S
 delete mode 100644 arch/arm/boot/dts/arm/mps2-an385.dts
 delete mode 100644 arch/arm/boot/dts/arm/mps2-an399.dts
 delete mode 100644 arch/arm/boot/dts/arm/mps2.dtsi
 delete mode 100644 arch/arm/boot/dts/intel/axm/Makefile
 delete mode 100644 arch/arm/boot/dts/intel/axm/axm5516-amarillo.dts
 delete mode 100644 arch/arm/boot/dts/intel/axm/axm5516-cpus.dtsi
 delete mode 100644 arch/arm/boot/dts/intel/axm/axm55xx.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx31-bug.dts
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx31-lite.dts
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imx31.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imxrt1050-evk.dts
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imxrt1050-pinfunc.h
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imxrt1050.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/imx/imxrt1170-pinfunc.h
 delete mode 100644 arch/arm/boot/dts/nxp/lpc/lpc18xx.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/lpc/lpc4337-ciaa.dts
 delete mode 100644 arch/arm/boot/dts/nxp/lpc/lpc4350-hitex-eval.dts
 delete mode 100644 arch/arm/boot/dts/nxp/lpc/lpc4350.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/lpc/lpc4357-ea4357-devkit.dts
 delete mode 100644 arch/arm/boot/dts/nxp/lpc/lpc4357-myd-lpc4357.dts
 delete mode 100644 arch/arm/boot/dts/nxp/lpc/lpc4357.dtsi
 delete mode 100644 arch/arm/boot/dts/nxp/vf/vf610m4-colibri.dts
 delete mode 100644 arch/arm/boot/dts/nxp/vf/vf610m4-cosmic.dts
 delete mode 100644 arch/arm/boot/dts/nxp/vf/vf610m4.dtsi
 delete mode 100644 arch/arm/boot/dts/st/stm32429i-eval.dts
 delete mode 100644 arch/arm/boot/dts/st/stm32746g-eval.dts
 delete mode 100644 arch/arm/boot/dts/st/stm32f4-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/st/stm32f429-disco.dts
 delete mode 100644 arch/arm/boot/dts/st/stm32f429-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/st/stm32f429.dtsi
 delete mode 100644 arch/arm/boot/dts/st/stm32f469-disco.dts
 delete mode 100644 arch/arm/boot/dts/st/stm32f469-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/st/stm32f469.dtsi
 delete mode 100644 arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/st/stm32f746-disco.dts
 delete mode 100644 arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/st/stm32f746.dtsi
 delete mode 100644 arch/arm/boot/dts/st/stm32f769-disco-mb1166-reva09.dts
 delete mode 100644 arch/arm/boot/dts/st/stm32f769-disco.dts
 delete mode 100644 arch/arm/boot/dts/st/stm32f769-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/st/stm32f769.dtsi
 delete mode 100644 arch/arm/boot/dts/st/stm32h7-pinctrl.dtsi
 delete mode 100644 arch/arm/boot/dts/st/stm32h743.dtsi
 delete mode 100644 arch/arm/boot/dts/st/stm32h743i-disco.dts
 delete mode 100644 arch/arm/boot/dts/st/stm32h743i-eval.dts
 delete mode 100644 arch/arm/boot/dts/st/stm32h747i-disco.dts
 delete mode 100644 arch/arm/boot/dts/st/stm32h750.dtsi
 delete mode 100644 arch/arm/boot/dts/st/stm32h750i-art-pi.dts
 delete mode 100644 arch/arm/boot/dts/ti/omap/omap2.dtsi
 delete mode 100644 arch/arm/boot/dts/ti/omap/omap2420-clocks.dtsi
 delete mode 100644 arch/arm/boot/dts/ti/omap/omap2420-h4.dts
 delete mode 100644 arch/arm/boot/dts/ti/omap/omap2420-n800.dts
 delete mode 100644 arch/arm/boot/dts/ti/omap/omap2420-n810-wimax.dts
 delete mode 100644 arch/arm/boot/dts/ti/omap/omap2420-n810.dts
 delete mode 100644 arch/arm/boot/dts/ti/omap/omap2420-n8x0-common.dtsi
 delete mode 100644 arch/arm/boot/dts/ti/omap/omap2420.dtsi
 delete mode 100644 arch/arm/boot/dts/ti/omap/omap2430-clocks.dtsi
 delete mode 100644 arch/arm/boot/dts/ti/omap/omap2430-sdp.dts
 delete mode 100644 arch/arm/boot/dts/ti/omap/omap2430.dtsi
 delete mode 100644 arch/arm/boot/dts/ti/omap/omap24xx-clocks.dtsi
 delete mode 100644 arch/arm/common/locomo.c
 delete mode 100644 arch/arm/common/sa1111.c
 delete mode 100644 arch/arm/common/scoop.c
 delete mode 100644 arch/arm/common/sharpsl_param.c
 delete mode 100644 arch/arm/configs/am200epdkit_defconfig
 delete mode 100644 arch/arm/configs/assabet_defconfig
 delete mode 100644 arch/arm/configs/axm55xx_defconfig
 delete mode 100644 arch/arm/configs/collie_defconfig
 delete mode 100644 arch/arm/configs/dove_defconfig
 delete mode 100644 arch/arm/configs/footbridge_defconfig
 delete mode 100644 arch/arm/configs/h3600_defconfig
 delete mode 100644 arch/arm/configs/imxrt_defconfig
 delete mode 100644 arch/arm/configs/jornada720_defconfig
 delete mode 100644 arch/arm/configs/lpc18xx_defconfig
 delete mode 100644 arch/arm/configs/mps2_defconfig
 delete mode 100644 arch/arm/configs/mv78xx0_defconfig
 delete mode 100644 arch/arm/configs/neponset_defconfig
 delete mode 100644 arch/arm/configs/netwinder_defconfig
 delete mode 100644 arch/arm/configs/spitz_defconfig
 delete mode 100644 arch/arm/configs/stm32_defconfig
 delete mode 100644 arch/arm/configs/vf610m4_defconfig
 delete mode 100644 arch/arm/include/asm/hardware/dec21285.h
 delete mode 100644 arch/arm/include/asm/hardware/locomo.h
 delete mode 100644 arch/arm/include/asm/hardware/sa1111.h
 delete mode 100644 arch/arm/include/asm/hardware/scoop.h
 delete mode 100644 arch/arm/include/asm/hardware/ssp.h
 delete mode 100644 arch/arm/include/asm/mach/pci.h
 delete mode 100644 arch/arm/include/asm/mach/sharpsl_param.h
 delete mode 100644 arch/arm/include/debug/dc21285.S
 delete mode 100644 arch/arm/include/debug/sa1100.S
 delete mode 100644 arch/arm/mach-at91/samv7.c
 delete mode 100644 arch/arm/mach-axxia/Kconfig
 delete mode 100644 arch/arm/mach-axxia/Makefile
 delete mode 100644 arch/arm/mach-axxia/axxia.c
 delete mode 100644 arch/arm/mach-axxia/platsmp.c
 delete mode 100644 arch/arm/mach-dove/Kconfig
 delete mode 100644 arch/arm/mach-dove/Makefile
 delete mode 100644 arch/arm/mach-dove/bridge-regs.h
 delete mode 100644 arch/arm/mach-dove/cm-a510.c
 delete mode 100644 arch/arm/mach-dove/common.c
 delete mode 100644 arch/arm/mach-dove/common.h
 delete mode 100644 arch/arm/mach-dove/dove.h
 delete mode 100644 arch/arm/mach-dove/irq.c
 delete mode 100644 arch/arm/mach-dove/irqs.h
 delete mode 100644 arch/arm/mach-dove/mpp.c
 delete mode 100644 arch/arm/mach-dove/mpp.h
 delete mode 100644 arch/arm/mach-dove/pcie.c
 delete mode 100644 arch/arm/mach-dove/pm.h
 delete mode 100644 arch/arm/mach-footbridge/Kconfig
 delete mode 100644 arch/arm/mach-footbridge/Makefile
 delete mode 100644 arch/arm/mach-footbridge/common.c
 delete mode 100644 arch/arm/mach-footbridge/common.h
 delete mode 100644 arch/arm/mach-footbridge/dc21285-timer.c
 delete mode 100644 arch/arm/mach-footbridge/dc21285.c
 delete mode 100644 arch/arm/mach-footbridge/dma-isa.c
 delete mode 100644 arch/arm/mach-footbridge/ebsa285-pci.c
 delete mode 100644 arch/arm/mach-footbridge/ebsa285.c
 delete mode 100644 arch/arm/mach-footbridge/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-footbridge/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-footbridge/include/mach/isa-dma.h
 delete mode 100644 arch/arm/mach-footbridge/include/mach/memory.h
 delete mode 100644 arch/arm/mach-footbridge/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-footbridge/isa-irq.c
 delete mode 100644 arch/arm/mach-footbridge/isa-rtc.c
 delete mode 100644 arch/arm/mach-footbridge/isa-timer.c
 delete mode 100644 arch/arm/mach-footbridge/isa.c
 delete mode 100644 arch/arm/mach-footbridge/netwinder-hw.c
 delete mode 100644 arch/arm/mach-footbridge/netwinder-pci.c
 delete mode 100644 arch/arm/mach-imx/cpu-imx31.c
 delete mode 100644 arch/arm/mach-imx/mach-imx31.c
 delete mode 100644 arch/arm/mach-imx/mach-imx7d-cm4.c
 delete mode 100644 arch/arm/mach-imx/mach-imxrt.c
 delete mode 100644 arch/arm/mach-lpc18xx/Makefile
 delete mode 100644 arch/arm/mach-lpc18xx/board-dt.c
 delete mode 100644 arch/arm/mach-mv78xx0/Kconfig
 delete mode 100644 arch/arm/mach-mv78xx0/Makefile
 delete mode 100644 arch/arm/mach-mv78xx0/bridge-regs.h
 delete mode 100644 arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
 delete mode 100644 arch/arm/mach-mv78xx0/common.c
 delete mode 100644 arch/arm/mach-mv78xx0/common.h
 delete mode 100644 arch/arm/mach-mv78xx0/irq.c
 delete mode 100644 arch/arm/mach-mv78xx0/irqs.h
 delete mode 100644 arch/arm/mach-mv78xx0/mpp.c
 delete mode 100644 arch/arm/mach-mv78xx0/mpp.h
 delete mode 100644 arch/arm/mach-mv78xx0/mv78xx0.h
 delete mode 100644 arch/arm/mach-mv78xx0/pcie.c
 delete mode 100644 arch/arm/mach-omap2/board-n8x0.c
 delete mode 100644 arch/arm/mach-omap2/clkt2xxx_dpll.c
 delete mode 100644 arch/arm/mach-omap2/clkt2xxx_dpllcore.c
 delete mode 100644 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
 delete mode 100644 arch/arm/mach-omap2/clock2xxx.h
 delete mode 100644 arch/arm/mach-omap2/clockdomains2420_data.c
 delete mode 100644 arch/arm/mach-omap2/clockdomains2430_data.c
 delete mode 100644 arch/arm/mach-omap2/cm-regbits-24xx.h
 delete mode 100644 arch/arm/mach-omap2/cm2xxx.c
 delete mode 100644 arch/arm/mach-omap2/cm2xxx.h
 delete mode 100644 arch/arm/mach-omap2/common-board-devices.h
 delete mode 100644 arch/arm/mach-omap2/gpmc.h
 delete mode 100644 arch/arm/mach-omap2/l3_2xxx.h
 delete mode 100644 arch/arm/mach-omap2/l4_2xxx.h
 delete mode 100644 arch/arm/mach-omap2/mmc.h
 delete mode 100644 arch/arm/mach-omap2/msdi.c
 delete mode 100644 arch/arm/mach-omap2/omap2-restart.c
 delete mode 100644 arch/arm/mach-omap2/omap24xx.h
 delete mode 100644 arch/arm/mach-omap2/omap_hwmod_2420_data.c
 delete mode 100644 arch/arm/mach-omap2/omap_hwmod_2430_data.c
 delete mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_interconnect_data.c
 delete mode 100644 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
 delete mode 100644 arch/arm/mach-omap2/opp2420_data.c
 delete mode 100644 arch/arm/mach-omap2/opp2430_data.c
 delete mode 100644 arch/arm/mach-omap2/opp2xxx.h
 delete mode 100644 arch/arm/mach-omap2/powerdomains2xxx_data.c
 delete mode 100644 arch/arm/mach-omap2/prm-regbits-24xx.h
 delete mode 100644 arch/arm/mach-omap2/prm2xxx.c
 delete mode 100644 arch/arm/mach-omap2/prm2xxx.h
 delete mode 100644 arch/arm/mach-omap2/sdrc2xxx.c
 delete mode 100644 arch/arm/mach-omap2/sleep24xx.S
 delete mode 100644 arch/arm/mach-omap2/sram242x.S
 delete mode 100644 arch/arm/mach-omap2/sram243x.S
 delete mode 100644 arch/arm/mach-omap2/usb-tusb6010.c
 delete mode 100644 arch/arm/mach-omap2/usb-tusb6010.h
 delete mode 100644 arch/arm/mach-omap2/voltagedomains2xxx_data.c
 delete mode 100644 arch/arm/mach-orion5x/dns323-setup.c
 delete mode 100644 arch/arm/mach-orion5x/irq.c
 delete mode 100644 arch/arm/mach-orion5x/kurobox_pro-setup.c
 delete mode 100644 arch/arm/mach-orion5x/mpp.c
 delete mode 100644 arch/arm/mach-orion5x/mpp.h
 delete mode 100644 arch/arm/mach-orion5x/mv2120-setup.c
 delete mode 100644 arch/arm/mach-orion5x/net2big-setup.c
 delete mode 100644 arch/arm/mach-orion5x/terastation_pro2-setup.c
 delete mode 100644 arch/arm/mach-orion5x/ts209-setup.c
 delete mode 100644 arch/arm/mach-orion5x/ts409-setup.c
 delete mode 100644 arch/arm/mach-orion5x/ts78xx-fpga.h
 delete mode 100644 arch/arm/mach-orion5x/ts78xx-setup.c
 delete mode 100644 arch/arm/mach-orion5x/tsx09-common.c
 delete mode 100644 arch/arm/mach-orion5x/tsx09-common.h
 delete mode 100644 arch/arm/mach-pxa/am200epd.c
 delete mode 100644 arch/arm/mach-pxa/am300epd.c
 delete mode 100644 arch/arm/mach-pxa/devices.h
 delete mode 100644 arch/arm/mach-pxa/gumstix.c
 delete mode 100644 arch/arm/mach-pxa/gumstix.h
 delete mode 100644 arch/arm/mach-pxa/sharpsl_pm.c
 delete mode 100644 arch/arm/mach-pxa/sharpsl_pm.h
 delete mode 100644 arch/arm/mach-pxa/spitz.c
 delete mode 100644 arch/arm/mach-pxa/spitz.h
 delete mode 100644 arch/arm/mach-pxa/spitz_pm.c
 delete mode 100644 arch/arm/mach-sa1100/Kconfig
 delete mode 100644 arch/arm/mach-sa1100/Makefile
 delete mode 100644 arch/arm/mach-sa1100/assabet.c
 delete mode 100644 arch/arm/mach-sa1100/clock.c
 delete mode 100644 arch/arm/mach-sa1100/collie.c
 delete mode 100644 arch/arm/mach-sa1100/generic.c
 delete mode 100644 arch/arm/mach-sa1100/generic.h
 delete mode 100644 arch/arm/mach-sa1100/h3600.c
 delete mode 100644 arch/arm/mach-sa1100/h3xxx.c
 delete mode 100644 arch/arm/mach-sa1100/include/mach/SA-1100.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/assabet.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/bitfield.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/collie.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/generic.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/h3xxx.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/jornada720.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/memory.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/mtd-xip.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/neponset.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/reset.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-sa1100/jornada720.c
 delete mode 100644 arch/arm/mach-sa1100/jornada720_ssp.c
 delete mode 100644 arch/arm/mach-sa1100/neponset.c
 delete mode 100644 arch/arm/mach-sa1100/pm.c
 delete mode 100644 arch/arm/mach-sa1100/sleep.S
 delete mode 100644 arch/arm/mach-sa1100/ssp.c
 delete mode 100644 arch/arm/mach-versatile/v2m-mps2.c
 delete mode 100644 arch/arm/plat-orion/Makefile
 delete mode 100644 arch/arm/plat-orion/common.c
 delete mode 100644 arch/arm/plat-orion/gpio.c
 delete mode 100644 arch/arm/plat-orion/include/plat/addr-map.h
 delete mode 100644 arch/arm/plat-orion/include/plat/common.h
 delete mode 100644 arch/arm/plat-orion/include/plat/irq.h
 delete mode 100644 arch/arm/plat-orion/include/plat/mpp.h
 delete mode 100644 arch/arm/plat-orion/include/plat/orion-gpio.h
 delete mode 100644 arch/arm/plat-orion/include/plat/pcie.h
 delete mode 100644 arch/arm/plat-orion/include/plat/time.h
 delete mode 100644 arch/arm/plat-orion/irq.c
 delete mode 100644 arch/arm/plat-orion/mpp.c
 delete mode 100644 arch/arm/plat-orion/pcie.c
 delete mode 100644 arch/arm/plat-orion/time.c

-- 
2.53.0

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Andreas Kemnade <andreas@kemnade.info>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-omap@vger.kernel.org
