From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/8] ARM/dts: OMAP2: Add McBSP entries for OMAP2420
 and OMAP2430 SoC
Date: Mon, 3 Sep 2012 16:46:53 +0200
Message-ID: <5044C2DD.5000705@ti.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
 <1346247067-9632-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1346247067-9632-2-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Peter,

The overall series looks good to me, but I do have a couple of comments.

On 08/29/2012 03:31 PM, Peter Ujfalusi wrote:
> The McBSP IP within OMAP2420 and 2430 is different we need to create separate
> dtsi files for them.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/omap2420.dtsi |   39 ++++++++++++++++++
>  arch/arm/boot/dts/omap2430.dtsi |   83 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 122 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/omap2420.dtsi
>  create mode 100644 arch/arm/boot/dts/omap2430.dtsi
> 
> diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
> new file mode 100644
> index 0000000..f375c68
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap2420.dtsi
> @@ -0,0 +1,39 @@
> +/*
> + * Device Tree Source for OMAP2420 SoC
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/

Nit: 2012

> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/include/ "omap2.dtsi"
> +
> +/ {
> +	compatible = "ti,omap2420", "ti,omap2";
> +
> +	ocp {
> +		mcbsp1: mcbsp@48074000 {
> +			compatible = "ti,omap2420-mcbsp";
> +			reg = <0x48074000 0xff>;
> +			reg-names = "mpu";
> +			interrupts = <0 59 0x4>, /* TX interrupt */
> +				     <0 60 0x4>; /* RX interrupt */

That one is not correct because it does comply with the interrupt
controller specifier that require only one cell:

		intc: interrupt-controller@48200000 {
			compatible = "ti,omap2-intc";
			interrupt-controller;
			#interrupt-cells = <1>;
...

The one you are using is for GIC IRQ controller.
It works probably because we are using hwmod so far :-)

Didn't you get some warning?

In the case of OMAP2 & 3, it is much simpler:

> +			interrupts = <59>, /* TX interrupt */
> +				     <60>; /* RX interrupt */

That comment is applicable for OMAP2420, OMAP2430, and OMAP3 in general.

> +			interrupt-names = "tx", "rx";
> +			interrupt-parent = <&intc>;
> +			ti,hwmods = "mcbsp1";
> +		};
> +
> +		mcbsp2: mcbsp@48076000 {
> +			compatible = "ti,omap2420-mcbsp";
> +			reg = <0x48076000 0xff>;
> +			reg-names = "mpu";
> +			interrupts = <0 62 0x4>, /* TX interrupt */
> +				     <0 63 0x4>; /* RX interrupt */
> +			interrupt-names = "tx", "rx";
> +			interrupt-parent = <&intc>;
> +			ti,hwmods = "mcbsp2";
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
> new file mode 100644
> index 0000000..531e346
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap2430.dtsi
> @@ -0,0 +1,83 @@
> +/*
> + * Device Tree Source for OMAP243x SoC
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/

2012.

Regards,
Benoit
