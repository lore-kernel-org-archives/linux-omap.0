From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 3/3] ARM: DTS: TWL4030: fix mux and wakeup for SYS_NIRQ line
Date: Fri, 07 Jun 2013 09:59:14 -0700
Message-ID: <87fvwtn9gd.fsf@linaro.org>
References: <1370040357-25794-1-git-send-email-khilman@linaro.org>
	<1370561253-15523-1-git-send-email-khilman@linaro.org>
	<20130606234201.GA26919@kahuna>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:56561 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981Ab3FGQ7S (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 12:59:18 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so1475682pdj.17
        for <linux-omap@vger.kernel.org>; Fri, 07 Jun 2013 09:59:18 -0700 (PDT)
In-Reply-To: <20130606234201.GA26919@kahuna> (Nishanth Menon's message of
	"Thu, 6 Jun 2013 18:42:01 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

Nishanth Menon <nm@ti.com> writes:

> On 16:27-20130606, Kevin Hilman wrote:
>> On most OMAP3 platforms, the twl4030 IRQ line is connected to the
>> SYS_NIRQ line on OMAP.  Add another DTS include file
>> (twl4030_omap3_mux.dtsi) for boards that hook up the twl4030 this way
>> to include.
>> 
>> This allows RTC wake from off-mode to work again on OMAP3-based
>> platforms with twl4030.  Tested on 3530/Beagle, 3730/Beagle-xM,
>> 3530/Overo, 3730/Overo-STORM.
>> 
>> Special thanks to Florian Vaussard for suggesting use of preprocessor
>> feature.
>> 
>> Cc: Florian Vaussard <florian.vaussard@epfl.ch>
>> Cc: Benoit Cousson <b-cousson@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>> ---
>> v2: Updated to change board files instead of twl4030 file.
>> 
>>  arch/arm/boot/dts/omap3-beagle-xm.dts    |  1 +
>>  arch/arm/boot/dts/omap3-beagle.dts       |  1 +
>>  arch/arm/boot/dts/omap3-devkit8000.dts   |  1 +
>>  arch/arm/boot/dts/omap3-evm.dts          |  1 +
>>  arch/arm/boot/dts/omap3-igep.dtsi        |  1 +
>>  arch/arm/boot/dts/omap3-overo.dtsi       |  1 +
>>  arch/arm/boot/dts/omap3430-sdp.dts       |  1 +
>>  arch/arm/boot/dts/twl4030_omap3_mux.dtsi | 17 +++++++++++++++++
> minor comment:
> can we do twl4030_omap3 instead? That way, I can add in twl4030 VP
> specific parameters which are OMAP3 specific?

Good idea, I'll rename it to twl4030_omap3.dtsi

[...]

>> diff --git a/arch/arm/boot/dts/twl4030_omap3_mux.dtsi b/arch/arm/boot/dts/twl4030_omap3_mux.dtsi
>> new file mode 100644
>> index 0000000..1bd0f9f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/twl4030_omap3_mux.dtsi
>> @@ -0,0 +1,17 @@
> some license text?

oops

>> +&twl {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&twl4030_pins>;
>> +};
>> +
>> +&omap3_pmx_core {
>> +	/*
>> +	 * On most OMAP3 platforms, the twl4030 IRQ line is connected
>> +         * to the SYS_NIRQ line on OMAP.  Therefore, configure the
>> +         * defaults for the SYS_NIRQ pin here.
> ^^^ tab?

good catch.

Thanks for the review, will make the changes and resubmit.

Kevin
