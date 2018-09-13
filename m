From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Date: Thu, 13 Sep 2018 10:15:45 -0500
Message-ID: <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com> <20180911200530.GA28290@amd>
 <85ab3bf4-21d4-dda9-a7c8-5ed68f15c611@ti.com> <20180912214938.GA30654@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912214938.GA30654@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Pavel

On 09/12/2018 04:49 PM, Pavel Machek wrote:
> Hi!
> 
>> On 09/11/2018 03:05 PM, Pavel Machek wrote:
>>> On Tue 2018-09-11 12:08:20, Dan Murphy wrote:
>>>> Remove support for the LM3697 LED device
>>>> from the ti-lmu.  The LM3697 will be supported
>>>> via a stand alone LED driver.
>>>>
>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>
>>> I'd really like to see better explanation here.
>>>
>>
>> I will update the commit message but....
>>
>> How do I politely explain that the original implementation was wrong for certain devices?
> 
> Implementation? Device tree is hardware description.

Yes this hardware description is incorrect.  The hardware description is
describing a MFD but this LED driver (and a couple others) only perform
1 function and that is to drive a LED string.

> 
>> How do I politely explain that this binding has information that
>>  does not exist?
> 
> I don't understand this sentence.

That was explained later on the issues with the binding.

> 
>> Isn't code and documentation supposed to be pushed in stages
>> together?
> 
> Device tree is _not_ documentation. And yes, it is normally pushed
> together. But that did not happen here, and bindings are already in.
> 

Hmm..  Its not documentation but it is in the Documentation folder.
And just because the bindings are in does not mean they cannot be changed.

So someone hurried up and pushed the bindings that were not accurate and
they were taken and now we are stuck with this implementation?

That does not seem like progress.

> Bindings are an ABI between bootloader and kernel. They should not be
> changed lightly. 
> 
> Here I believe they should be fixed; not deleted.
> 

I am fixing them.  Removing devices that should not have been there to begin with.

Also if they are not to be changed lightly then why is there so much churn in the
staged patches.  Looks like the compatible is changing with this patch and appears that it
was not documented appropriately.
According to the above statement this patch should be rejected because it is changing the ABI.

https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/commit/?h=droid4-pending-v4.19&id=d774c7e447ac911e73a1b3c775e6d89f0422218c

>> Unfortunately Milo left TI before he had a chance to finish upstreaming.
> 
> Well -- I wanted to finish upstreaming. I still have those patches,
> and they still look reasonably well. Better than 
> 

than?

>> Some issues with the current binding:
>> 1) The documentation referenced in the ti-lmu.txt does not exist but the binding was accepted.
>> [1] ../leds/backlight/ti-lmu-backlight.txt
>> [2] ../leds/leds-lm3633.txt
>> [3] ../regulator/lm363x-regulator.txt
>>
>> 2) ramp-up-msec and ramp-down-msec are not explained or defined in this current binding.
>> Looks to be defined in the staged code though.
>>
>> 3) The ramp-up-msec and ramp-down-msec are not the right node parameters
>> the code shows ti,ramp-down-ms and ti,ramp-up-ms.  Looking at the clean up of the binding
>> in the staged commits the binding still does not match the code.
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/commit/?h=droid4-pending-v4.19&id=d774c7e447ac911e73a1b3c775e6d89f0422218c
>>
> 
> Bindings are authoritative. Of course, they can be fixed if really
> neccessary, but normally code should be adapted to the bindings, not
> the other way around.

They should only be authoritative when they are correct.

> 
> If slow ramping up/down is something that would be expected in other
> chips, too, ti, prefix is not good idea.
> 

Well if this is something expected for other chips shouldn't the LED framework be
updated as opposed to creating a stub layer to do this?

>> 4) The ramp rates ranges are incorrect for the LM3697 it should be from 0 -> 117400 ms
>>
>> 5) The children compatibles are not defined in this binding but appear to be removed in the staged code.
>>
>> 6) address-cells and size-cells are missing from the binding
> 
> Yep, ok, so these should be fixed. Still the bindings should be fixed,
> not removed and started over.
> 

