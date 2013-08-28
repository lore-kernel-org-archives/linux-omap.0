From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: dra7-evm: Add extcon nodes for USB ID
 pin detection
Date: Wed, 28 Aug 2013 21:54:20 +0400
Message-ID: <521E394C.3040402@cogentembedded.com>
References: <1377711185-31238-1-git-send-email-george.cherian@ti.com> <1377711185-31238-4-git-send-email-george.cherian@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1377711185-31238-4-git-send-email-george.cherian@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: George Cherian <george.cherian@ti.com>
Cc: balbi@ti.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, grant.likely@linaro.org, rob@landley.net, ian.campbell@citrix.com, swarren@wwwdotorg.org, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, bcousson@baylibre.com, davidb@codeaurora.org, arnd@arndb.de, swarren@nvidia.com, popcornmix@gmail.com
List-Id: linux-omap@vger.kernel.org

On 08/28/2013 09:33 PM, George Cherian wrote:

> Add
> 	-extcon nodes for USB ID pin detection.
> 	-i2c nodes.
> 	-pcf nodes to which USB ID pin is connected.

> Signed-off-by: George Cherian <george.cherian@ti.com>
> ---
>   arch/arm/boot/dts/dra7-evm.dts | 50 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 49 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index acd3c09..8b0738a 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
[...]
> @@ -33,10 +44,47 @@
>           };
>   };
>
> +&i2c1 {
> +	clock-frequency = <400000>;
> +
> +	gpio20: pcf8575@20 {

     ePAPR was talking about the node naming, not about labelling. Back to the 
drawing board. ;-)

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
> +	gpio21: pcf8575@21 {
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

WBR, Sergei

