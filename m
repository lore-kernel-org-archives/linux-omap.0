From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: omap3-igep0030: Add NAND flash support
Date: Mon, 27 May 2013 10:40:30 +0200
Message-ID: <51A31BFE.7090908@ti.com>
References: <1368214859-23558-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42342 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757124Ab3E0Ikv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 May 2013 04:40:51 -0400
In-Reply-To: <1368214859-23558-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hi Javier,

On 05/10/2013 09:40 PM, Javier Martinez Canillas wrote:
> The IGEP COM Module has an 512MB NAND flash memory.
> 
> Add a device node for this NAND and its parition layout.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
> 
> Changes since v1:
>  - I just realized that sent a wrong version of the patch, sorry for the noise

And what about the first one? For igep0020?

Thanks,
Benoit

> 
>  arch/arm/boot/dts/omap3-igep0030.dts |   50 ++++++++++++++++++++++++++++++++++
>  1 files changed, 50 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
> index 9dc48d2..f65bc3a 100644
> --- a/arch/arm/boot/dts/omap3-igep0030.dts
> +++ b/arch/arm/boot/dts/omap3-igep0030.dts
> @@ -42,3 +42,53 @@
>  		};
>  	};
>  };
> +
> +&gpmc {
> +	ranges = <0 0 0x00000000 0x20000000>;
> +
> +	nand@0,0 {
> +		linux,mtd-name= "micron,mt29c4g96maz";
> +		reg = <0 0 0>;
> +		nand-bus-width = <16>;
> +		ti,nand-ecc-opt = "bch8";
> +
> +		gpmc,sync-clk-ps = <0>;
> +		gpmc,cs-on-ns = <0>;
> +		gpmc,cs-rd-off-ns = <44>;
> +		gpmc,cs-wr-off-ns = <44>;
> +		gpmc,adv-on-ns = <6>;
> +		gpmc,adv-rd-off-ns = <34>;
> +		gpmc,adv-wr-off-ns = <44>;
> +		gpmc,we-off-ns = <40>;
> +		gpmc,oe-off-ns = <54>;
> +		gpmc,access-ns = <64>;
> +		gpmc,rd-cycle-ns = <82>;
> +		gpmc,wr-cycle-ns = <82>;
> +		gpmc,wr-access-ns = <40>;
> +		gpmc,wr-data-mux-bus-ns = <0>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		partition@0 {
> +			label = "SPL";
> +			reg = <0 0x100000>;
> +		};
> +		partition@0x80000 {
> +			label = "U-Boot";
> +			reg = <0x100000 0x180000>;
> +		};
> +		partition@0x1c0000 {
> +			label = "Environment";
> +			reg = <0x280000 0x100000>;
> +		};
> +		partition@0x280000 {
> +			label = "Kernel";
> +			reg = <0x380000 0x300000>;
> +		};
> +		partition@0x780000 {
> +			label = "Filesystem";
> +			reg = <0x680000 0x1f980000>;
> +		};
> +	};
> +};
> 

