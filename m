From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 10/11] ARM: dts: omap4 clock data
Date: Wed, 19 Jun 2013 16:49:59 +0300
Message-ID: <51C1B707.5090603@ti.com>
References: <1371647942-4811-1-git-send-email-t-kristo@ti.com> <1371647942-4811-11-git-send-email-t-kristo@ti.com> <20130619133022.GA30364@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48883 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925Ab3FSNud (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jun 2013 09:50:33 -0400
In-Reply-To: <20130619133022.GA30364@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, mturquette@linaro.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Eduardo Valentin <eduardo.valentin@ti.com>

On 06/19/2013 04:30 PM, Nishanth Menon wrote:
> On 16:19-20130619, Tero Kristo wrote:
> <snip>
>> diff --git a/arch/arm/boot/dts/omap4-clocks.dtsi b/arch/arm/boot/dts/omap4-clocks.dtsi
>> new file mode 100644
>> index 0000000..b420d8a
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/omap4-clocks.dtsi
> [...]
>> +/* XXX Missing round_rate, set_rate in ops */
> could be dropped?
>> +dpll_core_m3x2_div_ck: dpll_core_m3x2_div_ck@4a004134 {
>> +	compatible = "divider-clock";
>> +	clocks = <&dpll_core_x2_ck>;
>> +	#clock-cells = <0>;
>> +	reg = <0x4a004134 0x4>;
>> +	bit-mask = <0x1f>;
>> +	index-starts-at-one;
>> +};
> [..]
>> +
>> +/* XXX Missing round_rate, set_rate in ops */
> could be dropped?

Yeah, I blame my bugged script here. :)

>> +dpll_per_m3x2_div_ck: dpll_per_m3x2_div_ck@4a008154 {
>> +	compatible = "divider-clock";
>> +	clocks = <&dpll_per_x2_ck>;
>> +	#clock-cells = <0>;
>> +	reg = <0x4a008154 0x4>;
>> +	bit-mask = <0x1f>;
>> +	index-starts-at-one;
>> +};
>> +
> [...]
>> +
>> +/*
>> + * clocks specific to omap4460
>> + */
>> +/*
>> + * clocks specific to omap4430
>> + */
>> +/*
>> + * clocks common to omap44xx
>> + */
> could be dropped?

Same.

>
> btw, are we differentiating 4430 and 4460?A
> Example:
> bandgap_fclk in 4430
> Vs
> div_ts_ck, bandgap_ts_fclk in 4460?

Both nodes are available for both SoCs as of now. Driver should 
differentiate which clock node to use though. Added Eduardo for 
commenting this part, maybe we should add a couple of entries to the 
list in cclock44xx_data.c...?

-Tero
