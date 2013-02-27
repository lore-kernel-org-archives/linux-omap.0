From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 27 Feb 2013 14:13:10 -0600
Message-ID: <512E68D6.4050906@ti.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <1329321854-24490-4-git-send-email-b-cousson@ti.com> <4F44FA56.7020000@gmail.com> <4F44FC37.2000701@ti.com> <4F452484.5080503@gmail.com> <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com> <4F47AD08.4030504@ti.com> <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com> <512D407C.6090006@ti.com> <CAAwP0s2rMpZXrbTzoU4J=nqdxku7UBrDehAPmtyrns3cn6WHAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50576 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896Ab3B0UNW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Feb 2013 15:13:22 -0500
In-Reply-To: <CAAwP0s2rMpZXrbTzoU4J=nqdxku7UBrDehAPmtyrns3cn6WHAA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Rob Herring <robherring2@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>


On 02/26/2013 09:47 PM, Javier Martinez Canillas wrote:
> On Wed, Feb 27, 2013 at 12:08 AM, Jon Hunter <jon-hunter@ti.com> wrote:
>>
>> On 02/26/2013 04:01 AM, Javier Martinez Canillas wrote:
>>
>> [snip]
>>
>>> I was wondering if the level/edge settings for gpios is working on OMAP.
>>>
>>> I'm adding DT support for an SMSC911x ethernet chip connected to the
>>> GPMC for an OMAP3 SoC based board.
>>>
>>> In the smsc911x driver probe function (smsc911x_drv_probe() in
>>> drivers/net/ethernet/smsc/smsc911x.c), a call to request_irq() with
>>> the flag IRQF_TRIGGER_LOW is needed because of the wiring on my board.
>>>
>>> Reading the gpio-omap.txt documentation it says that #interrupt-cells
>>> should be <2> and that a value of 8 is "active low level-sensitive".
>>>
>>> So I tried this:
>>>
>>> &gpmc {
>>>       ethernet@5,0 {
>>>               pinctrl-names = "default";
>>>               pinctrl-0 = <&smsc911x_pins>;
>>>               compatible = "smsc,lan9221", "smsc,lan9115";
>>>               reg = <5 0 0xff>; /* CS5 */
>>>               interrupt-parent = <&gpio6>;
>>>               interrupts = <16 8>; /* gpio line 176 */
>>>               interrupt-names = "smsc911x irq";
>>>               vmmc-supply = <&vddvario>;
>>>               vmmc_aux-supply = <&vdd33a>;
>>>               reg-io-width = <4>;
>>
>> By the way, reg-io-width for omap does not look correct. The GPMC only
>> supports 8-bit or 16-bit devices IIRC. I believe all my omap boards use
>> 16-bit.
>>
> 
> I thought that even when the GPMC was a 16-bit external memory
> controller it could do some access adaptation to support 32-bit
> devices.

Right the GPMC itself may be able to translate 32-bit accesses into
16-bit. However, I have not looked at the data sheet for the smsc parts
to know what impact this would have on any register accesses in the smsc
device.

> By looking at the board files for others OMAP3 based boards
> (board-{omap3evm,overo,zoom-debugboard}.c) most of them set the struct
> omap_smsc911x_platform_data .flags member to SMSC911X_USE_32BIT.

I see this too now. I was looking at the
arch/arm/mach-omap2/gpmc-smc91x.c which has SMC91X_USE_16BIT and
GPMC_CONFIG1_DEVICESIZE_16. So this is for a slightly different ethernet
chip but same concept. Hopefully, someone knew what they were doing for
those other boards!

> And by looking at Documentation/devicetree/bindings/net/smsc911x.txt I
> thought that the corresponding DT property for this flag was
> "reg-io-width"
> 
> Anyway, I tried using both reg-io-width = <4> and reg-io-width = <2>.
> The ethernet chip works with both of them and I don't see too much
> difference in performance:
> 
> 16-bit
> round-trip min/avg/max = 0.611/0.738/0.946 ms
> 
> 32-bit
> round-trip min/avg/max = 0.519/0.690/0.976 ms
> 
> So, is your call ;-)

While I can't argue with the fact it works, I would not be prepared to
make that call without reviewing the documentation for the smsc and the
driver.

Cheers
Jon
