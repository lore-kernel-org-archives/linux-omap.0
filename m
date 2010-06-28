From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 1/3] OMAP: PM: initial runtime PM core support
Date: Mon, 28 Jun 2010 15:14:10 -0700
Message-ID: <AANLkTinfGMZADGx7aFQkAoQ_FmgyUMYm-VNjPosWdUhH@mail.gmail.com>
References: <1277422991-25350-1-git-send-email-khilman@deeprootsystems.com>
	<1277422991-25350-2-git-send-email-khilman@deeprootsystems.com>
	<AANLkTim4p54brsmph6oaKfoEZwO1GOGfgRNV9vJykOjl@mail.gmail.com>
	<874ogrng3j.fsf@deeprootsystems.com> <AANLkTimMnJvOJrRHDiE6PH1BXpRz2-6pY1M9nKHw7vpn@mail.gmail.com>
	<876316eno5.fsf@deeprootsystems.com> <AANLkTimB0_OfLDvtkwwTE-kVeZrardIxVIsD5IEia-vL@mail.gmail.com>
	<87d3vaygik.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46992 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450Ab0F1WOb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jun 2010 18:14:31 -0400
Received: by gxk23 with SMTP id 23so318675gxk.19
        for <linux-omap@vger.kernel.org>; Mon, 28 Jun 2010 15:14:30 -0700 (PDT)
In-Reply-To: <87d3vaygik.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Eric Miao <eric.miao@canonical.com>, Nicolas Pitre <nico@fluxnic.net>

On Mon, Jun 28, 2010 at 2:49 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
>
>> On Fri, Jun 25, 2010 at 4:46 PM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>> Grant Likely <grant.likely@secretlab.ca> writes:
>>>
>>>> Another way to look at the problem is that these runtime
>>>> customizations are kind of a property of the parent device (the bu=
s,
>>>> not the bus_type). =A0Would it make sense for parent devices to ha=
ve
>>>> runtime ops to perform for each child that is suspended/resumed? =A0=
That
>>>> would make it simple to register another device that implements th=
e
>>>> bus behaviour and attach it at runtime instead of compile time.
>>>
>>> Maybe I didn't fully understand your idea, but the problem here is
>>> devices do not have dev_pm_ops. =A0Only busses, classes, and types =
have
>>> dev_pm_ops.
>>
>> Sorry, I mistyped. =A0What I meant was for the parent device's
>> device_driver to be able to have a set of child dev_pm_ops; but I'm
>> wading into territory (power management) I'm not particularly famili=
ar
>> with, and that might be making things far too complex.
>
> I see your point now, but I think this indeed might complicate things
> too much.
>
> Also, I'm not crazy about how this would delay the per-device PM hook=
s
> to be essentially batched until all devices under the parent are
> "ready."

No, delaying until all children are ready wasn't my intent.  I was
thinking about a set of childs_dev_pm_ops() that would be called once
for each child as each child suspends/resumes...  but probably a moot
point since we both agree that it adds a lot of complexity.  :-)

>
> But anyways, it just needs some more research on my part.
> Unfortunately, I'll be away from this work on vacation for most of Ju=
ly,
> so this won't get any attention from me until August.
>
>>> Though I'm horribly unfamiliar with the intended usage of 'struct
>>> device_type', an interesing discovery is that dev->type also has
>>> dev_pm_ops, and it takes precedence over the bus type in the
>>> suspend/resume. =A0IOW, when suspending, when deciding which dev_pm=
_ops to
>>> use, it checks class, type, then bus in that order.
>>
>> So I guess my suggestion above boils down to somehow inserting
>> "parent" between type and bus in that list.
>>
>>> I need to explore this 'type' feature a little more, but using that=
 or
>>> the 'class' might be another way to have custom PM ops for certain
>>> platform_devices.
>>
>> Should maybe start cc'ing Greg and linux-kernel/linux-pm in this dis=
cussion.
>
> They were involved in the early discussions about overriding the
> platform_bus dev_pm_ops methods, which led us to the current
> implementation.
>
> But as I explore the custom bus approach a bit more (in August) I'll
> broaden the audience.
>
> Thanks again for all your helpful suggestions,

np.  Talk you you later.  Have a great vacation.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
