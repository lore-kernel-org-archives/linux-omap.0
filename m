From: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] of: Add generic handling for hardware incomplete fail state
Date: Tue, 12 Apr 2016 17:20:56 -0500
Message-ID: <CAL_Jsq+B67np4qcwJ2m1yz3TOzYgb7ZQtRH+vhANm9Snw5QnzQ@mail.gmail.com>
References: <1460486275-12256-1-git-send-email-tony@atomide.com>
 <570D56FE.2070408@gmail.com> <20160412203431.GU5995@atomide.com> <570D6B7A.3050203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <570D6B7A.3050203-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tom Rini <trini-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Apr 12, 2016 at 4:41 PM, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 4/12/2016 1:34 PM, Tony Lindgren wrote:
>> Hi,
>>
>> * Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [160412 13:15]:
>>> Hi Tony,
>>>
>>> I agree with the need for some way of handling the incomplete
>>> hardware issue.  I like the idea of having a uniform method for
>>> all nodes.
>>>
>>> I am stumbling over what the status property is supposed to convey
>>> and what the "fail-hw-incomplete" is meant to convey.
>>>
>>> The status property is meant to convey the current state of the
>>> node.
>>>
>>> "fail-hw-incomplete" is meant to describe the node implementation,
>>> saying that some portions of hardware that the driver expects to
>>> be present do not exist.  If I understood your explanation at ELC
>>> correctly, an examples of this could be that a uart cell is not
>>> routed to transmit and receive data pins or the interrupt line
>>> from the cell is not routed to an interrupt controller.  So the
>>> node is not useful, but it makes sense to be able to power manage
>>> the node, turning off power so that it is not wasting power.
>>
>> Yes cases like that are common.
>>
>>> It seems to me that the info that needs to be conveyed is a
>>> description of the hardware, stating:
>>>   - some portions or features of the node are not present and/or
>>>     are not usable
>>>   - power management of the node is possible
>>>
>>> Status of "fail-sss" is meant to indicate an error was detected in
>>> the device, and that the error might (or might not) be repairable.
>>>
>>> So the difference I see is state vs hardware description.

The question to ask is are we indicating the "operational status of a
device"? If yes, that is the definition of status and using it would
be appropriate.

IMO, I think we are.

>> OK thanks for the clarification. I don't see why "fail-hw-incomplete"
>> could not be set dynamically during the probe in some cases based
>> on the SoC revision detection for example. So from that point of
>> view using status with the "fail-sss" logic would make more sense.
>
> If the probe detects that the device should only be power managed
> based on the SoC revision, then it would simply be one more
> test added at the top of probe.  The patch would change from:
>
>    if (of_device_is_incomplete(pdev->dev.of_node)) {
>
> to:
>
>    if (of_device_is_incomplete(pdev->dev.of_node) || socrev == XXX) {

I think Tony meant the bootloader or platform code would do this and
tweak the DT. We don't have much of a standard API for revision
checking, so drivers don't check SoC revisions generally.

> That code would be the same whether the property involved was
> status or something else.
>
>>
>>> I would prefer to come up with a new boolean property (with a
>>> standard name that any node binding could choose to implement)
>>> that says something like "only power management is available for
>>> this node, do not attempt to use any other feature of the node".
>>
>> Heh that's going to be a long property name :) How about
>> unusable-incomplete-idle-only :)
>
> Or even pm-only.  Maybe I got a little carried away with my
> verbosity. :)

I don't think we should define it so narrowly. I think DT just
indicates the device is in a non-usable state (somewhere between ok
and disabled) and the driver knows what to do with that information.

>>> With that change, the bulk of your patch looks good, with
>>> minor changes:
>>>
>>>   __of_device_is_available() would not need to change.
>>>
>>>   __of_device_is_incomplete() would change to check the new
>>>   boolean property.  (And I would suggest renaming it to
>>>   something that conveys it is ok to power manage the
>>>   device, but do not do anything else to the device.)
>>
>> I'm fine with property too, but the runtime probe fail state
>> changes worry me a bit with that one.
>
> I don't understand what the concern is.  The change I suggested
> would use exactly the same code for probe as the example patch
> you provided, but just with a slight name change for the function.
>
>
>> I think Rob also preferred to use the status though while we
>> chatted at ELC?
>
> That is the impression I got too.  We'll have to see if I can
> convince him otherwise.

I did, but I'm not wed to it. I think it depends on the question above.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
