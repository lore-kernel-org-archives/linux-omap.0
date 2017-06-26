From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] multi_v7_defconfig: Enable OMAP MTD and DM816 AHCI
Date: Mon, 26 Jun 2017 00:33:34 -0700
Message-ID: <20170626073333.GR3730@atomide.com>
References: <1498045359-27376-1-git-send-email-trini@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1498045359-27376-1-git-send-email-trini@konsulko.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tom Rini <trini@konsulko.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Mihail Grigorov <michael.grigorov@konsulko.com>
List-Id: linux-omap@vger.kernel.org

* Tom Rini <trini@konsulko.com> [170621 04:42]:
> A wide variety of TI platforms support NAND via the
> CONFIG_MTD_NAND_OMAP2 driver (and related BCH options), so enable this.
> In addition, multi_v7_defconfig supports the dm8168-evm and that
> supports root being on a SATA drive, so build the DM816 AHCI driver into
> the resulting kernel as well.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Mihail Grigorov <michael.grigorov@konsulko.com>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Best that Arnd picks up this one directly:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/configs/multi_v7_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 2685e03600b1..69b0b3c0fb6c 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -202,6 +202,8 @@ CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_M25P80=y
>  CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_DENALI_DT=y
> +CONFIG_MTD_NAND_OMAP2=y
> +CONFIG_MTD_NAND_OMAP_BCH=y
>  CONFIG_MTD_NAND_ATMEL=y
>  CONFIG_MTD_NAND_BRCMNAND=y
>  CONFIG_MTD_NAND_VF610_NFC=y
> @@ -229,6 +231,7 @@ CONFIG_ATA=y
>  CONFIG_SATA_AHCI=y
>  CONFIG_SATA_AHCI_PLATFORM=y
>  CONFIG_AHCI_BRCM=y
> +CONFIG_AHCI_DM816=y
>  CONFIG_AHCI_ST=y
>  CONFIG_AHCI_IMX=y
>  CONFIG_AHCI_SUNXI=y
> -- 
> 1.9.1
> 
