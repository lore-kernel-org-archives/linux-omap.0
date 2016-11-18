From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC 4/6] ARM: dts: dra7: add entry for bb2d module
Date: Fri, 18 Nov 2016 07:56:35 -0600
Message-ID: <15bbd8af-c321-689b-ca85-acce581bd8a7@ti.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
 <20161118024436.13447-4-robertcnelson@gmail.com>
 <1479466741.20533.5.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1479466741.20533.5.camel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Gowtham Tammana <g-tammana-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 11/18/2016 04:59 AM, Lucas Stach wrote:
> Am Donnerstag, den 17.11.2016, 20:44 -0600 schrieb Robert Nelson:
>> From: Gowtham Tammana <g-tammana-l0cyMroinI0@public.gmane.org>
>>
>> BB2D entry is added to the dts file. Crossbar index number is used
>> for interrupt mapping.
>>
>> Signed-off-by: Gowtham Tammana <g-tammana-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
>> ---
>>  arch/arm/boot/dts/dra7.dtsi | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index addb753..43488b6 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -959,6 +959,16 @@
>>  			ti,hwmods = "dmm";
>>  		};
>>
>> +		bb2d: bb2d@59000000 {
>> +			compatible = "ti,dra7-bb2d";
>> +			reg = <0x59000000 0x0700>;
>> +			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
>> +			ti,hwmods = "bb2d";
>> +			clocks = <&dpll_core_h24x2_ck>;
>> +			clock-names = "fclk";
>
> "fclk" is not an accepted clock name for the etnaviv driver. It supports
> up to 3 clocks: "bus", "core" and "shader". If there is only one clock
> required in your design it would probably be the "core" clock.

fclk is used as a standard for all hwmod (SoC level control library 
that existed prior to ARM DT-fication, and now slowly being converted 
to DT). I think the core and bus clock is the same here.. I wonder if 
something duplicated like the following will fly?

clocks = <&dpll_core_h24x2_ck>, <&dpll_core_h24x2_ck> ;
clock-names = "fclk", "core";

It might have been better if hwmod clocks were'nt assumed from 
clock-names.. instead it could have been something like:
ti,hwmod-fck-clk-names = "core";
ti,hwmod-ick-clk-names = "bus";
ti,hwmod-ock-clk-names = "shader";
clocks = <&dpll_core_h24x2_ck>, <&clk2>, <&clk3>;
clock-names = "core", "bus", "shader";

Tero: ?

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
