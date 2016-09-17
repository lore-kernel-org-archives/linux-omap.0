From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH v7 0/5] mfd: tps65218: Clean ups
Date: Sat, 17 Sep 2016 09:23:51 +0530
Message-ID: <4c5b4ca3-4594-455e-8c0b-2f6cc4e6b8e2@ti.com>
References: <1470833641-29546-1-git-send-email-j-keerthy@ti.com>
 <ab94aff0-8470-57e5-2039-12f09bb0ca33@ti.com>
 <20160916133153.GB27974@sirena.org.uk>
 <0a30f210-0a23-0899-51b0-28f200ddd0a4@ti.com>
 <20160916173620.GB10189@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160916173620.GB10189@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Keerthy <j-keerthy@ti.com>, lee.jones@linaro.org, tony@atomide.com, dmitry.torokhov@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com, devicetree@vger.kernel.org, robh+dt@kernel.org, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, t-kristo@ti.com, russ.dill@ti.com, d-gerlach@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Friday 16 September 2016 11:06 PM, Mark Brown wrote:
> On Fri, Sep 16, 2016 at 09:51:38PM +0530, Keerthy wrote:
>> On Friday 16 September 2016 07:01 PM, Mark Brown wrote:
>>> On Fri, Sep 16, 2016 at 05:12:38PM +0530, Keerthy wrote:
>
>>>> Should i repost this series? I do not see this series in linux-next yet.
>
>>> Please don't send content free pings and please allow a reasonable time
>>> for review.  People get busy, go on holiday, attend conferences and so
>
>> I should have been clearer.
>> The last Lee Jones conveyed that:
>
>> "I can't take this series yet, since it relies on a change which was
>> taken into Mark's Regulator tree"
>
>> https://lkml.org/lkml/2016/8/31/312
>
>> So wanted to check if i needed to re-base/repost this series again.
>> Sorry about the confusion i think that is because of $Subject goof up in the
>> 0th patch of the series.
>
> I'm afraid I've no real idea what this series is about or what patches
> it might depend on, sorry.  If you're waiting for me to do something
> you'll need to tell me what it is but if it's a dependency that needs
> cross merging then reposting this series isn't going to be needed.

The series cleans up mainly the regulator driver and implements
the device tree parsing using the regulator framework. Removes
all the redundant compatibles for the individual regulators.
Adds platform_device_id table for the gpio and power button modules.

This has been reviewed extensively.

Looks like v7 no longer applies directly on the linux-next branch as it 
conflicts with:

https://kernel.googlesource.com/pub/scm/linux/kernel/git/dtor/input/+/722dc54628ca5cffd3b4581b523775aa422b55df

I will rebase and repost on the current linux-next and post v8.

>
