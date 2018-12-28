From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: extend tps65218 bindings
Date: Fri, 28 Dec 2018 16:51:23 -0600
Message-ID: <20181228225123.GA10598@bogus>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1545120356-7749-2-git-send-email-Christian.Hohnstaedt@wago.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545120356-7749-2-git-send-email-Christian.Hohnstaedt@wago.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc: Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 18, 2018 at 09:05:55AM +0100, Christian Hohnstaedt wrote:
> Add input voltage configuration options
> 
> Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> ---
>  Documentation/devicetree/bindings/regulator/tps65218.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/Documentation/devicetree/bindings/regulator/tps65218.txt
> index 02f0e9b..a9ee377 100644
> --- a/Documentation/devicetree/bindings/regulator/tps65218.txt
> +++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
> @@ -16,12 +16,22 @@ Required properties:
>    regulator-dcdc5, regulator-dcdc6, regulator-ldo1, regulator-ls3.
>    Each regulator is defined using the standard binding for regulators.
>  
> +Optional properties:
> +  If any of these properties is absent, the setting will not be touched.
> +- strict-supply-voltage: <1|0> Set/Reset STRICT flag in CONFIG1
> +- under-voltage-limit: Select 2.75, 2.95, 3.25 or 3.35V as UVLO in CONFIG1
> +- under-voltage-hysteresis: Select 200mV or 400mV UVLOHYS in CONFIG2

These need vendor prefixes and unit suffixes (as defined in 
property-units.txt).

> +
>  Example:
>  tps65218: tps65218@24 {
>  	reg = <0x24>;
>  	compatible = "ti,tps65218";
>  	interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* NMIn */
>  	interrupt-controller;
> +	strict-supply-voltage = <1>;
> +	under-voltage-hysteresis = <400000>;
> +	under-voltage-limit = <3350000>;
> +
>  	#interrupt-cells = <2>;
>  
>  	dcdc1: regulator-dcdc1 {
> -- 
> 2.7.4
> 
