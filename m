From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] ARM: dts: omap5-board-common: enable rtc and charging
 of backup battery
Date: Wed, 6 Jan 2016 13:34:13 -0600
Message-ID: <CAL_Jsq+rfU0EuoRi1Jkq2QYQjK0_LOW8PALatYccpbJiPPZh-g@mail.gmail.com>
References: <cover.1451995297.git.hns@goldelico.com> <b4a6fe205cbb1a9eddc4e5f63fa05d299641313d.1451995297.git.hns@goldelico.com>
 <568C5451.8070709@ti.com> <B2CEA92E-5F60-43C1-8265-F7C66FBD90D6@goldelico.com>
 <568CCCA2.4040004@nvidia.com> <568D2657.6050400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <568D2657.6050400-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 6, 2016 at 8:36 AM, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> wrote:
> On 01/06/2016 02:13 AM, Laxman Dewangan wrote:
>>
>> On Wednesday 06 January 2016 01:12 PM, H. Nikolaus Schaller wrote:
>>> Hi,
>>>
>>> Am 06.01.2016 um 00:40 schrieb Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>:
>>>
>>>> On 01/05/2016 06:01 AM, H. Nikolaus Schaller wrote:
>>>>> +        rtc {
>>>>> +            compatible = "ti,palmas-rtc";
>>>>> +            interrupt-parent = <&palmas>;
>>>>> +            interrupts = <8 IRQ_TYPE_NONE>;
>>>> IRQ_TYPE_NONE is not correct here -> it should have some polarity - if
>>>> it had none, there'd be no interrupt, right?
>>> Well, it just translates IRQ_TYPE_NONE through
>>>
>>> Linux/include/dt-bindings/interrupt-controller/irq.h
>>>
>>> to
>>>
>>> interrupts = <8 0>;
>>>
>>> which is given as an example in
>>>
>>> Documentation//devicetree/bindings/rtc/rtc-palmas.txt
>>>
>>> Since I don't know anything about the rtc driver beyond the bindings
>>> documentation I assume it is correct...
>>> I have added Laxman Dewangan because he introduced this interrupts =
>>> <8 0>;
>>>
>>
>> As this is for palmas interrupt controller, it does not use the second
>> field for interrupt from RTC.
>> So there is no really any polarity. It can be set to 0.
>>
>> The second argument will be used for GPIOs mainly. However, support need
>> to be added on GPIO driver for rising/falling configuration.
>
>
> Device tree represents the hardware - not to reflect how the driver
> works. if the driver is wrong, fix it. the interrupt polarity needs to
> be described in DT. based on palmas like designs, you should probably
> use IRQ_TYPE_EDGE_FALLING because that is the default signaling inside
> the SoC as it reaches Secondary interrupt handlers(SIH) registers.

If the trigger type is not programmable, then not setting the trigger
type in the DT is fine. Internal connections are often not documented.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