So once something is in the binding it can never be removed?

>> I am attempting to clean this up for all the dedicated LED drivers.
>> There is a lot of bloat with this driver to support a single LED driver that is a single function device.
>>
> 
> What about the multi function devices? They should have same binding.

The MFD devices defined are not in contention here only the SFD.
The only comment there is data section bloat that occurs in attempting to support
only one device out of the supported devices.  But that can be done via #ifconfig

> 
>> This ti-lmu driver may be a great thing for the Droid 4 but from a customers
>> stand point that just wants to use just 1 of the dedicated LED drivers this driver is
>> overly complex and possibly hard to add code for differentiation.
> 
> The ti-lmu driver sounds like a way to go. We really want single
> driver, even if more complex, than 6 separate ones.

Not really in agreement here.  The ti-lmu driver only makes sense for MFD devices where
the device itself supports more then just one function.  Otherwise we could just lump every
single LED device into this driver.

Again not sure why we gloss over the fact that this driver with all of the device data is
the correct way to go for every single device.  If a target product only has the LM3697 why does the MFD need
to be used?  Why do we need to bring in all the support for all the additional devices?

This may be great for Droid 4 but not for any other device.  Including IoT devices that need smaller kernel
foot prints.

All be it the analog side of these devices may be the same but the digital side for each chip is different.
The register maps are not the same, the number of supported LED strings are not
the same, there are features not supported by this driver and will be a pain to add.
Adding features will be a complete night mare especially for the LM3632 which also support Torch and Flash.


Here are where a single driver will start getting messy and support difficult
LM3533 has ALS and an ADC for an ALS analog sensor
LM3631 has no ALS functionality
LM3632 has strobe/torch functionality and no ramp support
LM3633 has lvled support coupled with the hvled support
LM3695 does not even appear to be available publicly
LM3697 is the only device that that this driver could be used for as is.

Jacek has already agreed that having a dedicated LED driver for SFD devices is preferred method.

> 
>>> We have existing binding, for lm3697 and similar devices. With this
>>> series, different binding is introduced, without documented reason.
>>>
>>
>> I can update the commit message to indicate that this device is not a MFD
>> device and only is a SFD that needs to be supported by a dedicated
>> driver.
> 
> Device bindings are operating systems independend. This is not an argument.
> 

I have no idea what this statement means.

>>> Now, maybe you are right and the hardware should be handled by
>>> drivers/leds, not drivers/mfd. But we should have solution for all the
>>> similar chips, and that still does not mean we have to modify the
>>> binding. (But maybe we want to move it to different
>>> directory). Bindings are supposed to describe hardware, not mirror
>>> structure of our drivers.
>>
>> But this is not clean to have this device in the MFD bindings directory
>> when the support is in the LEDs directory.
> 
> Perhaps location of the binding is wrong. Still not reason to drop it
> and introduce new one.
> 

Location and implementation is wrong for certain devices.

>>>> index c885cf89b8ce..920f910be4e9 100644
>>>> --- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>>>> +++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
>>>> @@ -9,7 +9,6 @@ TI LMU driver supports lighting devices below.
>>>>    LM3632       Backlight and regulator
>>>>    LM3633       Backlight, LED and fault monitor
>>>>    LM3695       Backlight
>>>> -  LM3697       Backlight and fault monitor
>>>>  
>>>>  Required properties:
>>>>    - compatible: Should be one of:
> 
> You see? Even if your "new" binding has no flaws, "flawed" binding
> still remains in tree, and we still have problems for lm3632, 3633,
> 3695. That's why it needs to be fixed, not replaced.

I am working on those as well.  LM3632 is a MFD device and can be supported via
the MFD framework.

This work for the other LED drivers needs to be done before we bring in any other
code.

Dan

> 
> Best regards,
> 									Pavel
> 


-- 
------------------
Dan Murphy
