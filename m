From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] drm/omap: Migrate minimum FCK/PCK ratio from Kconfig to
 dts
Date: Thu, 13 Jun 2019 14:22:20 -0600
Message-ID: <20190613202220.GA4282@bogus>
References: <20190510194229.20628-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190510194229.20628-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: linux-omap@vger.kernel.org, adam.ford@logicpd.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, May 10, 2019 at 02:42:29PM -0500, Adam Ford wrote:
> Currently the source code is compiled using hard-coded values
> from CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK.  This patch allows this
> clock divider value to be moved to the device tree and be changed
> without having to recompile the kernel.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 
> diff --git a/Documentation/devicetree/bindings/display/ti/ti,omap3-dss.txt b/Documentation/devicetree/bindings/display/ti/ti,omap3-dss.txt
> index cd02516a40b6..42449d07c47e 100644
> --- a/Documentation/devicetree/bindings/display/ti/ti,omap3-dss.txt
> +++ b/Documentation/devicetree/bindings/display/ti/ti,omap3-dss.txt
> @@ -40,7 +40,7 @@ Required properties:
>  Optional properties:
>  - max-memory-bandwidth: Input memory (from main memory to dispc) bandwidth limit
>  			in bytes per second
> -
> +- min-fck-pck-ratio:  Make sure that DISPC FCK is at least n x PCK

Assuming this patch progresses, this needs a vendor prefix and please 
split bindings to separate patch.

>  
>  RFBI
>  ----
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 4043ecb38016..bf84a8487aae 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -751,7 +751,7 @@
>  			#size-cells = <1>;
>  			ranges;
>  
> -			dispc@48050400 {
> +			dispc: dispc@48050400 {

Unrelated change.

>  				compatible = "ti,omap3-dispc";
>  				reg = <0x48050400 0x400>;
>  				interrupts = <25>;
> diff --git a/drivers/gpu/drm/omapdrm/dss/Kconfig b/drivers/gpu/drm/omapdrm/dss/Kconfig
> index f24ebf7f61dd..d0666edcdf2a 100644
> --- a/drivers/gpu/drm/omapdrm/dss/Kconfig
> +++ b/drivers/gpu/drm/omapdrm/dss/Kconfig
> @@ -102,24 +102,6 @@ config OMAP2_DSS_DSI
>  
>  	  See http://www.mipi.org/ for DSI specifications.
>  
> -config OMAP2_DSS_MIN_FCK_PER_PCK
> -	int "Minimum FCK/PCK ratio (for scaling)"
> -	range 0 32
> -	default 0
> -	help
> -	  This can be used to adjust the minimum FCK/PCK ratio.
> -
> -	  With this you can make sure that DISPC FCK is at least
> -	  n x PCK. Video plane scaling requires higher FCK than
> -	  normally.
> -
> -	  If this is set to 0, there's no extra constraint on the
> -	  DISPC FCK. However, the FCK will at minimum be
> -	  2xPCK (if active matrix) or 3xPCK (if passive matrix).
> -
> -	  Max FCK is 173MHz, so this doesn't work if your PCK
> -	  is very high.
> -
>  config OMAP2_DSS_SLEEP_AFTER_VENC_RESET
>  	bool "Sleep 20ms after VENC reset"
>  	default y
> diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
> index ba82d916719c..09a130c53da2 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dispc.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
> @@ -198,6 +198,9 @@ struct dispc_device {
>  
>  	/* DISPC_CONTROL & DISPC_CONFIG lock*/
>  	spinlock_t control_lock;
> +
> +	/* Optional min-fck-pck-ratio */
> +	u32 min_fck_per_pck;
>  };
>  
>  enum omap_color_component {
> @@ -3683,15 +3686,8 @@ bool dispc_div_calc(struct dispc_device *dispc, unsigned long dispc_freq,
>  	unsigned long pck, lck;
>  	unsigned long lck_max;
>  	unsigned long pckd_hw_min, pckd_hw_max;
> -	unsigned int min_fck_per_pck;
>  	unsigned long fck;
>  
> -#ifdef CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK
> -	min_fck_per_pck = CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK;
> -#else
> -	min_fck_per_pck = 0;
> -#endif
> -
>  	pckd_hw_min = dispc->feat->min_pcd;
>  	pckd_hw_max = 255;
>  
> @@ -3723,7 +3719,7 @@ bool dispc_div_calc(struct dispc_device *dispc, unsigned long dispc_freq,
>  			else
>  				fck = lck;
>  
> -			if (fck < pck * min_fck_per_pck)
> +			if (fck < pck * dispc->min_fck_per_pck)
>  				continue;
>  
>  			if (func(lckd, pckd, lck, pck, data))
> @@ -4826,6 +4822,8 @@ static int dispc_bind(struct device *dev, struct device *master, void *data)
>  		}
>  	}
>  
> +	of_property_read_u32(np, "min-fck-pck-ratio", &dispc->min_fck_per_pck);
> +
>  	r = dispc_init_gamma_tables(dispc);
>  	if (r)
>  		goto err_free;
> -- 
> 2.17.1
> 
