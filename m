From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 3/8] ARM: dts: omap3-overo: Use complete poweroff
Date: Thu, 27 Feb 2014 14:38:22 -0600
Message-ID: <530FA23E.1040909@ti.com>
References: <1393533032-1619-1-git-send-email-florian.vaussard@epfl.ch> <1393533032-1619-4-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44675 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026AbaB0Uiu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Feb 2014 15:38:50 -0500
In-Reply-To: <1393533032-1619-4-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 02/27/2014 02:30 PM, Florian Vaussard wrote:
> Currently, the TWL4030 PMIC does not completely poweroff the processor.
> Commit b0fc1da4d0359d3cce8f12e0f014aed0704ae202 introduced the necessary
> binding to do this, so use it.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  arch/arm/boot/dts/omap3-overo.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-overo.dtsi b/arch/arm/boot/dts/omap3-overo.dtsi
> index aea64c0..018e1e0 100644
> --- a/arch/arm/boot/dts/omap3-overo.dtsi
> +++ b/arch/arm/boot/dts/omap3-overo.dtsi
> @@ -73,6 +73,11 @@
>  			codec {
>  			};
>  		};
> +
> +		twl_power: power {
> +			compatible = "ti,twl4030-power";
> +			ti,use_poweroff;
> +		};
>  	};
>  };
>  
> 
Urrgh.. this slipped past.. :(

ti,system-power-controller is traditionally used for other PMICs from
TI to indicate that poweroff functionality will be provided by the
PMIC driver. similar approach is taken by Maxim as well.. I know the
commit introducing the binding has been around for long, but
considering that we do not have a single dts using this yet, should we
consider adding "ti,system-power-controller"(as against removing
ti,use_poweroff - so that older down stream dtbs still work) and using
it in the new code?

just proposing here.

-- 
Regards,
Nishanth Menon
