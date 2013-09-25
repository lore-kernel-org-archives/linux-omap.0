From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v6 1/4] ARM: OMAP2+: cleaned-up DT support of various ECC schemes
Date: Wed, 25 Sep 2013 17:23:55 -0500
Message-ID: <CAL_Jsq+XxQ_9ik_P8EPPNSzXiCz6yd-VJLRU668t3jvD-jhyOw@mail.gmail.com>
References: <1378986619-26765-1-git-send-email-pekon@ti.com>
	<1378986619-26765-2-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:33247 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab3IYWX4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Sep 2013 18:23:56 -0400
In-Reply-To: <1378986619-26765-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: dedekind1@gmail.com, Olof Johansson <olof@lixom.net>, computersforpeace@gmail.com, dwmw2@infradead.org, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, benoit.cousson@linaro.org, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, Sep 12, 2013 at 6:50 AM, Pekon Gupta <pekon@ti.com> wrote:
> OMAP NAND driver support multiple ECC scheme, which can used in following
> different flavours, depending on in-build Hardware engines supported by SoC.
>
> +---------------------------------------+---------------+---------------+
> | ECC scheme                            |ECC calculation|Error detection|
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_HAMMING_CODE_HW               |H/W (GPMC)     |S/W            |
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_BCH8_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W            |
> |(requires CONFIG_MTD_NAND_ECC_BCH)     |               |               |
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_BCH8_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
> |(requires CONFIG_MTD_NAND_OMAP_BCH &&  |               |               |
> | ti,elm-id in DT)                      |               |               |
> +---------------------------------------+---------------+---------------+
> To optimize footprint of omap2-nand driver, selection of some ECC schemes
> also require enabling following Kconfigs, in addition to setting appropriate
> DT bindings
> - Kconfig:CONFIG_MTD_NAND_ECC_BCH        enables S/W based BCH ECC algorithm
> - Kconfig:CONFIG_MTD_NAND_OMAP_BCH       enables H/W based BCH ECC algorithm
>
> This patch
> - updates DT binding for selection of ecc-scheme
> - updates DT binding for detection of ELM h/w engine
> - removes following obselete ECC schemes
>         OMAP_ECC_HAMMING_CODE_DEFAULT (S/W based 1-bit Hamming ECC)
>         OMAP_ECC_HAMMING_CODE_HW_ROMCODE (H/W based 1-bit Hamming ECC scheme)
> - updates DT binding documentation for mtd/gpmc-nand
>
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  .../devicetree/bindings/mtd/gpmc-nand.txt          | 14 +++----
>  arch/arm/mach-omap2/board-flash.c                  |  2 +-
>  arch/arm/mach-omap2/gpmc.c                         | 47 +++++++++++++++-------
>  include/linux/platform_data/mtd-nand-omap2.h       | 23 +++++++----
>  4 files changed, 56 insertions(+), 30 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> index df338cb..958e5d5 100644
> --- a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> @@ -21,11 +21,8 @@ Optional properties:
>                                 is wired that way. If not specified, a bus
>                                 width of 8 is assumed.
>
> - - ti,nand-ecc-opt:            A string setting the ECC layout to use. One of:
> -
> -               "sw"            Software method (default)
> -               "hw"            Hardware method
> -               "hw-romcode"    gpmc hamming mode method & romcode layout
> + - ti,nand-ecc-scheme:         A string setting the ECC layout to use. One of:
> +               "ham1"          1-bit Hamming ecc code

As has been pointed out, this breaks compatibility which should be
avoided unless you know the state of use of this binding. I fail to
see the advantage of using scheme over opt. You could simply add ham1
here and maintain compatibility. Instead of removing sw, hw, etc. you
can simply deprecate them or decide that the kernel doesn't support
those options.

However, since you are willing to break compatibility, then you should
the generic NAND binding and use nand-ecc-mode adding the values you
need.

Documentation/devicetree/bindings/mtd/nand.txt:
* MTD generic binding

- nand-ecc-mode : String, operation mode of the NAND ecc mode.
  Supported values are: "none", "soft", "hw", "hw_syndrome", "hw_oob_first",
  "soft_bch".
- nand-bus-width : 8 or 16 bus width if not present 8
- nand-on-flash-bbt: boolean to enable on flash bbt option if not present false


>                 "bch4"          4-bit BCH ecc code
>                 "bch8"          8-bit BCH ecc code
>
> @@ -36,8 +33,11 @@ Optional properties:
>                 "prefetch-dma"          Prefetch enabled sDMA mode
>                 "prefetch-irq"          Prefetch enabled irq mode
>
> - - elm_id:     Specifies elm device node. This is required to support BCH
> -               error correction using ELM module.
> + - ti,elm-id:  Specifies pHandle of the ELM devicetree node.
> +               ELM is an on-chip hardware engine on TI SoC which is used for
> +               locating ECC errors for BCHx algorithms. SoC devices which have
> +               ELM hardware engines should specify this device node in .dtsi
> +               Using ELM for ECC error correction frees some CPU cycles.

While yes, this is better name and documentation, I don't know that
breaking compatibility is justified.

Rob
