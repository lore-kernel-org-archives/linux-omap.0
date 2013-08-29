From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v3 3/3] ARM: dts: dra7-evm: Add extcon nodes for USB ID
 pin detection
Date: Thu, 29 Aug 2013 13:21:19 -0600
Message-ID: <521F9F2F.1060307@wwwdotorg.org>
References: <1377711185-31238-1-git-send-email-george.cherian@ti.com> <1377711185-31238-4-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1377711185-31238-4-git-send-email-george.cherian@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: George Cherian <george.cherian@ti.com>
Cc: balbi@ti.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, grant.likely@linaro.org, rob@landley.net, ian.campbell@citrix.com, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, bcousson@baylibre.com, davidb@codeaurora.org, arnd@arndb.de, swarren@nvidia.com, popcornmix@gmail.com
List-Id: linux-omap@vger.kernel.org

On 08/28/2013 11:33 AM, George Cherian wrote:
> Add
> 	-extcon nodes for USB ID pin detection.
> 	-i2c nodes.
> 	-pcf nodes to which USB ID pin is connected.

> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts

>  &dwc3_1 {
> -	dr_mode = "otg";
> +	dr_mode = "host";
>  };

I wonder why one cares about ID/VBUS detection if the port doesn't
operate in OTG mode?

>  &dwc3_2 {
>  	dr_mode = "host";
>  };
> +
> +&usb1 {
> +	extcon = <&extcon1>;
> +};
> +
> +&usb2 {
> +	extcon = <&extcon2>;
> +};

I assume the "extcon" property is already fully documented in the
binding for the USB controller? For some reason, "extcon" looks like an
odd property name; I would have expected something more HW-oriented that
Linux-subsystem-oriented, such as "connector", or "usb-connector".

