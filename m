From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 3/3] ARM: logicpd-torpedo-37xx-devkit-28: Reference new
 DRM panel
Date: Sat, 21 Sep 2019 21:09:41 +0200
Message-ID: <20190921190941.GD32133@ravnborg.org>
References: <20190917161214.2913-1-aford173@gmail.com>
 <20190917161214.2913-3-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190917161214.2913-3-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, adam.ford@logicpd.com, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Adam.

On Tue, Sep 17, 2019 at 11:12:13AM -0500, Adam Ford wrote:
> With the removal of the panel-dpi from the omap drivers, the
> LCD no longer works.  This patch points the device tree to
> a newly created panel named "logicpd,type28"
> 
> Fixes: 8bf4b1621178 ("drm/omap: Remove panel-dpi driver")
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
Looks good.
One nit below.

With this addressed:

Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam
> 
> diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit-28.dts b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit-28.dts
> index 07ac99b9cda6..00c426bd51a0 100644
> --- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit-28.dts
> +++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit-28.dts
> @@ -11,22 +11,8 @@
>  #include "logicpd-torpedo-37xx-devkit.dts"
>  
>  &lcd0 {
> -
> +	/* This isn't the exact LCD, but the timings meet spec */
> +	/* To make it work, set CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=4 */
> +	compatible = "logicpd,type28";
>  	label = "28";
You left this property - but us it documented and what use has it?

> -
> -	panel-timing {
> -		clock-frequency = <9000000>;
> -		hactive = <480>;
> -		vactive = <272>;
> -		hfront-porch = <3>;
> -		hback-porch = <2>;
> -		hsync-len = <42>;
> -		vback-porch = <3>;
> -		vfront-porch = <2>;
> -		vsync-len = <11>;
> -		hsync-active = <1>;
> -		vsync-active = <1>;
> -		de-active = <1>;
> -		pixelclk-active = <0>;
> -	};
>  };
> -- 
> 2.17.1
