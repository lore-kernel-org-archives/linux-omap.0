From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH] ARM: dts: am437x-gp-evm: Add vtt_fixed regulator
Date: Tue, 22 Apr 2014 14:53:14 -0500
Message-ID: <5356C8AA.1010608@ti.com>
References: <1398192739-8901-1-git-send-email-d-gerlach@ti.com> <1398192739-8901-2-git-send-email-d-gerlach@ti.com> <5356BBCD.7000103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60717 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752280AbaDVTxj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2014 15:53:39 -0400
In-Reply-To: <5356BBCD.7000103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, Sekhar Nori <nsekhar@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>

On 04/22/2014 01:58 PM, Nishanth Menon wrote:
> On 04/22/2014 01:52 PM, Dave Gerlach wrote:
>> The VTT regulator for DDR3 termination on the am437x-gp-evm is
>> controlled by a gpio. It is configured by the bootloader so here we
>> define an always-on, fixed voltage regulator to hold the gpio.
>>
>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>> ---
>>   arch/arm/boot/dts/am437x-gp-evm.dts | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
>> index a055f7f..e68d12c 100644
>> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
>> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
>> @@ -27,6 +27,17 @@
>>   		enable-active-high;
>>   	};
>>
>> +	vtt_fixed: fixedregulator-vtt {
>
> Would you like to consider any explicit pinctrl here?

Yes, it's a good idea for me to add that in for next version.

>
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vtt_fixed";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		enable-active-high;
>> +		gpio = <&gpio5 7 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>>   	backlight {
>>   		compatible = "pwm-backlight";
>>   		pwms = <&ecap0 0 50000 PWM_POLARITY_INVERTED>;
>>
>
> Do we still need https://patchwork.kernel.org/patch/3871201/ (prevent
> hwmod from resetting GPIO5) ?
>

Yes, without preventing the reset boot still hangs.


