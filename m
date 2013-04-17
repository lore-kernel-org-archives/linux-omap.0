From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Wed, 17 Apr 2013 16:21:58 +0200
Message-ID: <CAAwP0s2xDCxvbXbyQ7td5axqBfV0xFEX2a-CNSw0NONG3b0XRg@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <CACRpkdYbs4-uudpRUY8e+7icYYkZrfM0kReP3pLL5DMiURJ4dg@mail.gmail.com>
 <5165CB9D.1090202@wwwdotorg.org> <CACRpkdYirFNqmGhA4K9CL4ve4NYhs8Rd3SFt1iwW9vHBkrcz8g@mail.gmail.com>
 <51671D7B.5060303@wwwdotorg.org> <CACRpkdbf32Ef77GmXk9id9+RRjcDRTr7S+F4nznoeZU8y=BT_Q@mail.gmail.com>
 <51673D70.3010503@wwwdotorg.org> <CAAwP0s0e2x33jZQhFRY+Hoo61SFqYKRgWk=1mL2+DNxSDJHz+A@mail.gmail.com>
 <CACRpkda4h+qXTvsirPAS7E7sjXhMLE62q=VDy53W8UchsYjbNg@mail.gmail.com>
 <516C31C3.9040505@wwwdotorg.org> <516C7C43.3040105@wwwdotorg.org>
 <516C8760.2050500@ti.com> <516D9B05.1000501@wwwdotorg.org>
 <516DA60A.5070000@ti.com> <516DCCA8.3070108@wwwdotorg.org>
 <516DDB4D.9020500@ti.com> <CAAwP0s0-VNUoeSKaGbvoDeD7m7kZRdp5rCJ7iVpFoFAaQtXcmQ@mail.gmail.com>
 <516E022F.5050708@ti.com> <CAAwP0s2M2pnSydyDvh_rejFO=w8bCo4WE5PkxrYuk0HQDixc-Q@mail.gmail.com>
 <516EA2B1.3070201@ti.com> <CAAwP0s2DsJAWuXWvPAkzCT0T0AG_OvMEw2sADW6LqSi1Ofd_Zw@mail.gmail.com>
 <516EA937.8060201@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170]:60391 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966485Ab3DQOWT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Apr 2013 10:22:19 -0400
Received: by mail-ia0-f170.google.com with SMTP id 21so1290057iay.1
        for <linux-omap@vger.kernel.org>; Wed, 17 Apr 2013 07:22:18 -0700 (PDT)
In-Reply-To: <516EA937.8060201@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Linus Walleij <linus.walleij@linaro.org>, Grant Likely <grant.likely@secretlab.ca>, Alexandre Courbot <acourbot@nvidia.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Apr 17, 2013 at 3:52 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>
> On 04/17/2013 08:42 AM, Javier Martinez Canillas wrote:
>> On Wed, Apr 17, 2013 at 3:25 PM, Jon Hunter <jon-hunter@ti.com> wrote:
>>>
>>> On 04/17/2013 02:55 AM, Javier Martinez Canillas wrote:
>>>
>>> ...
>>>
>>>> There are so many patches flying around in this thread that I missed it :-)
>>>>
>>>> Sorry about that...
>>>
>>> No problem.
>>>
>>>>> I was trying to see if we could find a common solution that everyone
>>>>> could use as it seems that ideally we should all be requesting the gpio.
>>>>>
>>>>> Cheers
>>>>> Jon
>>>>>
>>>>> [1] http://marc.info/?l=linux-arm-kernel&m=136606204823845&w=1
>>>>
>>>> btw, I shared the latest patch with only build testing it, but today I
>>>> gave a try and I found a problem with this approach. The .xlate
>>>> function is being called twice for each GPIO-IRQ so the first time
>>>> gpio_request_one() succeeds but the second time it fails returning
>>>> -EBUSY.
>>>
>>> I tried it and I did not see that. I don't see the below warning either.
>>>
>>
>> weird, I wonder what's different here.
>
> I am testing on an omap4-sdp which uses a spi based ethernet device.
> However, I could try with the omap3430-sdp which uses gpmc.
>

Thanks, that would be great and it could be a difference.

But don't worry I'll to test it more extensively when I have some free
time. I just shared here in case you had the same issue.

> Cheers
> Jon

Thanks a lot for your help,
Jaiver
