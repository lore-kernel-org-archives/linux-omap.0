From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v4] ARM: OMAP2+: AM33XX: omap2plus_defconfig: Add
 support for few drivers
Date: Fri, 18 Jan 2013 11:20:05 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EAF03E7@DBDE01.ent.ti.com>
References: <1357202279-6094-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52173 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab3ARLUL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 06:20:11 -0500
In-Reply-To: <1357202279-6094-1-git-send-email-anilkumar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>, "tony@atomide.com" <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Jan 03, 2013 at 14:07:59, AnilKumar, Chimata wrote:
> Adds tps65910 PMIC, lis3lv02d accelerometer, tsl2550 ambient light sensor,
> tmp275 temperature sensor, matrix keypad, gbio based leds and D_CAN drivers
> support. These peripherals are present on AM33XX family of devices (EVM,
> BeagleBone and EVMSK). One has to manually enable these support to use the
> drivers, so this patch enables all the drivers in omap2plus_defconfig

Hi Tony,

Could you please pull this patch, if there are no further comments?

Thanks
AnilKumar
 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
> Changes from v3:
> 	- Incorporated Olof Johansson's comments on v3
> 	  * Combined all the patches into a single patch
> 
> Changes from v2:
> 	- Incorporated Tony's comments on v2
> 	  * Enabled as modules instead of kernel built-in drivers.
> 	- Dropped 1st patch because it was accepted.
> 
> Changes from v1:
> 	- Incorporated martinez javier's comments on v1
> 	  * Enabled few more triggers in omap2plus_defconfig
> 	- Included Igor's patch, which modifies the omap2plus
> 	  defconfig for AM33XX devices.
> 
>  arch/arm/configs/omap2plus_defconfig |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 19b7311..9fb2373 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -52,6 +52,11 @@ CONFIG_IP_PNP_RARP=y
>  # CONFIG_INET_LRO is not set
>  # CONFIG_IPV6 is not set
>  CONFIG_NETFILTER=y
> +CONFIG_CAN=m
> +CONFIG_CAN_RAW=m
> +CONFIG_CAN_BCM=m
> +CONFIG_CAN_C_CAN=m
> +CONFIG_CAN_C_CAN_PLATFORM=m
>  CONFIG_BT=m
>  CONFIG_BT_HCIUART=m
>  CONFIG_BT_HCIUART_H4=y
> @@ -81,6 +86,9 @@ CONFIG_MTD_UBI=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
>  CONFIG_BLK_DEV_RAM_SIZE=16384
> +CONFIG_SENSORS_LIS3LV02D=m
> +CONFIG_SENSORS_TSL2550=m
> +CONFIG_SENSORS_LIS3_I2C=m
>  CONFIG_SCSI=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_SCSI_MULTI_LUN=y
> @@ -106,6 +114,7 @@ CONFIG_USB_KC2190=y
>  CONFIG_INPUT_JOYDEV=y
>  CONFIG_INPUT_EVDEV=y
>  CONFIG_KEYBOARD_GPIO=y
> +CONFIG_KEYBOARD_MATRIX=m
>  CONFIG_KEYBOARD_TWL4030=y
>  CONFIG_INPUT_TOUCHSCREEN=y
>  CONFIG_TOUCHSCREEN_ADS7846=y
> @@ -129,14 +138,17 @@ CONFIG_GPIO_SYSFS=y
>  CONFIG_GPIO_TWL4030=y
>  CONFIG_W1=y
>  CONFIG_POWER_SUPPLY=y
> +CONFIG_SENSORS_LM75=m
>  CONFIG_WATCHDOG=y
>  CONFIG_OMAP_WATCHDOG=y
>  CONFIG_TWL4030_WATCHDOG=y
>  CONFIG_MFD_TPS65217=y
> +CONFIG_MFD_TPS65910=y
>  CONFIG_REGULATOR_TWL4030=y
>  CONFIG_REGULATOR_TPS65023=y
>  CONFIG_REGULATOR_TPS6507X=y
>  CONFIG_REGULATOR_TPS65217=y
> +CONFIG_REGULATOR_TPS65910=y
>  CONFIG_FB=y
>  CONFIG_FIRMWARE_EDID=y
>  CONFIG_FB_MODE_HELPERS=y
> @@ -193,6 +205,16 @@ CONFIG_MMC_UNSAFE_RESUME=y
>  CONFIG_SDIO_UART=y
>  CONFIG_MMC_OMAP=y
>  CONFIG_MMC_OMAP_HS=y
> +CONFIG_NEW_LEDS=y
> +CONFIG_LEDS_GPIO=y
> +CONFIG_LEDS_TRIGGERS=y
> +CONFIG_LEDS_TRIGGER_TIMER=y
> +CONFIG_LEDS_TRIGGER_ONESHOT=y
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> +CONFIG_LEDS_TRIGGER_BACKLIGHT=y
> +CONFIG_LEDS_TRIGGER_CPU=y
> +CONFIG_LEDS_TRIGGER_GPIO=y
> +CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_DRV_TWL92330=y
>  CONFIG_RTC_DRV_TWL4030=y
> -- 
> 1.7.9.5
> 
> 

