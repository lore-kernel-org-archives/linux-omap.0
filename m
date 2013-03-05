From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
Date: Tue, 5 Mar 2013 12:41:22 -0600
Message-ID: <51363C52.10503@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com> <1361899842-30303-12-git-send-email-jon-hunter@ti.com> <51360271.1030302@mimc.co.uk> <51360562.20309@ti.com> <51361B46.507@mimc.co.uk> <51362BAB.10403@ti.com> <CALF0-+WnOWRD=sXNh_2hJutwxzrs22c97jKLiJa8Xjc=xaESpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47560 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756385Ab3CESle (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Mar 2013 13:41:34 -0500
In-Reply-To: <CALF0-+WnOWRD=sXNh_2hJutwxzrs22c97jKLiJa8Xjc=xaESpA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <elezegarcia@gmail.com>
Cc: Mark Jackson <mpfj-list@mimc.co.uk>, device-tree <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 03/05/2013 11:43 AM, Ezequiel Garcia wrote:
> Hi Jon,
> 
> On Tue, Mar 5, 2013 at 2:30 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>>
>> This really highlights a weakness in the GPMC driver, particularly
>> for NOR, where the child device can only be probed once the parent
>> is probed. I don't see this as being DT specific issue, because
>> even on older OMAP boards we always registered the NOR flash device
>> independently of the GPMC device. So we have always been susceptible to
>> this problem AFAICT.
>>
>> This is admittedly a hack, but I am curious if you add the pinctrl
>> properties to the NOR node, if this would also defer the probe on the
>> NOR device?
>>
>> Ideally it would be great to defer the probing of the child until the
>> parent has been probed successfully.
>>
> 
> This seems related to the probing parent-child ordering probing
> I pointed out in a previous mail, isn't it?

Yes in this case. However, I have no idea what the problem you are
having is. So I cannot comment if your problem represents a real
scenario or not.

> (which by the way, I'll answer when I can gather some more convincing
> feedback).

Thanks.

> I don't have OMAP NOR boards, so I'm not entirely familiar to the
> way GPMC registers the NOR device. However, by looking
> into board-flash.c:board_nor_init() function, it seems to me that:
> 
> 1. first we request the CS with gpmc_cs_request() and
> 2. later we register the NOR device explicitly with
>     platform_device_register().
> 
> So, unless I'm missing something, we force the NOR device
> to be probed *after* the GPMC device.
>
> This is definitely the way NAND, OneNAND is handled.
> 
> On the otherside, by using 'simple-bus' you create your devices
> first, when the whole device-tree is parsed and later the drivers
> are probed at module_initcall time.
> 
> So, AFAIK, this problem is DT specific.

This assumes that the GPMC driver is registered (and probed) before 1
and 2 above occur. What is DT specific about when the driver is registered?

What happens in the non-DT case when the GPMC probe is deferred or fails?

We would never register the GPMC devices, right? For the deferred case
that is not so good. So the current implementation is flawed if the
probe is deferred. However, it would not crash which is a plus.

So my point is in Mark's example, if someone were to add pinctrl support
to the existing GPMC driver which caused the GPMC probe to be deferred
then none of the GPMC child devices would ever be registered. I don't
see that being related to DT either.

What you are also missing is that in the probe_nor() function, if we
fail to allocate the required resources, then I disable the child node
and the child is not registered and hence not probed. I have tested this
and for me this works. I was hoping this would be sufficient to handle
failure cases and avoid crashes.

> On the other side, when you say we should defer the probing
> of the child. Do you mean changing something in physmap/NAND/etc. drivers?

Not necessarily.

> Please keep in mind, I have nothing against using simple-bus,
> since it's a very clean solution. It's just that it seems to me it will
> be problematic.
> Moreover, the fix shouldn't be too complicated (still working on this).

I am interested to know what your approach will be. One alternative is
to call of_platform_device_create() from the GPMC driver. I could see
this as being a safe option.

> I'll try to post my Device Bus driver soon (similar to GPMC)
> and also I'll try to answer the previous discussion with some
> information on why I think this won't work.
> 
> (I hope I'm not making too much noise with this)

No it is all good inputs. I am just frustrated to be told that this
implementation is flawed without being able to tell me exactly why or
the scenario where it would not work.

The probe deferred case is a good example where this implementation will
have problems. I see that as legitimate. However, I have no idea if what
you are reporting is also legitimate or not. May be it is, I just don't
know.

Jon


