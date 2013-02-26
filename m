From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Tue, 26 Feb 2013 17:45:15 -0600
Message-ID: <512D490B.70900@ti.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <1329321854-24490-4-git-send-email-b-cousson@ti.com> <4F44FA56.7020000@gmail.com> <4F44FC37.2000701@ti.com> <4F452484.5080503@gmail.com> <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com> <4F47AD08.4030504@ti.com> <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com> <512D39DA.7020306@ti.com> <512D3AB1.1080202@wwwdotorg.org> <512D3EC2.6050408@ti.com> <512D3FE6.1010300@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56678 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755599Ab3BZXp2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Feb 2013 18:45:28 -0500
In-Reply-To: <512D3FE6.1010300@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>


On 02/26/2013 05:06 PM, Stephen Warren wrote:
> On 02/26/2013 04:01 PM, Jon Hunter wrote:
>>
>> On 02/26/2013 04:44 PM, Stephen Warren wrote:
>>> On 02/26/2013 03:40 PM, Jon Hunter wrote:
>>>>
>>>> On 02/26/2013 04:01 AM, Javier Martinez Canillas wrote:
>>>>
>>>> [snip]
>>>>
>>>>> I was wondering if the level/edge settings for gpios is working on OMAP.
>>>>>
>>>>> I'm adding DT support for an SMSC911x ethernet chip connected to the
>>>>> GPMC for an OMAP3 SoC based board.
>>>>>
>>>>> In the smsc911x driver probe function (smsc911x_drv_probe() in
>>>>> drivers/net/ethernet/smsc/smsc911x.c), a call to request_irq() with
>>>>> the flag IRQF_TRIGGER_LOW is needed because of the wiring on my board.
>>>>>
>>>>> Reading the gpio-omap.txt documentation it says that #interrupt-cells
>>>>> should be <2> and that a value of 8 is "active low level-sensitive".
>>>>>
>>>>> So I tried this:
>>>>>
>>>>> &gpmc {
>>>>> 	ethernet@5,0 {
>>>>> 		pinctrl-names = "default";
>>>>> 		pinctrl-0 = <&smsc911x_pins>;
>>>>> 		compatible = "smsc,lan9221", "smsc,lan9115";
>>>>> 		reg = <5 0 0xff>; /* CS5 */
>>>>> 		interrupt-parent = <&gpio6>;
>>>>> 		interrupts = <16 8>; /* gpio line 176 */
>>>>> 		interrupt-names = "smsc911x irq";
>>>>> 		vmmc-supply = <&vddvario>;
>>>>> 		vmmc_aux-supply = <&vdd33a>;
>>>>> 		reg-io-width = <4>;
>>>>>
>>>>> 		smsc,save-mac-address;
>>>>>       };
>>>>> };
>>>>
>>>> Are you requesting the gpio anywhere? If not then this is not going to
>>>> work as-is. This was discussed fairly recently [1] and the conclusion
>>>> was that the gpio needs to be requested before we can use as an interrupt.
>>>
>>> That seems wrong; the GPIO/IRQ driver should handle this internally. The
>>> Ethernet driver shouldn't know/care whether the interrupt it's given is
>>> some form of dedicated interrupt or a GPIO-based interrupt, and even if
>>> it somehow did, there's no irq_to_gpio() any more, so the driver can't
>>> tell which GPIO ID it should request, unless it's given yet another
>>> property to represent this.
>>
>> I agree that ideally this should be handled internally. Did you read the
>> discussion on the thread that I referenced [1]? If you have any thoughts
>> we are open to ideas :-)
>>
>> Cheers
>> Jon
>>
>> [1] http://comments.gmane.org/gmane.linux.ports.arm.omap/92192
> 
> Oh, when I clicked that link the first time, all I saw was the patch,
> not any discussion. I guess it must have timed out finding the other
> emails or something.

Actually, I sent a slightly different link the 2nd time to ensure you
saw the thread. So my fault ;-)

> I disagree that the GPIO needs to be requested, and that a custom DT
> property and associated code are needed for that; simply requesting the
> IRQ should be enough to make everything work.
> 
> In the Tegra GPIO IRQ driver for example, the irq_set_type irq_chip op
> goes and configures the base GPIO HW to enable the pin as a GPIO, just
> like gpio_request() would. I imagine the OMAP driver can do whatever
> similar action it needs.

Yes that is similar to what the patch in the thread was attempting to
do, but this got shot down.

One issue I see is that by not calling gpio_request, then potentially
you could have someone request a gpio via gpio_request() and someone
trying to use it as an interrupt source via request_irq(). Now obviously
that represents a bug because there is only one physical gpio, but I
gather it is something we need to protect against.

Cheers
Jon
