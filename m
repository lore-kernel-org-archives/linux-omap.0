From: jean-philippe francois <jp.francois@cynove.com>
Subject: Re: [PATCH 0/4 v2] mtd:nand:omap2: clean-up of supported ECC schemes
Date: Fri, 24 May 2013 15:01:14 +0200
Message-ID: <CAGGh5h3Ca8OvwLVoA-V+GYnXirQhqxOgbz_AOAc9_0gkpHzoZw@mail.gmail.com>
References: <1368791418-14330-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:49648 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579Ab3EXNBO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 May 2013 09:01:14 -0400
Received: by mail-qc0-f178.google.com with SMTP id l11so2353329qcy.23
        for <linux-omap@vger.kernel.org>; Fri, 24 May 2013 06:01:14 -0700 (PDT)
In-Reply-To: <1368791418-14330-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Philip, Avinash" <avinashphilip@ti.com>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, "Balbi, Felipe" <balbi@ti.com>

2013/5/17 Gupta, Pekon <pekon@ti.com>:
> From: "Gupta, Pekon" <pekon@ti.com>
>
> [Change v1 -> v2]
>         added   [PATCH 3/4] and [PATCH 4/4]
>
> [PATCH 1/4]: clean-up and optimization for supported ECC schemes.
> [PATCH 2/4]: add separate DT options each supported ECC scheme.
> [PATCH 3/4]: update BCH4 ECC implementation (using ELM or using lib/b=
ch.h)
> [PATCH 4/4]: update DT attribute for ti,nand-ecc-opt
>
> After this patch series, omap2-nand driver will supports following EC=
C schemes:
> +---------------------------------------+---------------+------------=
---+
> | ECC scheme                            |ECC calculation|Error detect=
ion|
> +---------------------------------------+---------------+------------=
---+
> |OMAP_ECC_HAMMING_CODE_DEFAULT          |S/W            |S/W         =
   |
> |OMAP_ECC_HAMMING_CODE_HW               |H/W (GPMC)     |S/W         =
   |
> |OMAP_ECC_HAMMING_CODE_HW_ROMCODE       |H/W (GPMC)     |S/W         =
   |
> +---------------------------------------+---------------+------------=
---+
> |OMAP_ECC_BCH4_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W (lib/bch=
=2Eh)|
> |OMAP_ECC_BCH4_CODE_HW                  |H/W (GPMC)     |H/W (ELM)   =
   |
> +---------------------------------------+---------------+------------=
---+
> |OMAP_ECC_BCH8_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W (lib/bch=
=2Eh)|
> |OMAP_ECC_BCH8_CODE_HW                  |H/W (GPMC)     |H/W (ELM)   =
   |
> +---------------------------------------+---------------+------------=
---+
> - Selection of OMAP_ECC_BCHx_CODE_HW_DETECTION_SW requires,
>         Kconfig: CONFIG_MTD_NAND_ECC_BCH: enables S/W based BCH ECC a=
lgorithm.
>
> - Selection of OMAP_ECC_BCHx_CODE_HW requires,
>         Kconfig: CONFIG_MTD_NAND_OMAP_BCH: enables ELM H/W module.
>
>

Hi,

Thank you for not dropping BCH4 with software detection.
BCH4_CODE_HW_DETECTION_SW tested sucessfully on an existing nand with B=
CH4 ECC.
- Linux flashed kernel was read by u-boot sucessfully.
- existing ubifs sucessfully mounted.

Regards,
Jean-Philippe Fran=C3=A7ois


> Gupta, Pekon (4):
>   mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC configurations in
>     device_probe
>   ARM: OMAP2+: cleaned-up DT support of various ECC schemes
>   mtd:nand:omap2: updated support for BCH4 ECC scheme
>   ARM: OMAP2+: updated ECC scheme attributes for omap2-nand DT
>
>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  52 ++-
>  arch/arm/boot/dts/am335x-evm.dts                   |   2 +-
>  arch/arm/mach-omap2/gpmc.c                         |  17 +-
>  drivers/mtd/nand/Kconfig                           |   1 -
>  drivers/mtd/nand/omap2.c                           | 413 +++++++++--=
----------
>  include/linux/platform_data/elm.h                  |   4 +
>  include/linux/platform_data/mtd-nand-omap2.h       |  22 +-
>  7 files changed, 253 insertions(+), 258 deletions(-)
>
> --
> 1.8.1
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
