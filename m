From: "Philip, Avinash" <avinashphilip@ti.com>
Subject: RE: [PATCH] ARM: dts: AM33XX: Corrects typo in interrupt field in
 SPI node
Date: Fri, 1 Feb 2013 06:10:25 +0000
Message-ID: <518397C60809E147AF5323E0420B992E3EA6977C@DBDE01.ent.ti.com>
References: <1359697047-1816-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37207 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918Ab3BAGLy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 01:11:54 -0500
In-Reply-To: <1359697047-1816-1-git-send-email-avinashphilip@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, "Bedia, Vaibhav" <vaibhav.bedia@ti.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>

On Fri, Feb 01, 2013 at 11:07:27, Philip, Avinash wrote:
> DT field of "interrupts" was mentioned wrongly as "interrupt" in SPI
> node. This went unnoticed as spi-omap2 driver not making use of
> interrupt. Fixes the typo.
> 
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>

Reported-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

Typo mistake was reported by Vaibhav. I forgot to mention "Reported-by"
tag while posting. Add the same on his behalf.

Thanks
Avinash

> ---
>  arch/arm/boot/dts/am33xx.dtsi |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index fbcb90b..cece3ad 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -309,7 +309,7 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0x48030000 0x400>;
> -			interrupt = <65>;
> +			interrupts = <65>;
>  			ti,spi-num-cs = <2>;
>  			ti,hwmods = "spi0";
>  			status = "disabled";
> @@ -320,7 +320,7 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0x481a0000 0x400>;
> -			interrupt = <125>;
> +			interrupts = <125>;
>  			ti,spi-num-cs = <2>;
>  			ti,hwmods = "spi1";
>  			status = "disabled";
> -- 
> 1.7.9.5
> 
> 

