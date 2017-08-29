From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 13/17] ARM: dts: Add missing fdif node and binding for omap4
Date: Tue, 29 Aug 2017 15:48:17 +0300
Message-ID: <5996934.WE9heBV2Dy@avalon>
References: <20170828211918.11573-1-tony@atomide.com> <20170828211918.11573-14-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170828211918.11573-14-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Thank you for the patch.

On Tuesday, 29 August 2017 00:19:14 EEST Tony Lindgren wrote:
> On omap4 we're missing the fdif node with it's related "ti,hwmods"
> property that the SoC interconnect code needs.
> 
> Note that this will only show up as a bug with "doesn't have
> mpu register target base" boot errors when the legacy platform
> data is removed.
> 
> Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> Cc: Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  .../devicetree/bindings/media/ti-fdif.txt          | 37 +++++++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi                       |  7 ++++
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/ti-fdif.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/ti-fdif.txt
> b/Documentation/devicetree/bindings/media/ti-fdif.txt new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/ti-fdif.txt
> @@ -0,0 +1,37 @@
> +Texas Instruments Face Detect (FDIF) binding
> +
> +FDD can be used for face detection on Texas Instruments SoCs.

Did you mean s/FDD/FDIF/ ?

> +Note that the fdif binding is currently only used by the SoC interconnect
> +code to idle the module on init and no open source driver is available
> +for fdif. Please update this documentation if that changes.

Device tree bindings should be driver-agnostic. I don't think this paragraph 
is needed.

> +Required properties:
> +
> +compatible: Shall be one of the following:
> +	    "ti,omap4-fdif"
> +
> +reg: Shall contain the device instance IO range
> +
> +interrupts: Shall contain the device instance interrupt
> +
> +
> +Optional properties:
> +
> +reg-names: Shall contain the IO range names if multiple IO
> +	   ranges are used by the SoC

Is this ever the case on OMAP4 ? If not you can drop this property.

> +ti,hwmods: Shall contain the TI interconnect module name if needed
> +	   by the SoC

Are there SoCs that don't need this ?

> +Example:
> +
> +	fdif: fdif@4a10a000 {
> +		compatible = "ti,omap4-fdif";
> +		reg = <0x4a10a000 0x200>;
> +		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +		ti,hwmods = "fdif";
> +	};
> +
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -864,6 +864,13 @@
>  			};
>  		};
> 
> +		fdif: fdif@4a10a000 {
> +			compatible = "ti,omap4-fdif";
> +			reg = <0x4a10a000 0x200>;

According to the OMAP4460 datasheet the register range is 0x390 bytes long.

> +			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
> +			ti,hwmods = "fdif";
> +		};
> +
>  		timer1: timer@4a318000 {
>  			compatible = "ti,omap3430-timer";
>  			reg = <0x4a318000 0x80>;


-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
