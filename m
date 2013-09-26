From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v6 0/4] mtd:nand:omap2: clean-up of supported ECC schemes
Date: Thu, 26 Sep 2013 10:58:56 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA16D07@DBDE04.ent.ti.com>
References: <1378986619-26765-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1378986619-26765-1-git-send-email-pekon@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: "Rob Herring (robherring2@gmail.com)" <robherring2@gmail.com>, "Mark
 Rutland (mark.rutland@arm.com)" <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Stephen Warren <swarren@wwwdotorg.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "computersforpeace@gmail.com" <computersforpeace@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi,
 Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "olof@lixom.net" <olof@lixom.net>, "benoit.cousson@linaro.org" <benoit.cousson@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

> 
> *Changes v5 -> v6*
> [PATCH 1/4]:
> 	- updated DT binding for gpmc-nand based on 'Olof Johansson's
> feedbacks
> 	http://lists.infradead.org/pipermail/linux-mtd/2013-
> August/048394.html
> 	- detection of ELM device via ti,elm-id DT node, moved to gpmc.c
> driver
> [PATCH 2/4]
> 	- removed: support for following obselete ECC schemes
> 	OMAP_ECC_HAMMING_CODE_DEFAULT (S/W based 1-bit Hamming
> ECC)
> 	OMAP_ECC_HAMMING_CODE_HW_ROMCODE (H/W based 1-bit
> Hamming ECC scheme)
> 	- updated: using omap_oobinfo as chip->ecc.layout for all ecc-
> schemes
> 	- clean: error messages
> [PATCH 3/4] cleaned to include changes for OMAP_ECC_BCH8_CODE_HW
> only
> [PATCH 4/4] updated to include DT property changes
> 
> 
> *Changes v4 -> v5*
> - Rebased to linux-next
> IMPORTANT: Need to revert commit fb1585b, [PATCH 2/4] part of previous
> version
> 	http://lists.infradead.org/pipermail/linux-mtd/2013-July/047441.html
> 
> - Swapped PATCH-1 & PATCH-2 to maintain bisectibility & compilation
> dependency
> 	http://lists.infradead.org/pipermail/linux-mtd/2013-July/047461.html
> 
> - PATCH-2: re-ordered call to is_elm_present() for later updates ELM driver
> 	- dropped changes in include/linux/platform_data/elm.h (not
> needed)
> - PATCH-3: re-ordered call to is_elm_present() for later updates ELM driver
> - Re-formated patch description (replaced tabs with white-spaces)
> 
> 
> *Changes v3 -> v4*
> (Resent with CC: devicetree-discuss@lists.ozlabs.org)
> - [Patch 1/3] removed MTD_NAND_OMAP_BCH8 &
> MTD_NAND_OMAP_BCH4 from nand/Kconfig
> 	ECC scheme selectable via nand DT (nand-ecc-opt).
> - [*] rebased for l2-mtd.git
> 
> 
> *Changes v2 -> v3*
> (Resent with Author Name fixed)
> - PATCH-1: re-arranged code to remove redundancy, added
> NAND_BUSWIDTH_AUTO
> - PATCH-2: updated nand-ecc-opt DT mapping and Documentation
> - PATCH-3: code-cleaning + changes to match PATCH-1
> - PATCH-4 <DROPPED> update DT attribute for ti,nand-ecc-opt
> 	- received feedback to keep DT mapping independent of linuxism
> - PATCH-4:<NEW> : ARM: dts: AM33xx: updated default ECC scheme in nand-
> ecc-opt
> 	- independent patch for AM335x-evm.dts update based on PATCH-2
> 
> 
> *Changes v1 -> v2*
> 	added 	[PATCH 3/4] and [PATCH 4/4]
> 
> 
> *Patches in this series*
> [PATCH 1/4]->[PATCH v5 2/4]: clean-up and optimization for supported ECC
> schemes.
> [PATCH 2/4]->[PATCH v5 1/4]: add separate DT options each supported ECC
> scheme.
> [PATCH 3/4]: update BCH4 ECC implementation (using ELM or using lib/bch.h)
> [PATCH 4/4]: ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-
> opt
> 
> After this patch series, omap2-nand driver will supports following ECC
> schemes:
> +---------------------------------------+---------------+---------------+
> | ECC scheme                            |ECC calculation|Error detection|
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_HAMMING_CODE_HW               |H/W (GPMC)     |S/W            |
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_BCH4_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W
> (lib/bch.h)|
> |OMAP_ECC_BCH4_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_BCH8_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W
> (lib/bch.h)|
> |OMAP_ECC_BCH8_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
> +---------------------------------------+---------------+---------------+
> - Selection of OMAP_ECC_BCHx_CODE_HW_DETECTION_SW requires,
> 	Kconfig: CONFIG_MTD_NAND_ECC_BCH: enables S/W based BCH
> ECC algorithm.
> 
> - Selection of OMAP_ECC_BCHx_CODE_HW requires,
> 	Kconfig: CONFIG_MTD_NAND_OMAP_BCH: enables ELM H/W
> module.
> 
> Pekon Gupta (4):
>   ARM: OMAP2+: cleaned-up DT support of various ECC schemes
>   mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW ECC configurations in
>     device_probe
>   mtd:nand:omap2: updated support for BCH4 ECC scheme
>   ARM: dts: AM33xx: updated default ECC scheme in nand-ecc-opt
> 
>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  14 +-
>  arch/arm/boot/dts/am335x-evm.dts                   |   2 +-
>  arch/arm/mach-omap2/board-flash.c                  |   2 +-
>  arch/arm/mach-omap2/gpmc.c                         |  47 +-
>  drivers/mtd/nand/Kconfig                           |  30 +-
>  drivers/mtd/nand/omap2.c                           | 526 ++++++++++-----------
>  include/linux/platform_data/mtd-nand-omap2.h       |  18 +-
>  7 files changed, 309 insertions(+), 330 deletions(-)
> 
> --
> 1.8.1
+ Rob Herring <robherring2@gmail.com>
+ Mark Rutland <mark.rutland@arm.com>
+ Pawel Moll <pawel.moll@arm.com>
+ Ian Campbell <ijc+devicetree@hellion.org.uk>
+ Stephen Warren <swarren@wwwdotorg.org>

CC other DT maintainers, who were missed earlier in mail-chain.

with regards, pekon

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
