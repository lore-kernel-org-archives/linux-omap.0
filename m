From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: TWL6040 fails to initialize
Date: Tue, 25 Feb 2014 16:41:58 +0100
Message-ID: <530CB9C6.60806@epfl.ch>
References: <530C70B3.4010103@epfl.ch> <530CA8DA.8050806@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:48979 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753125AbaBYPmD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Feb 2014 10:42:03 -0500
In-Reply-To: <530CA8DA.8050806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, =?ISO-8859-1?Q?Philippe_R=E9tornaz?= <philippe.retornaz@epfl.ch>

Hi Peter,

On 02/25/2014 03:29 PM, Peter Ujfalusi wrote:
> Hi Florian,
> 
> On 02/25/2014 12:30 PM, Florian Vaussard wrote:
>> Hi Peter,
>>
>> I got recently to work on the DT support for an OMAP4 board [1], and I
>> encountered some troubles with the probe of the twl6040 audio codec on
>> 3.14-rc kernels. On 3.13, things were working correctly. So I somewhat
>> managed to bisect this down to [c7f9129 mfd: twl6040: reg_defaults
>> support for regmap]. But looking more into it, things are less obvious.
> 
> Interesting. I just booted 3.14.0-rc4 with HEAD:
> 7472e009a3f1 Merge branch 'for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
> 
> on my PandaBoard-ES and audio comes up just fine (twl6040).
> 

I know, it is weird. It appeared with 3.14-rc1, 3.13 was working just fine.

>>
>> When the init fails, here is what happens:
>>
>> [    2.455749] twl6040 0-004b: Looking up vio-supply from device tree
>> [    2.456359] twl6040 0-004b: Looking up v2v1-supply from device tree
>> [    2.457061] twl6040 0-004b: Failed to set masks in 0x4: -121
>> [    2.463043] twl6040: probe of 0-004b failed with error -121
>>
>> logically resulting in
> 
> Do you have the regulators in your dts file? vio and v2v1 is needed by the
> twl6040.
> 

Yes, I have both regulators. Here is the relevant part of the DTS:

        twl6040: twl@4b {
                compatible = "ti,twl6040";
                reg = <0x4b>;
                interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
                interrupt-parent = <&gic>;
                ti,audpwron-gpio = <&gpio6 0 GPIO_ACTIVE_HIGH>;

                vio-supply = <&v1v8>;
                v2v1-supply = <&v2v1>;
                enable-active-high;
        };


>>
>> [    2.770050] omap-abe-twl6040 sound.4: ASoC: CODEC twl6040-codec not
>> registered
>> [    2.777770] omap-abe-twl6040 sound.4: snd_soc_register_card() failed:
>> -517
>> [    2.785095] platform sound.4: Driver omap-abe-twl6040 requests probe
>> deferral
>>
>> We get a EREMOTEIO when calling regmap_add_irq_chip() from
>> twl6040_probe(). regmap_add_irq_chip() will try to perform non-cached
>> i2c writes, where the omap-i2c driver get a NACK from the remote chip.
>> Strange enough, the non-cached read just before (i.e.
>> twl6040_reg_read(twl6040, TWL6040_REG_ASICREV)) succeeds.
> 
> Power is not enabled? There might be missing 32K clock for twl6040, can you
> check your board's schema against PandaBoard-ES?
> 

If the power was not enabled at all, I would be unable to read the
revision register, no? And delaying the probe by one millisecond would
be of no help in this case IMHO.

Unfortunately, I don't have access to the schematics of the processor
board. Only the expansion boards from Gumstix have public schematics.

For the 32K, if it was disabled, I think that I would be unable to play
with the headset output in low-power mode, right? When I put the
msleep(), I can play to HSL/HSR and everything seems to work as expected.

Regards,
Florian
