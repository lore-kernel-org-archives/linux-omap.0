From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Date: Fri, 21 Sep 2018 07:44:00 -0500
Message-ID: <50e9aa50-99fb-0a1f-e395-c52bf91e8a7f@ti.com>
References: <20180911170825.17789-2-dmurphy@ti.com>
 <20180911200530.GA28290@amd> <85ab3bf4-21d4-dda9-a7c8-5ed68f15c611@ti.com>
 <20180912214938.GA30654@amd> <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com>
 <20180914081822.GA21830@amd> <9c14ee7c-f172-bb0c-d9a8-8aeee408f716@gmail.com>
 <20180914214220.GA2081@amd> <be2ee681-7ae0-6545-0208-6ae5c1b7affd@gmail.com>
 <5a249ae3-e3f7-8eff-4022-ed982e364326@ti.com>
 <20180920220443.GB27468@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920220443.GB27468@xo-6d-61-c0.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Pavel

On 09/20/2018 05:04 PM, Pavel Machek wrote:
> Hi!
> 
>>>>> Easy to maintain will be a dedicated LED class driver.
>>>>
>>>> You mean, 3 dedicated LED class drivers and 3 MFD drivers with LED
>>>> parts? We'll need complex driver anyway, and I'd really like to have
>>>> just one.
>>>
>>> In the LED subsystem we can wrap common functionalities
>>> into a library object. MFD driver will be able to reuse it then.
>>
>> I am currently working on that code now.  I expect a RFC on this this week.
> 
> Looking forward to that.
> 
> But you really need acks for the bindings, and since Rob is usually quite slow
> acking them, it is easiest to use the existing binding... if it is wrong it
> needs to be fixed, anyway.
> 

OK I am in the midst of creating the code now. I have the common code done I just need to
make sure that it scales to other devices in the list.

The bindings will need to be updated to follow the LED bindings binding style.

I am wondering for the non-MFD parts if we should move the bindings to the LED
directory to make them easier to find.

Dan 

> THanks,
> 
> 									Pavel
> 


-- 
------------------
Dan Murphy
