From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 03/03] OMAP3 PM: Update the min defconfig for 3430sdp
Date: Mon, 10 Nov 2008 21:02:16 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B3582FC5@dbde02.ent.ti.com>
References: <00ca01c94327$bf74d3e0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51996 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbYKJPcZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 10:32:25 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAAFWIov014741
	for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 09:32:24 -0600
In-Reply-To: <00ca01c94327$bf74d3e0$LocalHost@wipultra1382>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Nayak, Rajendra
> Sent: Monday, November 10, 2008 5:01 PM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH 03/03] OMAP3 PM: Update the min defconfig for 3430sdp
> 
> Enables CPUFreq and PM layer implemented using SRF in 
> omap_3430sdp_min_defconfig
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/configs/omap_3430sdp_min_defconfig |   32 
> +++++++++++++++++++++++-----
>  1 files changed, 27 insertions(+), 5 deletions(-)
> 
> Index: linux-omap-2.6/arch/arm/configs/omap_3430sdp_min_defconfig
> ===================================================================
> --- 
> linux-omap-2.6.orig/arch/arm/configs/omap_3430sdp_min_de
> fconfig	2008-11-10 16:49:07.000000000 +0530
> +++ 
> linux-omap-2.6/arch/arm/configs/omap_3430sdp_min_defconfig	
> 2008-11-10 16:40:05.000000000 +0530
> @@ -204,6 +204,8 @@ CONFIG_OMAP_LL_DEBUG_UART1=y  # 
> CONFIG_OMAP_LL_DEBUG_UART2 is not set  # 
> CONFIG_OMAP_LL_DEBUG_UART3 is not set  CONFIG_OMAP_SERIAL_WAKE=y
> +# CONFIG_OMAP_PM_NOOP is not set
> +CONFIG_OMAP_PM_SRF=y
>  CONFIG_ARCH_OMAP34XX=y
>  CONFIG_ARCH_OMAP3430=y
>  
> @@ -215,6 +217,7 @@ CONFIG_MACH_OMAP_3430SDP=y  # 
> CONFIG_MACH_OMAP3EVM is not set  # CONFIG_MACH_OMAP3_BEAGLE 
> is not set  # CONFIG_MACH_OVERO is not set
> +# CONFIG_MACH_OMAP3_PANDORA is not set
>  CONFIG_OMAP_TICK_GPTIMER=1
>  
>  #
> @@ -300,9 +303,28 @@ CONFIG_CMDLINE="root=/dev/nfs nfsroot=19 
>  # CONFIG_KEXEC is not set
>  
>  #
> +# CPUIdle
> +#
> +# CONFIG_CPU_IDLE is not set
> +
> +#
>  # CPU Frequency scaling
>  #
> -# CONFIG_CPU_FREQ is not set
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPU_FREQ_TABLE=y
> +# CONFIG_CPU_FREQ_DEBUG is not set
> +CONFIG_CPU_FREQ_STAT=y
> +# CONFIG_CPU_FREQ_STAT_DETAILS is not set 
> +CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> +# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set # 
> +CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set # 
> +CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set # 
> +CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set 
> +CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> +# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set # 
> +CONFIG_CPU_FREQ_GOV_USERSPACE is not set 
> CONFIG_CPU_FREQ_GOV_ONDEMAND=y 
> +# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
>  
>  #
>  # Floating point emulation
> @@ -558,7 +580,6 @@ CONFIG_INPUT_TOUCHSCREEN=y  # 
> CONFIG_TOUCHSCREEN_PENMOUNT is not set  # 
> CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set  # 
> CONFIG_TOUCHSCREEN_TOUCHWIN is not set -# 
> CONFIG_TOUCHSCREEN_TSC2005 is not set  # 
> CONFIG_TOUCHSCREEN_UCB1400 is not set  # 
> CONFIG_TOUCHSCREEN_TOUCHIT213 is not set  # CONFIG_INPUT_MISC 
> is not set @@ -648,11 +669,8 @@ CONFIG_I2C_OMAP=y  # 
> CONFIG_ISP1301_OMAP is not set  # CONFIG_TPS65010 is not set  
> # CONFIG_SENSORS_TLV320AIC23 is not set 
> -CONFIG_TWL4030_CORE=y -CONFIG_TWL4030_GPIO=y  # 
> CONFIG_TWL4030_MADC is not set  CONFIG_TWL4030_USB=y 
> -CONFIG_TWL4030_USB_HS_ULPI=y  # CONFIG_TWL4030_PWRBUTTON is 
> not set  # CONFIG_TWL4030_POWEROFF is not set  # 
> CONFIG_SENSORS_MAX6875 is not set @@ -674,6 +692,7 @@ 
> CONFIG_GPIOLIB=y  # CONFIG_GPIO_MAX732X is not set  # 
> CONFIG_GPIO_PCA953X is not set  # CONFIG_GPIO_PCF857X is not set
> +# CONFIG_GPIO_TWL4030 is not set
>  
>  #
>  # PCI GPIO expanders:
> @@ -698,8 +717,11 @@ CONFIG_SSB_POSSIBLE=y  #  # 
> CONFIG_MFD_CORE is not set  # CONFIG_MFD_SM501 is not set
> +# CONFIG_MFD_ASIC3 is not set
>  # CONFIG_HTC_EGPIO is not set
>  # CONFIG_HTC_PASIC3 is not set
> +CONFIG_TWL4030_CORE=y
> +# CONFIG_TWL4030_POWER is not set
>  # CONFIG_MFD_TMIO is not set
>  # CONFIG_MFD_T7L66XB is not set
>  # CONFIG_MFD_TC6387XB is not set
> 
Rajendra, there seem to be problem in the line-wraps in the patch.
(Not sure if it is the mail program)

> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> 
> 