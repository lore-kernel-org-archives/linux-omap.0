From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Date: Fri, 14 Sep 2018 22:15:38 +0200
Message-ID: <9c14ee7c-f172-bb0c-d9a8-8aeee408f716@gmail.com>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com> <20180911200530.GA28290@amd>
 <85ab3bf4-21d4-dda9-a7c8-5ed68f15c611@ti.com> <20180912214938.GA30654@amd>
 <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com> <20180914081822.GA21830@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180914081822.GA21830@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Pavel,

On 09/14/2018 10:18 AM, Pavel Machek wrote:
> Hi!
> 
>>>> How do I politely explain that the original implementation was wrong for certain devices?
>>>
>>> Implementation? Device tree is hardware description.
>>
>> Yes this hardware description is incorrect.  The hardware description is
>> describing a MFD but this LED driver (and a couple others) only perform
>> 1 function and that is to drive a LED string.
> 
> So what? Does not seem incorrect to me. Maybe the description should
> not be in MFD directory, but other than that...
> 
>>>> Isn't code and documentation supposed to be pushed in stages
>>>> together?
>>>
>>> Device tree is _not_ documentation. And yes, it is normally pushed
>>> together. But that did not happen here, and bindings are already in.
>>
>> Hmm..  Its not documentation but it is in the Documentation folder.
>> And just because the bindings are in does not mean they cannot be
>> changed.
> 
> You may want to learn more about device tree and/or talk to the device
> tree maintainers. This is an old article. https://lwn.net/Articles/561462/

The article title is "Device trees as ABI". A device tree is defined
in the "*.dts" file that is then compiled to a dtb blob, which
constitutes the ABI. And this ABI should be kept backwards compatible.

What is discussed here is a documentation of bindings, i.e. according
to ePAPR: "requirements for how specific types and classes of devices
are represented in the device tree".

>From the bindings documented in the
Documentation/devicetree/bindings/mfd/ti-lmu.txt only
ti,lm3532-backlight is used in the mainline dts file
(arch/arm/boot/dts/omap4-droid4-xt894.dts).

Having the above it seems that there is no risk of breaking any
users.

> NAK on this patch. I see that this binding has problems, but
> introducing different binding for subset of devices is _not_ a fix.
> 
>>> What about the multi function devices? They should have same binding.
>>
>> The MFD devices defined are not in contention here only the SFD.
> 
> I'd like to see common solutions for SFD and MFD, as the hardware is
> similar, and that includes the code. Having code that is easier to
> maintain is important, and having many drivers are harder to maintain
> than one driver.
> 
> Milo's code looks better than yours in that regard. I disagree about
> Milo's code being "nightmare" to modify, and care about "easy to
> maintain" more than "binary size".

Easy to maintain will be a dedicated LED class driver.

-- 
Best regards,
Jacek Anaszewski
