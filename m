From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 1/4] ARM: dts: am335x-bone: add support for beaglebone
 NAND cape
Date: Mon, 19 May 2014 09:25:33 -0700
Message-ID: <20140519162532.GF4849@atomide.com>
References: <1400490948-11571-1-git-send-email-pekon@ti.com>
 <1400490948-11571-2-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52673 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964975AbaESQZm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 12:25:42 -0400
Content-Disposition: inline
In-Reply-To: <1400490948-11571-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>

* Pekon Gupta <pekon@ti.com> [140519 02:16]:
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

Based on the recent discussions on the capes, it seems that nobody
wants to implement toggling of the capes in u-boot. And as there
can be other capes using GPMC bus, we can't merge this. And because
the capes are stackable, we can't really have .dts files for all
the combinations. And no, we're not merging any unconnected .dts
files either, sorry.

Regards,

Tony
