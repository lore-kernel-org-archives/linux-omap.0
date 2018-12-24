From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: regulator: extend tps65218 bindings
Date: Mon, 24 Dec 2018 14:45:31 +0530
Message-ID: <85cd3c92-8b13-495f-7ef5-dd1bebd46b64@ti.com>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1545120356-7749-2-git-send-email-Christian.Hohnstaedt@wago.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545120356-7749-2-git-send-email-Christian.Hohnstaedt@wago.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>, Lee Jones <lee.jones@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 12/18/2018 1:35 PM, Christian Hohnstaedt wrote:
> Add input voltage configuration options
> 
> Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> ---
>   Documentation/devicetree/bindings/regulator/tps65218.txt | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/Documentation/devicetree/bindings/regulator/tps65218.txt
> index 02f0e9b..a9ee377 100644
> --- a/Documentation/devicetree/bindings/regulator/tps65218.txt
> +++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
> @@ -16,12 +16,22 @@ Required properties:
>     regulator-dcdc5, regulator-dcdc6, regulator-ldo1, regulator-ls3.
>     Each regulator is defined using the standard binding for regulators.
>   
> +Optional properties:
> +  If any of these properties is absent, the setting will not be touched.

I would reword this to:

"If any of these properties is absent then the corresponding setting 
will be untouched"

> +- strict-supply-voltage: <1|0> Set/Reset STRICT flag in CONFIG1

This is too less info on the strict bit:

You can perhaps add some more description from data sheet.

The Supply Voltage supervisor has two modes of operation, controlled by 
the STRICT bit. With the STRICT bit set to 0, all
enabled rails of the five regulators are monitored for undervoltage only 
with relaxed thresholds and
deglitch times. With the STRCT bit set to 1, all enabled rails of the 
five regulators are monitored for
undervoltage and overvoltage with tight limits and short deglitch times.

> +- under-voltage-limit: Select 2.75, 2.95, 3.25 or 3.35V as UVLO in CONFIG1

Again some more description on uvlo please.

> +- under-voltage-hysteresis: Select 200mV or 400mV UVLOHYS in CONFIG2

Even here for hysteresis.

> +
>   Example:
>   tps65218: tps65218@24 {
>   	reg = <0x24>;
>   	compatible = "ti,tps65218";
>   	interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* NMIn */
>   	interrupt-controller;
> +	strict-supply-voltage = <1>;
> +	under-voltage-hysteresis = <400000>;
> +	under-voltage-limit = <3350000>;
> +
>   	#interrupt-cells = <2>;
>   
>   	dcdc1: regulator-dcdc1 {
> 
