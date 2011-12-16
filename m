From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [QUESTION] How to set static/dynamic dependency between clock domains
Date: Fri, 16 Dec 2011 21:20:39 +0530
Message-ID: <CAMQu2gzZ4EBpPWej+TQ3GShDjxZimCZVdVUoE-iPhOWBDS9Wfg@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
 <CACVXFVNOpfWxod_pN-kiQPoQ7n=XSFeV6WK6sf+8hYSiZ2rDBA@mail.gmail.com>
 <CAMQu2gxNvrMXYs0gPYTS3wUL=toL=ccRxso25esXwmx9j4O5fg@mail.gmail.com> <CACVXFVNw1ni63Pk-SxaykTjMS4Qm0_9wtt8=DXypoKwfUiA2ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:57067 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759643Ab1LPPvC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Dec 2011 10:51:02 -0500
Received: by qcso15 with SMTP id o15so2123459qcs.37
        for <linux-omap@vger.kernel.org>; Fri, 16 Dec 2011 07:51:00 -0800 (PST)
In-Reply-To: <CACVXFVNw1ni63Pk-SxaykTjMS4Qm0_9wtt8=DXypoKwfUiA2ig@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

On Fri, Dec 16, 2011 at 9:16 PM, Ming Lei <tom.leiming@gmail.com> wrote=
:
> On Fri, Dec 16, 2011 at 11:13 PM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
>> On Fri, Dec 16, 2011 at 7:20 PM, Ming Lei <tom.leiming@gmail.com> wr=
ote:
>>> Hi,
>>>
>>> On Fri, Dec 16, 2011 at 9:24 PM, Ming Lei <tom.leiming@gmail.com> w=
rote:
>>>
>>>> [1], add static dependency
>>>
>>> Sorry for the mess, see attachment for the change.
>>>
>> Your patch is setting static dependency between ISS and l3_2.
>> It's not dynamic dep. Dynamic dep is managed through hardware and th=
ey
>
> Yes, I see now, =A0L3_2_DYNDEP of CM_CAM_DYNAMICDEP is read only.
>
>> are not configurable. But with static dep. you can over-ride that be=
havior
>> as you have done.
>>
>> This will impact power since l3_2 can't idle as long as iss clock
>> domain is active.
>>
>> I need to check internal code-base but I don't remember this
>> issue observed so far.
>
> In fact, I saw the issue on 3.2.0-rc5-next-20111216, and even
> no such issue on 3.2.0-rc5. =A0After some bisecting, I found below
> is the first commit on which the issue can be observed:
>
> commit 3c50729b3fa1cd8ca1f347e6caf1081204cf1a7c
> Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: =A0 Wed Jan 5 22:03:17 2011 +0530
>
> =A0 =A0ARM: OMAP4: PM: Initialise all the clockdomains to supported s=
tates
>
> =A0 =A0Initialise hardware supervised mode for all clockdomains if it=
's
> =A0 =A0supported. Initiate sleep transition for other clockdomains,
> =A0 =A0if they are not being used.
>
Before this patch all clock-domains were  put into SW forcewakeup
and hence the clock domains were not idling. With this patch now, hw
will take control of the clock-domain idle based on the domain
activities.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
