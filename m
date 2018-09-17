From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Date: Mon, 17 Sep 2018 10:24:21 -0500
Message-ID: <5a249ae3-e3f7-8eff-4022-ed982e364326@ti.com>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com> <20180911200530.GA28290@amd>
 <85ab3bf4-21d4-dda9-a7c8-5ed68f15c611@ti.com> <20180912214938.GA30654@amd>
 <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com> <20180914081822.GA21830@amd>
 <9c14ee7c-f172-bb0c-d9a8-8aeee408f716@gmail.com> <20180914214220.GA2081@amd>
 <be2ee681-7ae0-6545-0208-6ae5c1b7affd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <be2ee681-7ae0-6545-0208-6ae5c1b7affd@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Jacek

On 09/15/2018 03:00 PM, Jacek Anaszewski wrote:
> Hi Pavel.
> 
> On 09/14/2018 11:42 PM, Pavel Machek wrote:
>> Hi!
>>
>>>> You may want to learn more about device tree and/or talk to the device
>>>> tree maintainers. This is an old article. https://lwn.net/Articles/561462/
>>>
>>> The article title is "Device trees as ABI". A device tree is defined
>>> in the "*.dts" file that is then compiled to a dtb blob, which
>>> constitutes the ABI. And this ABI should be kept backwards compatible.
>>>
>>> What is discussed here is a documentation of bindings, i.e. according
>>> to ePAPR: "requirements for how specific types and classes of devices
>>> are represented in the device tree".
>>>
>>> >From the bindings documented in the
>>> Documentation/devicetree/bindings/mfd/ti-lmu.txt only
>>> ti,lm3532-backlight is used in the mainline dts file
>>> (arch/arm/boot/dts/omap4-droid4-xt894.dts).
>>>
>>> Having the above it seems that there is no risk of breaking any
>>> users.
>>
>> DTBs and bindings are supposed to be portable between operating
>> systems. You are right there are no _mainline_ _Linux_ users.
> 
> No mainline users means no users we should care of.
> Other people also don't care - see patch [0].
> 
>>>> NAK on this patch. I see that this binding has problems, but
>>>> introducing different binding for subset of devices is _not_ a fix.
>>>>
>>>>>> What about the multi function devices? They should have same binding.
>>>>>
>>>>> The MFD devices defined are not in contention here only the SFD.
>>>>
>>>> I'd like to see common solutions for SFD and MFD, as the hardware is
>>>> similar, and that includes the code. Having code that is easier to
>>>> maintain is important, and having many drivers are harder to maintain
>>>> than one driver.
>>>>
>>>> Milo's code looks better than yours in that regard. I disagree about
>>>> Milo's code being "nightmare" to modify, and care about "easy to
>>>> maintain" more than "binary size".
>>>
>>> Easy to maintain will be a dedicated LED class driver.
>>
>> You mean, 3 dedicated LED class drivers and 3 MFD drivers with LED
>> parts? We'll need complex driver anyway, and I'd really like to have
>> just one.
> 
> In the LED subsystem we can wrap common functionalities
> into a library object. MFD driver will be able to reuse it then.

I am currently working on that code now.  I expect a RFC on this this week.

Dan

> 
> [0]
> https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/commit/?h=droid4-pending-v4.19&id=d774c7e447ac911e73a1b3c775e6d89f0422218c
> 


-- 
------------------
Dan Murphy
