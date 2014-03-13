From: Sathya Prakash <a0393677@ti.com>
Subject: Re: [PATCH v2 4/4] ARM: DTS: AM43x: Add DSS node
Date: Thu, 13 Mar 2014 16:00:52 +0530
Message-ID: <532188DC.2010000@ti.com>
References: <1394701109-6721-1-git-send-email-sathyap@ti.com> <1394701109-6721-5-git-send-email-sathyap@ti.com> <532186B6.3090902@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39146 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbaCMKbN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 06:31:13 -0400
In-Reply-To: <532186B6.3090902@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Sathya Prakash M R <sathyap@ti.com>, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, paul@pwsan.com

On Thursday 13 March 2014 03:51 PM, Tomi Valkeinen wrote:
> On 13/03/14 10:58, Sathya Prakash M R wrote:
>> Add device node for DSS module for AM4372. Both the
>> AM437x-Gp evm and Am43x-Epos evm use the same LCD panel.
>> The lcd timings are added in respective dts files.
>> Adds display pinctrl and enables required gpio.
>> Also set the right parent clock to the DSS clock.
>>
>> Signed-off-by: Sathya Prakash M R <sathyap@ti.com>
>> ---
>>   arch/arm/boot/dts/am4372.dtsi        |   28 +++++++++++++
>>   arch/arm/boot/dts/am437x-gp-evm.dts  |   77 ++++++++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/am43x-epos-evm.dts |   73 ++++++++++++++++++++++++++++++++
>>   arch/arm/boot/dts/am43xx-clocks.dtsi |    2 +
>>   4 files changed, 180 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
>> index ea55a4e..b72a7df 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -684,6 +684,34 @@
>>   			num-cs = <4>;
>>                           status = "disabled";
>>                   };
>> +
>> +		dss: dss@4832A000 {
>> +			compatible = "ti,omap3-dss", "simple-bus";
>> +			reg = <0x4832A000 0x200>;
>> +			ti,hwmods = "dss_core";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +
>> +			dispc@4832A400 {
>> +				compatible = "ti,omap3-dispc";
>> +				reg = <0x4832A400 0x400>;
>> +				interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
>> +				ti,hwmods = "dss_dispc";
>> +			};
>> +
>> +			dpi: encoder@0 {
>> +				compatible = "ti,omap3-dpi";
>> +			};
>> +
>> +			rfbi: rfbi@4832A800 {
>> +				compatible = "ti,omap3-rfbi";
>> +			reg = <0x4832A800 0x100>;
>> +				ti,hwmods = "dss_rfbi";
>> +			};
>> +
>> +		};
>> +
> This seems to be based on old version of the DSS DT. Please rebase this
> on top of the latest one:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git work/dss-dt
Thanks. maybe i missed couple of changes. Will do that.
>
> You also need to split this into smaller pieces: the dts clock fix, the
> am4372.dtsi, and the board changes.
ok sure.
>
>   Tomi
>
>

