From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 10/11] ARM: dts: omap4 clock data
Date: Mon, 24 Jun 2013 10:39:49 +0300
Message-ID: <51C7F7C5.70201@ti.com>
References: <1371647942-4811-1-git-send-email-t-kristo@ti.com> <1371647942-4811-11-git-send-email-t-kristo@ti.com> <51C3AB46.4040609@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58016 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752585Ab3FXHkW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jun 2013 03:40:22 -0400
In-Reply-To: <51C3AB46.4040609@codeaurora.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-omap@vger.kernel.org, mturquette@linaro.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

On 06/21/2013 04:24 AM, Stephen Boyd wrote:
> On 06/19/13 06:19, Tero Kristo wrote:
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 2a56428..70608db 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -106,6 +106,8 @@
>>   			ti,hwmods = "counter_32k";
>>   		};
>>
>> +		/include/ "omap4-clocks.dtsi"
>> +
>
> Doesn't this cause one platform device to be allocated for each clock
> node defined in omap4-clocks.dtsi? Are you concerned about wasting
> memory on things that aren't really devices and that will never be probed?

Hi Stephen,

Sounds like a valid point to me, so should this include just go under 
the root in omap4.dtsi? I am not quite familiar with DT specifics myself 
as of yet.

-Tero

>
>>   		omap4_pmx_core: pinmux@4a100040 {
>>   			compatible = "ti,omap4-padconf", "pinctrl-single";
>>   			reg = <0x4a100040 0x0196>;
>

