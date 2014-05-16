From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 10/13] ARM: dts: am33xx: Remove obsolete properties
 from edma node
Date: Fri, 16 May 2014 08:02:17 -0700
Message-ID: <20140516150216.GA22031@atomide.com>
References: <1400242640-9902-1-git-send-email-peter.ujfalusi@ti.com>
 <1400242640-9902-11-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1400242640-9902-11-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: nsekhar@ti.com, joelf@ti.com, arnd@arndb.de, linux@arm.linux.org.uk, vinod.koul@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [140516 05:18]:
> dma-channels, ti,edma-regions and ti,edma-slots no longer needed in DT since
> the the same information is available in the IP's CCCFG register.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/boot/dts/am33xx.dtsi | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index f1eea4af40ed..37d4cad4dd38 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -147,9 +147,6 @@
>  				<0x44e10f90 0x40>;
>  			interrupts = <12 13 14>;
>  			#dma-cells = <1>;
> -			dma-channels = <64>;
> -			ti,edma-regions = <4>;
> -			ti,edma-slots = <256>;
>  		};
>  
>  		gpio0: gpio@44e07000 {
> -- 
> 1.9.3
> 
