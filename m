From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v4 4/8] ARM: DTS: omap3: add sgx gpu child node
Date: Wed, 29 Jan 2020 18:08:14 -0500
Message-ID: <3fce9260-12f2-a678-5d09-0def4d02b261@ti.com>
References: <cover.1576605726.git.hns@goldelico.com>
 <103c92a7d19387860aea406e0356249b02a3cbce.1576605726.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58976 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgA2XIy (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jan 2020 18:08:54 -0500
In-Reply-To: <103c92a7d19387860aea406e0356249b02a3cbce.1576605726.git.hns@goldelico.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Cercueil <paul@crapouillou.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, openpvrsgx-devgroup@letux.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-mips@vger.kernel.org

On 12/17/19 1:02 PM, H. Nikolaus Schaller wrote:
> and add interrupt
> 
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # OpenPandora 600 MHz.
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap34xx.dtsi | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
> index c4dd9801840d..a858a2e8002d 100644
> --- a/arch/arm/boot/dts/omap34xx.dtsi
> +++ b/arch/arm/boot/dts/omap34xx.dtsi
> @@ -159,7 +159,7 @@
>  		 * are also different clocks, but we do not have any dts users
>  		 * for it.
>  		 */
> -		sgx_module: target-module@50000000 {
> +		target-module@50000000 {
>  			compatible = "ti,sysc-omap2", "ti,sysc";
>  			reg = <0x50000014 0x4>;
>  			reg-names = "rev";
> @@ -169,10 +169,11 @@
>  			#size-cells = <1>;
>  			ranges = <0 0x50000000 0x4000>;
>  
> -			/*
> -			 * Closed source PowerVR driver, no child device
> -			 * binding or driver in mainline
> -			 */
> +			sgx: gpu@0 {
> +				compatible = "ti,omap3-sgx530-121", "img,sgx530-121", "img,sgx530";
> +				reg = <0x0 0x4000>;	/* 64kB */


Just for future reference, this range should be 0x10000.

Andrew


> +				interrupts = <21>;
> +			};
>  		};
>  	};
>  
> 
