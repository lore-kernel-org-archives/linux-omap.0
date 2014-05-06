From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 1/4] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Tue, 6 May 2014 08:34:31 -0700
Message-ID: <20140506153430.GD18474@atomide.com>
References: <1398152020-19391-1-git-send-email-pekon@ti.com>
 <1398152020-19391-2-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55905 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751085AbaEFPeg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2014 11:34:36 -0400
Content-Disposition: inline
In-Reply-To: <1398152020-19391-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: bcousson@baylibre.com, linux-omap <linux-omap@vger.kernel.org>

* Pekon Gupta <pekon@ti.com> [140422 00:34]:
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -9,6 +9,7 @@
>  
>  #include "am33xx.dtsi"
>  #include "am335x-bone-common.dtsi"
> +#include "am335x-bone-memory-cape.dts"
>  
>  &ldo3_reg {
>  	regulator-min-microvolt = <1800000>;
> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> @@ -9,6 +9,7 @@
>  
>  #include "am33xx.dtsi"
>  #include "am335x-bone-common.dtsi"
> +#include "am335x-bone-memory-cape.dts"
>  
>  &ldo3_reg {
>  	regulator-min-microvolt = <1800000>;

Have you checked that including the capes unconditionally for
non-integrated devices is safe? Maybe decompile the dtb using
dtc and see what is in the produced dts file?

I'm mostly worried about pinmux and GPMC as the pins can be used
by other capes and GPMC can have other devices.

Also, this should probably also wait until u-boot has been
confirmed of being able to enable these devices?

Regards,

Tony
