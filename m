From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: omap2plus_defconfig: Enable AT24 eeprom
Date: Mon, 22 Feb 2016 10:13:54 -0800
Message-ID: <20160222181354.GN13417@atomide.com>
References: <1456159868-32416-1-git-send-email-nm@ti.com>
 <1456159868-32416-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456159868-32416-3-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [160222 08:51]:
> AT24 compatible eeproms are used in BB family and X15 boards.
> 
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/configs/omap2plus_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index d18d6b42fcf5..fa82f4e25d0e 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -145,6 +145,7 @@ CONFIG_BLK_DEV_RAM_SIZE=16384
>  CONFIG_SENSORS_TSL2550=m
>  CONFIG_BMP085_I2C=m
>  CONFIG_SRAM=y
> +CONFIG_EEPROM_AT24=m
>  CONFIG_SENSORS_LIS3_I2C=m
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_SCSI_SCAN_ASYNC=y

Applying into omap-for-v4.6/defconfig.

Thanks,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
