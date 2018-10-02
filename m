From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [RFC PATCH v2 1/9] leds: add TI LMU backlight driver
Date: Tue, 2 Oct 2018 20:52:09 +0200
Message-ID: <0be423a9-174c-60ce-0c67-7193c6af3063@gmail.com>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-2-dmurphy@ti.com> <20181002075629.GB19677@amd>
 <23dd6b46-cd16-ee67-3006-76a8dc67a7cb@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <23dd6b46-cd16-ee67-3006-76a8dc67a7cb@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

On 10/02/2018 02:32 PM, Dan Murphy wrote:
> Pavel
> 
> On 10/02/2018 02:56 AM, Pavel Machek wrote:
>> On Fri 2018-09-28 13:29:46, Dan Murphy wrote:
>>> From: Pavel Machek <pavel@ucw.cz>
>>>
>>> This adds backlight support for the following TI LMU
>>> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
>>>
>>> It controls LEDs on Droid 4
>>> smartphone, including keyboard and screen backlights.
>>>
>>> Signed-off-by: Milo Kim <milo.kim@ti.com>
>>> [add LED subsystem support for keyboard backlight and rework DT
>>> binding according to Rob Herrings feedback]
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>>> [remove backlight subsystem support for now]
>>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>
>> So... this driver adds support for LM3532, LM3631, LM3632, LM3633,
>> LM3695 and LM3697 (or it did when I signed it off).
> 
> Yes I have to pull these out of the patch.
> 
>>
>> The rest of the series does not really bring any advantages (you claim
>> it may add advantages in future). It takes code out of common driver
>> and duplicates it.
> 
> 
> I disagree.  Honestly using that ideallogy all LED drivers should use the common code
> as it is a wrapper around regmap and a few if statements.
> 
> The 3632 adds the proper LED flash class support coupled with proper backlight support.
> The 3633 adds the proper support for LV and HV LED support.
> 
> Duplicate code that I could find is put in the common file.
> This patch set adds the LED devices as all other LED devices are added in the LED directory.
> 
>>
>> Could we take this patch, get the basic support for LM3532, LM3631,
>> LM3632, LM3633, LM3695 and LM3697, and then split out the drivers when
>> we actually gain some advantage doing so (and also when the costs are
>> clear)?
> 
> We have debated this over and over and now we have 3 different implementations
> available we need to collude on which one we want to support.
> 
> Jacek I defer to you and Pavel since you are both LED maintainers.
> 
> I can support the dedicated LED drivers but I cannot support the TI LMU only implementation.

I uphold my previous opinion - please go ahead with moving the support
for non-MFD devices from MFD subsystem to the LED subsystem. And yes -
along with the bindings. This is semantically correct, and yet we don't
have mainline users.

Pavel - you will have to engage more people for your crusade to prevail.
For now, to speed up the things, I am forced to ignore your NAK.
So NAK to your NAK. Sorry.

-- 
Best regards,
Jacek Anaszewski
