From: jean-philippe francois <jp.francois@cynove.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: cleaned-up DT support of various ECC schemes
Date: Thu, 16 May 2013 09:26:43 +0200
Message-ID: <CAGGh5h16kxdPRtPQ4vRzLA4iMxjTurPpdzBiEHaM9zb+y8fJBg@mail.gmail.com>
References: <1368684720-26763-1-git-send-email-pekon@ti.com>
	<1368684720-26763-3-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:63909 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439Ab3EPH0p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 03:26:45 -0400
Received: by mail-we0-f171.google.com with SMTP id u55so2262510wes.2
        for <linux-omap@vger.kernel.org>; Thu, 16 May 2013 00:26:44 -0700 (PDT)
In-Reply-To: <1368684720-26763-3-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, avinashphilip@ti.com, arnd@arndb.de, Tony Lindgren <tony@atomide.com>, balbi@ti.com

2013/5/16 Gupta, Pekon <pekon@ti.com>:
> From: "Gupta, Pekon" <pekon@ti.com>
>
> ECC scheme on NAND devices can be implemented in multiple ways.Some using
> Software algorithm, while others using in-build Hardware engines.
> omap2-nand driver currently supports following flavours of ECC schemes,
> selectable via DTB.
>
> +---------------------------------------+---------------+---------------+
> | ECC scheme                            |ECC calculation|Error detection|
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_HAMMING_CODE_DEFAULT          |S/W            |S/W            |
> |OMAP_ECC_HAMMING_CODE_HW               |H/W (GPMC)     |S/W            |
> |OMAP_ECC_HAMMING_CODE_HW_ROMCODE       |H/W (GPMC)     |S/W            |
> +---------------------------------------+---------------+---------------+
> |(requires CONFIG_MTD_NAND_ECC_BCH)     |               |               |
> |OMAP_ECC_BCH8_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W            |
> +---------------------------------------+---------------+---------------+
> |(requires CONFIG_MTD_NAND_OMAP_BCH)    |               |               |
> |OMAP_ECC_BCH8_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
> +---------------------------------------+---------------+---------------+
>
> Selection of some ECC schemes also require enabling following Kconfig options.
> This was done to optimize footprint of omap2-nand driver.
> -Kconfig:CONFIG_MTD_NAND_ECC_BCH        enables S/W based BCH ECC algorithm
> -Kconfig:CONFIG_MTD_NAND_OMAP_BCH       enables H/W based BCH ECC algorithm
>

OMAP_ECC_BCH4_CODE_HW_DETECTION_SW and  OMAP_ECC_BCH4_CODE_HW
seems to exist in the code, but are not in the changelog, and not in
the device tree binding documentation.


> Signed-off-by: Gupta, Pekon <pekon@ti.com>
> ---
>  .../devicetree/bindings/mtd/gpmc-nand.txt          | 37 +++++++++++++++-------
>  arch/arm/boot/dts/am335x-evm.dts                   |  2 +-
>  arch/arm/mach-omap2/gpmc.c                         | 12 ++++---
>  3 files changed, 34 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> index e7f8d7e..de180be 100644
> --- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> @@ -17,20 +17,35 @@ Required properties:
>
>  Optional properties:
>
> - - nand-bus-width:             Set this numeric value to 16 if the hardware
> -                               is wired that way. If not specified, a bus
> -                               width of 8 is assumed.
> + - nand-bus-width:             Determines data-width of the connected device
> +                               x16 = "16"
> +                               x8  = "8" (default)
>
> - - ti,nand-ecc-opt:            A string setting the ECC layout to use. One of:
>
> -               "sw"            Software method (default)
> -               "hw"            Hardware method
> -               "hw-romcode"    gpmc hamming mode method & romcode layout
> -               "bch4"          4-bit BCH ecc code
> -               "bch8"          8-bit BCH ecc code
> + - ti,nand-ecc-opt:            Determines the ECC scheme used by driver.
> +                               It can be any of the following strings:
> +
> +       "hamming_sw"            1-bit Hamming ECC using software
> +
> +       "hamming_hw"            1-bit Hamming ECC using hardware
> +
> +       "hamming_hw_romcode"    1-bit Hamming ECC using hardware
> +                               - ECC layout compatible to ROM code
> +
> +       "bch8_hw_detection_sw"  8-bit BCH with ECC calculation in hardware
> +                               and error detection in software
> +                               - requires Kconfig CONFIG_MTD_NAND_ECC_BCH
> +
> +       "bch8_hw"               8-bit BCH with ECC calculation in hardware
> +                               and error detection in hardware
> +                               - requires <elm_id> to be specified
> +                               - requires Kconfig CONFIG_MTD_NAND_OMAP_BCH
> +
> +
> +
> + - elm_id:                     Specifies elm device node. This is required to
> +                               support some BCH ECC schemes mentioned above.
>
> - - elm_id:     Specifies elm device node. This is required to support BCH
> -               error correction using ELM module.
>
>  For inline partiton table parsing (optional):
>
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index 0b8f161..60e8f59 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -135,7 +135,7 @@
>                         nand@0,0 {
>                                 reg = <0 0 0>; /* CS0, offset 0 */
>                                 nand-bus-width = <8>;
> -                               ti,nand-ecc-opt = "bch8";
> +                               ti,nand-ecc-opt = "bch8_hw";
>
>                                 gpmc,sync-clk = <0>;
>                                 gpmc,cs-on = <0>;
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 410e1ba..03b8027 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1205,11 +1205,13 @@ static void __maybe_unused gpmc_read_timings_dt(struct device_node *np,
>  #ifdef CONFIG_MTD_NAND
>
>  static const char * const nand_ecc_opts[] = {
> -       [OMAP_ECC_HAMMING_CODE_DEFAULT]         = "sw",
> -       [OMAP_ECC_HAMMING_CODE_HW]              = "hw",
> -       [OMAP_ECC_HAMMING_CODE_HW_ROMCODE]      = "hw-romcode",
> -       [OMAP_ECC_BCH4_CODE_HW]                 = "bch4",
> -       [OMAP_ECC_BCH8_CODE_HW]                 = "bch8",
> +       [OMAP_ECC_HAMMING_CODE_DEFAULT]         = "hamming_sw",
> +       [OMAP_ECC_HAMMING_CODE_HW]              = "hamming_hw",
> +       [OMAP_ECC_HAMMING_CODE_HW_ROMCODE]      = "hamming_hw_romcode",
> +       [OMAP_ECC_BCH4_CODE_HW]                 = "bch4_hw",
> +       [OMAP_ECC_BCH4_CODE_HW_DETECTION_SW]    = "bch4_hw_detection_sw",
> +       [OMAP_ECC_BCH8_CODE_HW]                 = "bch8_hw",
> +       [OMAP_ECC_BCH8_CODE_HW_DETECTION_SW]    = "bch8_hw_detection_sw"
>  };
>
>  static int gpmc_probe_nand_child(struct platform_device *pdev,
> --
> 1.8.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
