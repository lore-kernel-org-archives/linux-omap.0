From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [RFC PATCH v2 2/9] dt-bindings: ti-lmu: Remove LM3697
Date: Thu, 4 Oct 2018 08:26:50 -0500
Message-ID: <e14aeedb-e58b-f3e0-72f6-2bfb04a29e3c@ti.com>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-3-dmurphy@ti.com> <20181002072827.GA19677@amd>
 <fef2c612-ac35-126e-669e-335fb3075f64@ti.com> <20181003130154.GA20418@amd>
 <f4ed1450-6c99-e4c6-0092-f355ab3278f7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f4ed1450-6c99-e4c6-0092-f355ab3278f7@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Jacek

On 10/03/2018 03:46 PM, Jacek Anaszewski wrote:
> On 10/03/2018 03:01 PM, Pavel Machek wrote:
>> On Wed 2018-10-03 07:24:23, Dan Murphy wrote:
>>> Hello
>>>
>>> On 10/02/2018 02:28 AM, Pavel Machek wrote:
>>>> On Fri 2018-09-28 13:29:47, Dan Murphy wrote:
>>>>> Remove support for the LM3697 LED device
>>>>> from the ti-lmu.  The LM3697 will be supported
>>>>> via a stand alone LED driver.
>>>>>
>>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>>
>>>> NAK, for reasons I explained before. Please add it to the patch so
>>>> that it does not get applied by mistake. Ouch and AFAICT Rob was not
>>>> happy with this either.
>>>>
>>>> Yes, you are creating new drivers, ok; but that does _not_ mean you
>>>> should create new binding.
>>>
>>> I am copying my comment here on the review of this original binding for
>>> records
>>>
>>> I found the review or at least the reference for the ti-lmu.txt binding.
>>>
>>> https://lore.kernel.org/patchwork/patch/764180/
>>>
>>> Does not appear that the binding was sent to the device tree mail list.
>>> (Maybe that email list did not exist in Feb 2017).
>>
>> Quick google shows:
>>
>> https://lwn.net/Articles/666023/
> 
> This link refreshed my memory and allowed me to recall Milo's patch set
> from the end of 2015, and the related discussion. I had an impression
> that I had had some request regarding the bindings but there was no
> follow-up.
> 
> I've googled that thread [0] and it proved I was right [1].
> 
> From Milo's messages we can infer that there will be next
> version of the patch set and it appeared but over a year later [2],
> and without the leds-lm3633 driver and related bindings, and without
> drivers/video/backlight/ti-lmu-backlight-core.c.
> 
> Patch set gets merged despite dangling DT references.
> 
> Dan, I propose you to resend the patch removing the bindings from
> MFD, and explain the rationale in the patch below commit message
> after "---" .
> 
>> Now can we stop this nonsense? If there is a problem with the binding,
>> submit patches to fix the problem.
> 
> [0]
> https://lore.kernel.org/lkml/1448521025-2796-1-git-send-email-milo.kim@ti.com/
> [1] https://lore.kernel.org/lkml/56656468.8020300@samsung.com/
> [2]
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1341860.html
> 

Sounds good I will clean this up and submit a v3 non-RFC edition

Dan

-- 
------------------
Dan Murphy
