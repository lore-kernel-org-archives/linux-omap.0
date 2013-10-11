From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v8 0/6] mtd:nand:omap2: clean-up of supported ECC
 schemes
Date: Fri, 11 Oct 2013 14:09:24 -0700
Message-ID: <20131011210924.GO23337@ld-irv-0074.broadcom.com>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:47536 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab3JKVJa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 17:09:30 -0400
Content-Disposition: inline
In-Reply-To: <1381498603-15715-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, robherring2@gmail.com, olof@lixom.net, dedekind1@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

Hi Pekon,

I will try to summarize the standing of your patch series.

Patches 1 and 2 look good and have addressed all of the DT maintainers'
comments, AFAICT. They are ready to go in, except that the following
patches are not ready; they should probably go in together.

You ignored most of my comments to patch 3, and it is insufficiently
documented. Please take a look at my comments, both here (in v8) and in
v6. It still should be split into more patches.

Patch 4 does too much without describing it. Why are you dropping the
old omap3_correct_data_bch() code? Is this just refactoring? If so, you
should say so. And this also suggests that you have two logical changes
going on that should be separated into different patches; one to
refactor the open-coded NAND/BCH library to replace it with the
nand_bch.{c,h} support library and one for the new ECC modes.

Patch 5 is good but should wait until the other DT parts are acceptable
and merged into MTD.

Patch 6 needs rewriting to use devm_* functions properly, but it was
never integral to this patch series. You can improve it and resend with
this series or just send it separately afterward.

On Fri, Oct 11, 2013 at 07:06:37PM +0530, Pekon Gupta wrote:
> *Changes v7 -> v8*
> [PATCH 1/6] <no updates>
> [PATCH 2/6]
> 	- updated DT parsing of "ti,nand-ecc-opts" so that its "ham1" remains
> 		compatible to "sw","hw","hw-romcode"
> 	- updated DT parsing of "ti,elm-id" to retain compatibility to "elm_id"
> 	- using of_parse_phandle() to get ELM device pointer from DT
> [PATCH 3..6/6] <commit log updates>
> 
> 
> *Changes v6 -> v7*
> [PATCH 1/6] <NEW> split from [PATCH v6 2/4] as per feedbacks of Brain Norris
> [PATCH 2/6] incorporated feedbacks from DT maintainers
> [PATCH 3/6] patch cleaning and incorporated feedbacks from Brain Norris

You did not incorporate most of my feedback here. Also, my name is
'Brian' not 'Brain', although I'm flattered ;)

> [PATCH 4/6] rebasing changes and cleanup
> [PATCH 5/6] updated omap3430-sdp.dts
> [PATCH 6/6] <NEW> updated for devm_xx

...

> After this patch series, omap2-nand driver will supports following ECC schemes:
> +---------------------------------------+---------------+---------------+
> | ECC scheme                            |ECC calculation|Error detection|
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_HAM1_CODE_HW                  |H/W (GPMC)     |S/W            |
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_BCH4_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W (lib/bch.h)|
> |OMAP_ECC_BCH4_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_BCH8_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W (lib/bch.h)|
> |OMAP_ECC_BCH8_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
> +---------------------------------------+---------------+---------------+
> 
> To optimize footprint of omap2-nand driver, selection of some ECC schemes
> also require enabling following Kconfigs, in addition to setting appropriate
> DT bindings
> - Kconfig:CONFIG_MTD_NAND_ECC_BCH        error detection done in software
> - Kconfig:CONFIG_MTD_NAND_OMAP_BCH       error detection done by h/w engine
> 
> 
> Pekon Gupta (6):
>   mtd: nand: omap: combine different flavours of 1-bit hamming ecc
>     schemes
>   ARM: OMAP2+: cleaned-up DT support of various ECC schemes
>   mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC configurations in
>     device_probe
>   mtd:nand:omap2: updated support for BCH4 ECC scheme
>   ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
>   mtd: nand: omap: updated devm_xx for all resource allocation and free
>     calls
> 
>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  16 +-
>  arch/arm/boot/dts/am335x-evm.dts                   |   3 +-
>  arch/arm/boot/dts/omap3430-sdp.dts                 |   2 +-
>  arch/arm/mach-omap2/board-flash.c                  |   2 +-
>  arch/arm/mach-omap2/gpmc.c                         |  47 +-
>  drivers/mtd/nand/Kconfig                           |  30 +-
>  drivers/mtd/nand/omap2.c                           | 569 ++++++++++-----------
>  include/linux/platform_data/mtd-nand-omap2.h       |  18 +-
>  8 files changed, 333 insertions(+), 354 deletions(-)

Brian
