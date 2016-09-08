From: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv2] of: Add generic handling for ePAPR 1.1 fail-sss states
Date: Thu, 8 Sep 2016 12:17:45 -0700
Message-ID: <57D1B959.5090108@gmail.com>
References: <20160829223542.18871-1-tony@atomide.com>
 <57C74306.9020901@gmail.com> <20160831214151.wzq7y54xxs2qj422@atomide.com>
 <CAL_Jsq+dm5HMkX8DNNZNB2QF-VPg96Esb+Capv88zys9nAPksw@mail.gmail.com>
 <20160908155830.ov5so3vm2kmmccty@atomide.com> <57D1B75E.4020106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57D1B75E.4020106-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 09/08/16 12:09, Frank Rowand wrote:
> On 09/08/16 08:58, Tony Lindgren wrote:
>> * Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [160908 06:38]:
>>> On Wed, Aug 31, 2016 at 4:41 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
>>>> * Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160831 13:51]:
>>>>> I am still opposed to using the status property for this purpose.
>>>>>
>>>>> The status property is intended to report an operational problem with
>>>>> a device or a device that the kernel can cause to be operational (such
>>>>> as a quiescent cpu being enabled).  It is the only property I am aware
>>>>> of to report _state_.
>>>
>>> Yes, in theory a device can go from disabled to okay, but that's
>>> generally never been supported. Linux takes the simple approach of
>>> "disabled" means ignore it. I think we'll see that change with
>>> overlays.
>>
>> Yeah I think we have to assume that.
>>
>>>>> It is unfortunate that Linux has adopted the practice of overloading status
>>>>> to determine whether a piece of hardware exists or does not exist.  This
>>>>> is extremely useful for the way we structure the .dts and .dtsi files but
>>>>> should have used a new property name.  We are stuck with that choice of
>>>>> using the status property for two purposes, first the state of a device,
>>>>> and secondly the hardware description of existing or not existing.
>>>
>>> I don't agree. Generally, disabled means the h/w is there, but don't
>>> use it. There may be some cases where the hardware doesn't exist for
>>> the convenience of having a single dts, but that's the exception.
>>>
>>>>> Why not just create a new property that describes the hardware?
>>>>> Perhaps something like:
>>>>>
>>>>>    incomplete = "pins_output", "buggy_dma";
>>>>
>>>> New property for incomplete works for me. Rob, got any comments here?
>>>
>>> Pins not muxed out or connected on the board has to be the #1 reason
>>> for disabled status. I don't think we need or want another way to
>>> express that.
>>
>> Both status and and a separate property work for me.
>>
>> If no other considerations, we should probably pick something with a
>> a limited set of states to avoid it getting out of control and being
>> misused for something weird like driver probe order..
> 
> I do not want to add another property that conveys state.  The property
> that I was proposing does not convey state -- it describes the hardware.
> 
> 
>> For example, just status = "fail" would be enough for the cases I've
>> seen. That would still allow probe the device, then PM runtime idle
>> it and bail out with -ENODEV.
>>
>> For whatever warnings or errors the driver needs to show, the driver
>> could probably figure it out. I don't know if we want to or need to
>> pass any informational messages with the incomplete status or
>> property :)
>>
>>> We may have discussed this, but why can't the driver that checks fail
>>> state just check whatever was used to set the device to fail in the
>>> first place?
>>
>> Well there may be no way to check if something is pinned out based on
>> the hardware. The same SoC can be packaged with different pins. In that
>> case only the die id or serial number for each produced chip is
>> different, not the revision numbers. So for cases like that the dtb
>> file or kernel cmdline is the only information available. And we can't
>> assume pinctrl is required as it's perfectly fine to do that only in
>> the bootloader for the static cases to save memory.
>>
>> Just to consider other ways of doing it, we could use the compatible
>> flag to tag devices that need to be just idled on probe, but that does
>> not seem like generic solution to me.
> 
> Yuck.  Again overloading a property to convey multiple pieces of
> information.

I should have been more explicit in that statement.

If the hardware device does not have "wires" routed to a connector or
bus then it is still the same device.  Thus the compatible should be
the same.

The difference is the way the device is used in the SOC or board.

>>
>> Regards,
>>
>> Tony
>>
> 
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
