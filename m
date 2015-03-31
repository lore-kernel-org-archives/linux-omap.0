From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 26/35] ARM: dts: omap3: add minimal l4 bus layout with
 control module support
Date: Tue, 31 Mar 2015 17:57:56 +0300
Message-ID: <551AB5F4.1040200@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com> <1426877086-17131-27-git-send-email-t-kristo@ti.com> <20150330225634.GL10805@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42306 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752745AbbCaO6K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Mar 2015 10:58:10 -0400
In-Reply-To: <20150330225634.GL10805@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, sakari.ailus@iki.fi, linux-arm-kernel@lists.infradead.org

On 03/31/2015 01:56 AM, Tony Lindgren wrote:
> Hi,
>
> * Tero Kristo <t-kristo@ti.com> [150320 11:46]:
>> --- a/arch/arm/boot/dts/omap3.dtsi
>> +++ b/arch/arm/boot/dts/omap3.dtsi
>> @@ -87,6 +87,60 @@
>>   		ranges;
>>   		ti,hwmods = "l3_main";
>>
>> +		l4_core: l4@48000000 {
>> +			compatible = "ti,omap3-l4-core", "simple-bus";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges = <0 0x48000000 0x1000000>;
>> +
>> +			scm: scm@2000 {
>> +				compatible = "ti,omap3-scm", "simple-bus";
>> +				reg = <0x2000 0x2000>;
>> +				#address-cells = <1>;
>> +				#size-cells = <1>;
>> +				ranges = <0 0x2000 0x2000>;
>> +
>> +				omap3_pmx_core: pinmux@30 {
>> +					compatible = "ti,omap3-padconf",
>> +						     "pinctrl-single";
>> +					reg = <0x30 0x230>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +					#interrupt-cells = <1>;
>> +					interrupt-controller;
>> +					pinctrl-single,register-width = <16>;
>> +					pinctrl-single,function-mask = <0xff1f>;
>> +				};
>
> Just noticed we may be now missing few pins as diffing the dmesg before
> and after this series produces this on omap3:
>
> -pinctrl-single 48002030.pinmux: 284 pins at pa fa002030 size 568
> +pinctrl-single 48002030.pinmux: 280 pins at pa fa002030 size 560
>
> Care to check that?

True, there is a typo in the omap3.dtsi file. Will fix this and repost.

-Tero
