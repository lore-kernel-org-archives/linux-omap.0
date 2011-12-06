From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH 2/3] arm/dts: OMAP: Remove bootargs node from board files
Date: Tue, 06 Dec 2011 12:06:48 -0600
Message-ID: <4EDE59B8.1070808@gmail.com>
References: <y> <1323190149-6492-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57844 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582Ab1LFSG5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Dec 2011 13:06:57 -0500
Received: by iakc1 with SMTP id c1so4020580iak.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Dec 2011 10:06:57 -0800 (PST)
In-Reply-To: <1323190149-6492-3-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>

Benoit,

On 12/06/2011 10:49 AM, Benoit Cousson wrote:
> Since 3.2, the CONFIG_ARM_ATAG_DTB_COMPAT config allows
> an old bootloader to still use ATAG to provide cmdline.
> 
> Remove chosen/bootargs from the DTS board files.
> 
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob

> ---
>  arch/arm/boot/dts/omap3-beagle.dts |    9 ---------
>  arch/arm/boot/dts/omap4-panda.dts  |    9 ---------
>  arch/arm/boot/dts/omap4-sdp.dts    |    9 ---------
>  3 files changed, 0 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index 9486be6..9f72cd4 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -13,15 +13,6 @@
>  	model = "TI OMAP3 BeagleBoard";
>  	compatible = "ti,omap3-beagle", "ti,omap3";
>  
> -	/*
> -	 * Since the initial device tree board file does not create any
> -	 * devices (MMC, network...), the only way to boot is to provide a
> -	 * ramdisk.
> -	 */
> -	chosen {
> -		bootargs = "root=/dev/ram0 rw console=ttyO2,115200n8 initrd=0x81600000,20M ramdisk_size=20480 no_console_suspend debug earlyprintk";
> -	};
> -
>  	memory {
>  		device_type = "memory";
>  		reg = <0x80000000 0x20000000>; /* 512 MB */
> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
> index c702657..9755ad5 100644
> --- a/arch/arm/boot/dts/omap4-panda.dts
> +++ b/arch/arm/boot/dts/omap4-panda.dts
> @@ -13,15 +13,6 @@
>  	model = "TI OMAP4 PandaBoard";
>  	compatible = "ti,omap4-panda", "ti,omap4430", "ti,omap4";
>  
> -	/*
> -	 * Since the initial device tree board file does not create any
> -	 * devices (MMC, network...), the only way to boot is to provide a
> -	 * ramdisk.
> -	 */
> -	chosen {
> -		bootargs = "root=/dev/ram0 rw console=ttyO2,115200n8 initrd=0x81600000,20M ramdisk_size=20480 no_console_suspend debug";
> -	};
> -
>  	memory {
>  		device_type = "memory";
>  		reg = <0x80000000 0x40000000>; /* 1 GB */
> diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
> index 066e28c..63c6b2b 100644
> --- a/arch/arm/boot/dts/omap4-sdp.dts
> +++ b/arch/arm/boot/dts/omap4-sdp.dts
> @@ -13,15 +13,6 @@
>  	model = "TI OMAP4 SDP board";
>  	compatible = "ti,omap4-sdp", "ti,omap4430", "ti,omap4";
>  
> -	/*
> -	 * Since the initial device tree board file does not create any
> -	 * devices (MMC, network...), the only way to boot is to provide a
> -	 * ramdisk.
> -	 */
> -	chosen {
> -		bootargs = "root=/dev/ram0 rw console=ttyO2,115200n8 initrd=0x81600000,20M ramdisk_size=20480 no_console_suspend debug";
> -	};
> -
>  	memory {
>  		device_type = "memory";
>  		reg = <0x80000000 0x40000000>; /* 1 GB */
