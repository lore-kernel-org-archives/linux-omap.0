From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 07/10] arm/dts: omap4-panda: Add twl6030 and i2c EEPROM
Date: Wed, 14 Dec 2011 17:50:33 +0100
Message-ID: <4EE8D3D9.5020403@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com> <1323439361-1647-8-git-send-email-b-cousson@ti.com> <87obvbpws7.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40841 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754486Ab1LNQuq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 11:50:46 -0500
In-Reply-To: <87obvbpws7.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: tony@atomide.com, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Kevin,

On 12/14/2011 6:06 AM, Kevin Hilman wrote:
> Hi Benoit,
>
> Benoit Cousson<b-cousson@ti.com>  writes:
>
>> Update pandaboard dts file with required clock frequencies
>> for the i2c client devices existing on pandaboard.
>>
>> Add the twl6030 node in i2c1 controller.
>>
>> This is the minimal support needed to boot OMAP4 boards
>> without any crash.
>> The support for all the features included in this MFD will be
>> added later.
>>
>> Add a generic i2c EEPROM entry.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> ---
>>   arch/arm/boot/dts/omap4-panda.dts |   45 +++++++++++++++++++++++++++++++++++++
>>   1 files changed, 45 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
>> index 9755ad5..b66bcd6 100644
>> --- a/arch/arm/boot/dts/omap4-panda.dts
>> +++ b/arch/arm/boot/dts/omap4-panda.dts
>> @@ -18,3 +18,48 @@
>>   		reg =<0x80000000 0x40000000>; /* 1 GB */
>>   	};
>>   };
>> +
>> +&i2c1 {
>> +	clock-frequency =<400000>;
>> +
>> +	/*
>> +	 * Integrated Power Management Chip
>> +	 * http://www.ti.com/lit/ds/symlink/twl6030.pdf
>> +	 */
>> +	twl@48 {
>> +		compatible = "ti,twl6030";
>> +		reg =<0x48>;
>> +		/* SPI = 0, IRQ# = 7, 4 = active high level-sensitive */
>> +		interrupts =<0 7 4>; /* IRQ_SYS_1N cascaded to gic */
>> +		interrupt-controller;
>> +		#interrupt-cells =<1>;
>> +		interrupt-parent =<&gic>;
>> +
>> +		/* twl is a MFD, so it will contain a bunch of sub-ips */
>> +		rtc {
>> +			compatible = "ti,twl4030-rtc";
>> +			interrupts =<11>;
>> +		};
>
> After seeing the mostly cut&  paste in Rajendra's regulator series, I'm
> wondering if it wouldn't be better to just have a twl4030.dtsi here
> which has the RTC and all the regulators with the default voltage ranges
> from the TWL data sheet.

Yes, indeed, it is still small here but will become much bigger with the 
regulators.
In fact twl6030 is a SoC like OMAP, so all the TWL specific internal 
details can be located in a single file.
The board will just have to provide the i2c address and the IRQ information.

> Not knowing much about how includes work in DT, would it then be
> possible for board files to override things like default voltage ranges
> for regulators?

To be honest, I was wondering as well how to do that with the /include/ 
functionality :-)
But I've just done a couple of DTC test, and this seems to be pretty 
straightforward.

The boards will contain that:
&i2c1 {
	clock-frequency = <400000>;

	twl: twl@48 {
		reg = <0x48>;
		/* SPI = 0, IRQ# = 7, 4 = active high level-sensitive */
		interrupts = <0 7 4>; /* IRQ_SYS_1N cascaded to gic */
		interrupt-controller;
		interrupt-parent = <&gic>;
	};
};

/include/ "twl6030.dtsi"

...

And the twl6030.dtsi will contain that for the moment:

/*
  * Integrated Power Management Chip
  * http://www.ti.com/lit/ds/symlink/twl6030.pdf
  */
&twl {
	compatible = "ti,twl6030";
	#interrupt-cells = <1>;

	/* twl is a MFD, so it will contain a bunch of sub-ips */
	rtc {
		compatible = "ti,twl4030-rtc";
		interrupts = <11>;
	};
};

And then all the regulators from Rajendra's series will be there as well.

This will avoid the duplication between sdp and panda. Beagle will need 
a twl4030.dtsi which is different than the twl6030.

I'll update and repost the series soon.

Thanks,
Benoit
