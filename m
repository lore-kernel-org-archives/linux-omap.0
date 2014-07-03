From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] arm: dts: dra7xx-clocks: Fix the l3 and l4 clock rates
Date: Thu, 3 Jul 2014 11:59:11 +0300
Message-ID: <53B51B5F.5040105@ti.com>
References: <1401180943-14296-1-git-send-email-rnayak@ti.com> <53B5157A.3020108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46105 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbaGCI6s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jul 2014 04:58:48 -0400
In-Reply-To: <53B5157A.3020108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 07/03/2014 11:34 AM, Rajendra Nayak wrote:
> On Tuesday 27 May 2014 02:25 PM, Rajendra Nayak wrote:
>> Without the patch:
>> /debug/.../dpll_core_x2_ck/dpll_core_h12x2_ck # cat clk_rate
>> 532000000
>> /debug/.../dpll_core_x2_ck/dpll_core_h12x2_ck/l3_iclk_div # cat clk_rate
>> 532000000
>> /debug/.../dpll_core_x2_ck/dpll_core_h12x2_ck/l3_iclk_div/l4_root_clk_div # cat clk_rate
>> 532000000
>>
>> With the patch:
>> /debug/.../dpll_core_x2_ck/dpll_core_h12x2_ck # cat clk_rate
>> 532000000
>> /debug/.../dpll_core_x2_ck/dpll_core_h12x2_ck/l3_iclk_div # cat clk_rate
>> 266000000
>> /debug/.../dpll_core_x2_ck/dpll_core_h12x2_ck/l3_iclk_div/l4_root_clk_div # cat clk_rate
>> 133000000
>>
>> The l3 clock derived from core DPLL is actually a divider clock,
>> with the default divider set to 2. l4 then derived from l3 is a fixed factor
>> clock, but the fixed divider is 2 and not 1. Which means the l3 clock is
>> half of core DPLLs h12x2 and l4 is half of l3 (as seen with this patch)
>
> Tero, this seems like is yet to be picked up. You see any issues with this that needs to be
> addressed?

Yea this actually looks good to me. Queued for 3.16-rc dt-clk fixes.

-Tero

>
> regards,
> Rajendra
>
>>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> ---
>>   arch/arm/boot/dts/dra7xx-clocks.dtsi |   10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> index cfb8fc7..a14c99b 100644
>> --- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> +++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
>> @@ -673,10 +673,12 @@
>>
>>   	l3_iclk_div: l3_iclk_div {
>>   		#clock-cells = <0>;
>> -		compatible = "fixed-factor-clock";
>> +		compatible = "ti,divider-clock";
>> +		ti,max-div = <2>;
>> +		ti,bit-shift = <4>;
>> +		reg = <0x0100>;
>>   		clocks = <&dpll_core_h12x2_ck>;
>> -		clock-mult = <1>;
>> -		clock-div = <1>;
>> +		ti,index-power-of-two;
>>   	};
>>
>>   	l4_root_clk_div: l4_root_clk_div {
>> @@ -684,7 +686,7 @@
>>   		compatible = "fixed-factor-clock";
>>   		clocks = <&l3_iclk_div>;
>>   		clock-mult = <1>;
>> -		clock-div = <1>;
>> +		clock-div = <2>;
>>   	};
>>
>>   	video1_clk2_div: video1_clk2_div {
>>
>

