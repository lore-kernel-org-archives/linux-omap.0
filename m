From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2 4/5] arm: dts: am57xx-beagle-x15-common: Add overide
 powerhold property
Date: Wed, 23 Nov 2016 14:02:56 +0530
Message-ID: <3a05871c-0512-8a84-4ac3-889c661c8638@ti.com>
References: <1478754560-27923-1-git-send-email-j-keerthy@ti.com>
 <1478754560-27923-5-git-send-email-j-keerthy@ti.com>
 <20161115000849.GD4082@atomide.com>
 <6ac3b28e-4891-83bc-a2f7-c903541acc18@ti.com>
 <20161123083327.GM10134@dell.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20161123083327.GM10134@dell.home>
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On Wednesday 23 November 2016 02:03 PM, Lee Jones wrote:
> On Wed, 23 Nov 2016, Keerthy wrote:
>
>>
>>
>> On Tuesday 15 November 2016 05:38 AM, Tony Lindgren wrote:
>>> * Keerthy <j-keerthy@ti.com> [161109 21:10]:
>>>> The PMICs have POWERHOLD set by default which prevents PMIC shutdown
>>>> even on DEV_CTRL On bit set to 0 as the Powerhold has higher priority.
>>>> So to enable pmic power off this property lets one over ride the default
>>>> value and enable pmic power off.
>>>
>>> This should not cause merge conflicts so probably best to merge along
>>> with the driver changes:
>>>
>>> Acked-by: Tony Lindgren <tony@atomide.com>
>>>
>>> If you guys want me to pick up this separately let me know.
>>
>> Hi Lee Jones,
>>
>> Are you planning to pull DT and Documentation patches as well?
>
> No need.  They can be safely applied to their own subsystems.

Okay. Thanks for the response.

Tony,

Hope you can pull the DT patches.

>
