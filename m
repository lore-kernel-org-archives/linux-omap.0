From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [rfc] leds: add TI LMU backlight driver
Date: Tue, 4 Sep 2018 09:34:49 -0500
Message-ID: <d96eab23-dbd9-71a6-551e-2bc99ce4a57c@ti.com>
References: <20180829212032.GB15786@amd>
 <a0906253-44e3-5a01-73ca-67c7cb124eb0@ti.com> <20180830201825.GA1936@amd>
 <ec7c9624-c1c3-df35-3593-704ac1dc9a4d@ti.com> <20180831213030.GA23447@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831213030.GA23447@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

Pavel

On 08/31/2018 04:30 PM, Pavel Machek wrote:
> Hi!
> 
>>> Aha. I did not realize that was for same hardware... I should have
>>> cc-ed you, I guess.
>>
>> No worries Jacek cc'd me.
> 
> Good.
> 
>>>> I do not like this driver.
>>>> I don't like that it smashes numerous devices into some structure with varying register maps.
>>>>
>>>
>>> Can you elaborate? The chips are similar enough that single driver
>>> makes sense, and we certainly want to maintain one driver, not 6
>>> drivers differing only in .. what exactly?
>>
>> Well I think it is justified to have independent drivers as each device has different features from
>> this basic LED driver.  If we are just looking for basic support then yes this driver is fine.
> 
>> But here is where a single driver will start getting messy and support difficult
>>
>> LM3533 has ALS and an ADC for an ALS analog sensor
>> LM3631 has no ALS functionality
>> LM3632 has strobe functionality and no ramp support
>> LM3633 has indicator support coupled with the hvled support
>> LM3695 does not even appear to be available publicly
>> LM3697 is the only device that that this driver could be used for as is.
> 
> Ok, so ... yes, I'm really interested in basic support. But drivers
> seem to have a lot in common, voltage limits, for example. 
> 
>> In addition if I wanted to only support a single device I have to pull in the full data
>> file that defines all the other devices.  That is pretty bad to increase the size of the kernel
>> image to have support for devices that are not even on the target product.  The ti-lmu data file
>> alone is ~15k, the ti-lmu code does not even build with this patch (So this is a nack on the patch as it is.)
>> but commenting out the offending code gives me at least ~23k more data on top
>> of the ti-lmu MFD framework which is ~33k.  That is ~71k of code just to support 1 LED device
>> that is 3x what we have now.  That is not good for IoT devices.
> 
>> The LM3697 is 22k without ramp support.
> 
> Well, I don't think object file size is huge problem. First,
> "distribution" kernel with support for 6 different chips will be ~71k,
> while your proposal will result in ~136k. Second, yes, we could put
> ifdefs into ti-lmu data file to make it smaller.
> 
> Anyway, clean source code and easy maintainance is more important.

I am going to reply here and snip the rest of the chain.

My proposal is to create a ti-lmu-led-common file that contains all the common
code.  We can have LED drivers use that common code to perform the common tasks.
This can then be extended to other devices past, present or future that have the
same feature set.

Then the register maps and LED registration can be contained in each LED driver and any additional features
can be supported in the LED driver.  The common code will retrieve any device settings from
the firmware that it is interested in.

I can throw some code together and RFC the code.  This way we get the common core for the
chips and not the bloat or messy source with a single driver.

And yes I can put this together and support it if it is needed.  I just need to go get the EVMs
so I can test it.

Thoughts?

<snip>-- 
------------------
Dan Murphy
