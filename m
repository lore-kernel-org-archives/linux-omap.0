From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH 4/8] omap: zoom2: update defconfig
Date: Wed, 4 Nov 2009 12:39:32 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402540DC574@dbde02.ent.ti.com>
References: <1257283215-6448-1-git-send-email-vikram.pandita@ti.com>
 <1257283215-6448-2-git-send-email-vikram.pandita@ti.com>
 <1257283215-6448-3-git-send-email-vikram.pandita@ti.com>
 <1257283215-6448-4-git-send-email-vikram.pandita@ti.com>
 <1257283215-6448-5-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37127 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751486AbZKDHJc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Nov 2009 02:09:32 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA479YM5013220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 4 Nov 2009 01:09:36 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nA479Ybq006722
	for <linux-omap@vger.kernel.org>; Wed, 4 Nov 2009 12:39:34 +0530 (IST)
In-Reply-To: <1257283215-6448-5-git-send-email-vikram.pandita@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


> diff --git a/arch/arm/configs/omap_zoom2_defconfig 
> b/arch/arm/configs/omap_zoom2_defconfig
> index f1739fa..db4fc1c 100644
> --- a/arch/arm/configs/omap_zoom2_defconfig
> +++ b/arch/arm/configs/omap_zoom2_defconfig
> @@ -1,15 +1,13 @@
>  #
>  # Automatically generated make config: don't edit
> -# Linux kernel version: 2.6.30-omap1
> -# Fri Jun 12 17:25:46 2009
> +# Linux kernel version: 2.6.32-rc5
> +# Tue Nov  3 12:00:13 2009
>  #
> +# CONFIG_PHONE is not set

<...snip...>

>  
>  #
>  # Input device support

Why not enable CONFIG_KEYBOARD_TWL4030?

> @@ -619,21 +639,22 @@ CONFIG_TOUCHSCREEN_ADS7846=y
>  # CONFIG_TOUCHSCREEN_AD7879_I2C is not set
>  # CONFIG_TOUCHSCREEN_AD7879_SPI is not set
>  # CONFIG_TOUCHSCREEN_AD7879 is not set
> +# CONFIG_TOUCHSCREEN_EETI is not set
>  # CONFIG_TOUCHSCREEN_FUJITSU is not set

<...snip...>

>  # CONFIG_NEW_LEDS is not set
> +# CONFIG_ACCESSIBILITY is not set
>  CONFIG_RTC_LIB=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_HCTOSYS=y
> @@ -1128,6 +1173,7 @@ CONFIG_RTC_INTF_DEV=y
>  # CONFIG_RTC_DRV_S35390A is not set
>  # CONFIG_RTC_DRV_FM3130 is not set
>  # CONFIG_RTC_DRV_RX8581 is not set
> +# CONFIG_RTC_DRV_RX8025 is not set
>  
And here - CONFIG_RTC_DRV_TWL4030

-Manjunath