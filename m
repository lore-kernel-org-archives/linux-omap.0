From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [RFC PATCH v2 1/9] leds: add TI LMU backlight driver
Date: Tue, 2 Oct 2018 07:32:36 -0500
Message-ID: <23dd6b46-cd16-ee67-3006-76a8dc67a7cb@ti.com>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-2-dmurphy@ti.com> <20181002075629.GB19677@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002075629.GB19677@amd>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Pavel

On 10/02/2018 02:56 AM, Pavel Machek wrote:
> On Fri 2018-09-28 13:29:46, Dan Murphy wrote:
>> From: Pavel Machek <pavel@ucw.cz>
>>
>> This adds backlight support for the following TI LMU
>> chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
>>
>> It controls LEDs on Droid 4
>> smartphone, including keyboard and screen backlights.
>>
>> Signed-off-by: Milo Kim <milo.kim@ti.com>
>> [add LED subsystem support for keyboard backlight and rework DT
>> binding according to Rob Herrings feedback]
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>> [remove backlight subsystem support for now]
>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> So... this driver adds support for LM3532, LM3631, LM3632, LM3633,
> LM3695 and LM3697 (or it did when I signed it off).

Yes I have to pull these out of the patch.

> 
> The rest of the series does not really bring any advantages (you claim
> it may add advantages in future). It takes code out of common driver
> and duplicates it.


I disagree.  Honestly using that ideallogy all LED drivers should use the common code
as it is a wrapper around regmap and a few if statements.

The 3632 adds the proper LED flash class support coupled with proper backlight support.
The 3633 adds the proper support for LV and HV LED support.

Duplicate code that I could find is put in the common file.
This patch set adds the LED devices as all other LED devices are added in the LED directory.

> 
> Could we take this patch, get the basic support for LM3532, LM3631,
> LM3632, LM3633, LM3695 and LM3697, and then split out the drivers when
> we actually gain some advantage doing so (and also when the costs are
> clear)?

We have debated this over and over and now we have 3 different implementations
available we need to collude on which one we want to support.

Jacek I defer to you and Pavel since you are both LED maintainers.

I can support the dedicated LED drivers but I cannot support the TI LMU only implementation.

Dan

> 
> Thanks,
> 
> 								Pavel
> 
>>  drivers/leds/Kconfig             |   8 ++
>>  drivers/leds/Makefile            |   1 +
>>  drivers/leds/ti-lmu-led-common.c | 138 +++++++++++++++++++++++++++++++
>>  drivers/leds/ti-lmu-led-common.h |  54 ++++++++++++
>>  4 files changed, 201 insertions(+)
>>  create mode 100644 drivers/leds/ti-lmu-led-common.c
>>  create mode 100644 drivers/leds/ti-lmu-led-common.h
> 


-- 
------------------
Dan Murphy
