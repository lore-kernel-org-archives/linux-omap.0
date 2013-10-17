From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v9 5/9] mtd:nand:omap2: clean-up BCHx_HW and BCHx_SW
 ECC configurations in device_probe
Date: Wed, 16 Oct 2013 18:58:54 -0700
Message-ID: <20131017015854.GA23337@ld-irv-0074.broadcom.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
 <1381816197-20477-6-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:63245 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761478Ab3JQB7A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Oct 2013 21:59:00 -0400
Content-Disposition: inline
In-Reply-To: <1381816197-20477-6-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, olof@lixom.net, dedekind1@gmail.com, tony@atomide.com, bcousson@baylibre.com, robherring2@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Oct 15, 2013 at 11:19:53AM +0530, Pekon Gupta wrote:
> current implementation in omap3_init_bch() has some redundant code like:
> (1) omap3_init_bch() re-probes the DT-binding to detect presence of ELM h/w
>     engine on SoC. And based on that it selects implemetation of ecc-scheme.
>     However, this is already done as part of GPMC DT parsing.
> (2) As omap3_init_bch() serves as common function for configuring all types of
>     BCHx ecc-schemes, so there are multiple levels of redudant if..then..else
>     checks while populating nand_chip->ecc.
> 
> This patch make following changes to OMAP NAND driver:
> (1) removes omap3_init_bch(): each ecc-scheme is individually configured in
>     omap_nand_probe() there by removing redundant if..then..else checks.
> (2) adds is_elm_present(): re-probing of ELM device via DT is not required as
>     it's done in GPMC driver probe. Thus is_elm_present() just initializes ELM
>     driver with NAND probe data, when ecc-scheme with h/w based error-detection
>     is used.
> (3) separates out configuration of different flavours of "BCH4" and "BCH8"
>     ecc-schemes as given in below table
> (4) conditionally compiles callbacks implementations of ecc.hwctl(),
>     ecc.calculate(), ecc.correct() to avoid warning of un-used functions.
> 
> +---------------------------------------+---------------+---------------+
> | ECC scheme                            |ECC calculation|Error detection|
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_HAM1_CODE_HW                  |H/W (GPMC)     |S/W            |
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_BCH4_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W (lib/bch.c)|
> | (needs CONFIG_MTD_NAND_ECC_BCH)       |               |               |
> |                                       |               |               |
> |OMAP_ECC_BCH4_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
> | (needs CONFIG_MTD_NAND_OMAP_BCH &&    |               |               |
> |        ti,elm-id)                     |               |               |
> +---------------------------------------+---------------+---------------+
> |OMAP_ECC_BCH8_CODE_HW_DETECTION_SW     |H/W (GPMC)     |S/W (lib/bch.c)|
> | (needs CONFIG_MTD_NAND_ECC_BCH)       |               |               |
> |                                       |               |               |
> |OMAP_ECC_BCH8_CODE_HW                  |H/W (GPMC)     |H/W (ELM)      |
> | (needs CONFIG_MTD_NAND_OMAP_BCH &&    |               |               |
> |        ti,elm-id)                     |               |               |
> +---------------------------------------+---------------+---------------+
> 
> - 'CONFIG_MTD_NAND_ECC_BCH' is generic KConfig required to build lib/bch.c
>     which is required for ECC error detection done in software.
>     (mainly used for legacy platforms which do not have on-chip ELM engine)
> 
> - 'CONFIG_MTD_NAND_OMAP_BCH' is OMAP specific Kconfig to detemine presence
>     on ELM h/w engine on SoC.
> 
> Signed-off-by: Pekon Gupta <pekon@ti.com>

This patch looks good to me.

Brian
