From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCHv2] of: Add generic handling for ePAPR 1.1 fail-sss states
Date: Thu, 8 Sep 2016 08:38:00 -0500
Message-ID: <CAL_Jsq+dm5HMkX8DNNZNB2QF-VPg96Esb+Capv88zys9nAPksw@mail.gmail.com>
References: <20160829223542.18871-1-tony@atomide.com> <57C74306.9020901@gmail.com>
 <20160831214151.wzq7y54xxs2qj422@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160831214151.wzq7y54xxs2qj422@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Frank Rowand <frowand.list@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Tom Rini <trini@konsulko.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Aug 31, 2016 at 4:41 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Frank Rowand <frowand.list@gmail.com> [160831 13:51]:
>> On 08/29/16 15:35, Tony Lindgren wrote:
>> >     if (of_device_is_incomplete(pdev->dev.of_node, status)) {
>> >             if (!strcmp("hw-incomplete-pins", status)) {
>> >                     dev_info(&pdev->dev,
>> >                              "Unusable hardware: Not pinned out\n");
>> >                     err = -ENODEV;
>> >                     goto out;
>> >             }
>> >             if (!strcmp("hw-missing-daughter-card")) {
>> >                     err = -EPROBE_DEFER;
>> >                     goto out;
>> >             }
>> >             if (!strcmp("hw-buggy-dma")) {
>> >                     dev_warn(&pdev->dev,
>> >                              "Replace hardware for working DMA\n");
>> >             }
>> >     }
>>
>> What if the device has two issues to be reported?  You can not
>> specify two different values for the status property.
>
> That's a good point.
>
>> What if the firmware wants to report that the hardware failed
>> self-test (thus status = "fail-sss") but is already using
>> status to describe the hardware?
>
> Yeah that's true. Do you know what the "sss" stands for here?
> Status Self teSt, or Side Scan Sonar? :)

String String String!!!?

No clue for me.

>
>> > - Make more generic as suggested by Frank but stick with
>> >   "operational status of a device" approch most people seem
>> >   to prefer that
>>
>> I am still opposed to using the status property for this purpose.
>>
>> The status property is intended to report an operational problem with
>> a device or a device that the kernel can cause to be operational (such
>> as a quiescent cpu being enabled).  It is the only property I am aware
>> of to report _state_.

Yes, in theory a device can go from disabled to okay, but that's
generally never been supported. Linux takes the simple approach of
"disabled" means ignore it. I think we'll see that change with
overlays.

>> It is unfortunate that Linux has adopted the practice of overloading status
>> to determine whether a piece of hardware exists or does not exist.  This
>> is extremely useful for the way we structure the .dts and .dtsi files but
>> should have used a new property name.  We are stuck with that choice of
>> using the status property for two purposes, first the state of a device,
>> and secondly the hardware description of existing or not existing.

I don't agree. Generally, disabled means the h/w is there, but don't
use it. There may be some cases where the hardware doesn't exist for
the convenience of having a single dts, but that's the exception.

>> Why not just create a new property that describes the hardware?
>> Perhaps something like:
>>
>>    incomplete = "pins_output", "buggy_dma";
>
> New property for incomplete works for me. Rob, got any comments here?

Pins not muxed out or connected on the board has to be the #1 reason
for disabled status. I don't think we need or want another way to
express that.

We may have discussed this, but why can't the driver that checks fail
state just check whatever was used to set the device to fail in the
first place?

Rob
