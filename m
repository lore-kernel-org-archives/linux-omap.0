From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: Re: [PATCH v2] usb: musb: Enable DMA mode1 RX for USB-Mass-Storage
Date: Tue, 19 Jul 2011 00:19:09 -0700
Message-ID: <CAFm5wm1kruM0WCoAsC7Ps09TsaCUA6G6NBT24q0QY6-_B9AAog@mail.gmail.com>
References: <1311033103-15854-1-git-send-email-vikram.pandita@ti.com> <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4CFC000B@dbde03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:44185 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752175Ab1GSHTa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jul 2011 03:19:30 -0400
In-Reply-To: <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4CFC000B@dbde03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sonasath, Moiz" <m-sonasath@ti.com>

On Mon, Jul 18, 2011 at 11:22 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
>> From: Vikram Pandita <vikram.pandita@ti.com>
>>
>> This patch enables the DMA mode1 RX support.
>> This feature is enabled based on the short_not_ok flag passed from
>> gadget drivers.
>>
>> This will result in a thruput performance gain of around
>> 40% for USB mass-storage/mtp use cases.
>>
>> Based on Original work by
>> Anand Gadiyar <gadiyar@ti.com> on 2.6.35 kernel
>>
>> Change-Id: I9b3a7cae73b63e86128d2caf4cdd67ab77556e75
>> Signed-off-by: Moiz Sonasath <m-sonasath@ti.com>
>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>
> I think the change-id should not be included in upstream
> submissions - it may not be useful to someone looking at
> the changelog. So you probably should drop it.

yes will drop that. This comes from gerrit commit hook that does not
have a meaning for upstream.

>
> Could you please retain my authorship and sign off from the
> original patch, since I did pretty much all the original work
> on writing this patch

That is given and clearly mentioned in the commit message.
I will change the authorship with no issues, but would have been nice
if you could have taken this upstream.
We have been carrying this optimisation around in product kernels for
a long time now and we keep redoing on each migration,
with the downside of sometimes loosing the authorship.

> (and if I remember correctly several
> attempts to get this merged upstream)? I don't see any
> functional changes from my original patch.

Wonder what were the reasons for not getting accepted?
Can you re-ignite the discussion why it cannot be taken in then?


>
>
> - Anand
>
