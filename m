From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 3/3] ARM: dts: dra7-evm: Add extcon nodes for USB ID
 pin detection
Date: Wed, 28 Aug 2013 18:40:38 +0400
Message-ID: <521E0BE6.3080607@cogentembedded.com>
References: <1377698352-27689-1-git-send-email-george.cherian@ti.com> <1377698352-27689-4-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1377698352-27689-4-git-send-email-george.cherian-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, popcornmix-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 08/28/2013 05:59 PM, George Cherian wrote:

> Add
> 	-extcon nodes for USB ID pin detection.
> 	-i2c nodes.
> 	-pcf nodes to which USB ID pin is connected.

> Signed-off-by: George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>
> ---
>   arch/arm/boot/dts/dra7-evm.dts | 52 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 51 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index acd3c09..9ee97c0 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -17,6 +17,17 @@
>   		device_type = "memory";
>   		reg = <0x80000000 0x60000000>; /* 1536 MB */
>   	};
> +
> +	extcon1: gpio_usbvid_extcon1 {
> +		compatible = "ti,gpio-usb-id";
> +		gpios = <&pcf_21 1 0>;
> +	};
> +
> +	extcon2: gpio_usbvid_extcon2 {
> +		compatible = "ti,gpio-usb-id";
> +		gpios = <&pcf_21 2 0>;
> +	};
> +
>   };
>
>   &dra7_pmx_core {
> @@ -33,10 +44,49 @@
>           };
>   };
>
> +&i2c1 {
> +	clock-frequency = <400000>;
> +
> +	pcf_20: pcf8575@20 {

    Acorrding to the ePAPR spec [1], "the name of a node should be somewhat 
generic, reflecting the function of the device and not its precise 
programming model. If appropriate, the name should be one of the following 
choices:

[...]
- gpio
[...]"

> +		compatible = "ti,pcf8575";
> +		reg = <0x20>;
> +		n_latch = <0x4000>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <11 2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	pcf_21: pcf8575@21 {

    Same comment here.

> +		compatible = "ti,pcf8575";
> +		reg = <0x21>;
> +		n_latch = <0x1408>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-parent = <&pcf_20>;
> +		interrupts = <14 2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +};
> +

[1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
