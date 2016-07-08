From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH v2] arm: omap1_defconfig: convert to use libata PATA
 drivers
Date: Sat, 9 Jul 2016 01:06:53 +0300
Message-ID: <20160708220653.GB14630@raspberrypi.musicnaut.iki.fi>
References: <1467985859-23500-1-git-send-email-b.zolnierkie@samsung.com>
 <1467985859-23500-2-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1467985859-23500-2-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Jul 08, 2016 at 03:50:59PM +0200, Bartlomiej Zolnierkiewicz wrote:
> IDE subsystem has been deprecated since 2009 and the majority
> (if not all) of Linux distributions have switched to use
> libata for ATA support exclusively.  However there are still
> some users (mostly old or/and embedded non-x86 systems) that
> have not converted from using IDE subsystem to libata PATA
> drivers.  This doesn't seem to be good thing in the long-term
> for Linux as while there is less and less PATA systems left
> in use:
> 
> * testing efforts are divided between two subsystems
> 
> * having duplicate drivers for same hardware confuses users
> 
> This patch converts omap1_defconfig to use libata PATA
> drivers.
> 
> Cc: linux-omap@vger.kernel.org
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

I have been using ATA/PATA_PCMCIA on OMAP1 already for a while, so:

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
> v2:
> - added Acked-by tag from Tony
> 
>  arch/arm/configs/omap1_defconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
> index 0c8a787..6ffc984 100644
> --- a/arch/arm/configs/omap1_defconfig
> +++ b/arch/arm/configs/omap1_defconfig
> @@ -96,14 +96,14 @@ CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
>  CONFIG_BLK_DEV_RAM_COUNT=2
>  CONFIG_BLK_DEV_RAM_SIZE=8192
> -CONFIG_IDE=m
> -CONFIG_BLK_DEV_IDECS=m
>  CONFIG_SCSI=y
>  # CONFIG_SCSI_PROC_FS is not set
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_CHR_DEV_ST=y
>  CONFIG_BLK_DEV_SR=y
>  CONFIG_CHR_DEV_SG=y
> +CONFIG_ATA=m
> +CONFIG_PATA_PCMCIA=m
>  CONFIG_NETDEVICES=y
>  CONFIG_TUN=y
>  CONFIG_PHYLIB=y
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
