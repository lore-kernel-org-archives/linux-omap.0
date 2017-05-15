From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: Re: [PATCH v3 03/21] ARM: dts: omap: Add generic compatible string
 for I2C EEPROM
Date: Mon, 15 May 2017 12:55:22 +0200
Message-ID: <CABxcv=k7LbcQCiVYCPTTsG_-hxBseHzPy-55zDNJ+yW0BL0=3g@mail.gmail.com>
References: <20170414010445.21727-1-javier@osg.samsung.com>
 <20170414010445.21727-4-javier@osg.samsung.com> <20170419235646.j6cc3vm7eru6buv6@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170419235646.j6cc3vm7eru6buv6@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Mark Jackson <mpfj@newflow.co.uk>
List-Id: linux-omap@vger.kernel.org

Hello Rob,

On Thu, Apr 20, 2017 at 1:56 AM, Rob Herring <robh@kernel.org> wrote:
> On Thu, Apr 13, 2017 at 10:04:27PM -0300, Javier Martinez Canillas wrote:
>> The at24 driver allows to register I2C EEPROM chips using different vendor
>> and devices, but the I2C subsystem does not take the vendor into account
>> when matching using the I2C table since it only has device entries.
>>
>> But when matching using an OF table, both the vendor and device has to be
>> taken into account so the driver defines only a set of compatible strings
>> using the "atmel" vendor as a generic fallback for compatible I2C devices.
>>
>> So add this generic fallback to the device node compatible string to make
>> the device to match the driver using the OF device ID table.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>> ---
>>
>> Changes in v3: None
>> Changes in v2: None
>>
>>  arch/arm/boot/dts/am335x-baltos.dtsi            |  2 +-
>>  arch/arm/boot/dts/am335x-base0033.dts           |  2 +-
>>  arch/arm/boot/dts/am335x-bone-common.dtsi       | 10 +++++-----
>>  arch/arm/boot/dts/am335x-nano.dts               |  2 +-
>>  arch/arm/boot/dts/am335x-pepper.dts             |  2 +-
>>  arch/arm/boot/dts/am335x-shc.dts                |  2 +-
>>  arch/arm/boot/dts/am335x-sl50.dts               |  2 +-
>>  arch/arm/boot/dts/am437x-idk-evm.dts            |  2 +-
>>  arch/arm/boot/dts/am437x-sk-evm.dts             |  2 +-
>>  arch/arm/boot/dts/am43x-epos-evm.dts            |  2 +-
>>  arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |  2 +-
>>  arch/arm/boot/dts/omap3-cm-t3x.dtsi             |  2 +-
>>  arch/arm/boot/dts/omap3-gta04.dtsi              |  2 +-
>>  arch/arm/boot/dts/omap3-sb-t35.dtsi             |  2 +-
>>  arch/arm/boot/dts/omap4-var-som-om44.dtsi       |  2 +-
>>  arch/arm/boot/dts/omap5-cm-t54.dts              |  2 +-
>>  arch/arm/boot/dts/omap5-sbc-t54.dts             |  2 +-
>>  17 files changed, 21 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/am335x-baltos.dtsi b/arch/arm/boot/dts/am335x-baltos.dtsi
>> index d42b98f15e8b..6ca780d0623f 100644
>> --- a/arch/arm/boot/dts/am335x-baltos.dtsi
>> +++ b/arch/arm/boot/dts/am335x-baltos.dtsi
>> @@ -255,7 +255,7 @@
>>       };
>>
>>       at24@50 {
>> -             compatible = "at24,24c02";
>> +             compatible = "at24,24c02", "atmel,24c02";
>
> I think you can just drop the at24 compatibles. A new kernel doesn't
> need it. An old kernel ignores the manufacturer. I checked that u-boot
> only matches on "atmel,*", so okay there. Don't know about the *BSDs. I
> couldn't find anything.
>

That's a very good point, it doesn't make sense indeed to keep them,
since the vendor prefix can as you said be ignored (until the OF
modalias report is fixed).

I'll re-spin the series dropping them. Thanks a lot.

Best regards,
Javier
