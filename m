From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH] ARM: dts: omap3-n900: Specify peripherals LDO regulators
 initial mode
Date: Sun, 17 Apr 2016 09:14:08 +0300
Message-ID: <571329B0.9060503@gmail.com>
References: <1460788643-18590-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160417000536.GA1124@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160417000536.GA1124@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: tony@atomide.com, bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 17.04.2016 03:05, Sebastian Reichel wrote:
> Hi Ivo,
>
> On Sat, Apr 16, 2016 at 09:37:23AM +0300, Ivaylo Dimitrov wrote:
>> Without that, regulators are left in the mode last set by the bootloader or
>> by the kernel the device was rebooted from. This leads to various problems
>> like non-working peripherals.
>>
>> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>> ---
>>   arch/arm/boot/dts/omap3-n900.dts | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
>> index b3c26a9..1bb36e2 100644
>> --- a/arch/arm/boot/dts/omap3-n900.dts
>> +++ b/arch/arm/boot/dts/omap3-n900.dts
>> @@ -329,6 +329,7 @@
>>   	regulator-name = "V28";
>>   	regulator-min-microvolt = <2800000>;
>>   	regulator-max-microvolt = <2800000>;
>> +	regulator-initial-mode = <0x0e>;
>>   	regulator-always-on; /* due to battery cover sensor */
>>   };
>
> I think this should either get an additional
> comment like /* MODE_NORMAL */ or implemented

According to the TRM, this is 'ACTIVE state', but that does not fit in 
the regulator framework terminology.

> using a define and a TWL4030_REGULATOR_MODE_NORMAL
> constant to keep the *.dts easily readable.

We already have RES_STATE_ACTIVE defined in linux/i2c/twl.h, is there a 
way to include that in a dts?

Ivo
