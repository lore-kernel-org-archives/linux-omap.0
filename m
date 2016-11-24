From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2 4/5] arm: dts: am57xx-beagle-x15-common: Add overide
 powerhold property
Date: Thu, 24 Nov 2016 09:15:01 +0530
Message-ID: <07fe0118-d3c0-2d47-0642-ae90624c0ed0@ti.com>
References: <1478754560-27923-1-git-send-email-j-keerthy@ti.com>
 <1478754560-27923-5-git-send-email-j-keerthy@ti.com>
 <20161115000849.GD4082@atomide.com>
 <6ac3b28e-4891-83bc-a2f7-c903541acc18@ti.com>
 <20161123083327.GM10134@dell.home>
 <3a05871c-0512-8a84-4ac3-889c661c8638@ti.com>
 <20161123160841.GG4082@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20161123160841.GG4082@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On Wednesday 23 November 2016 09:38 PM, Tony Lindgren wrote:
> * Keerthy <j-keerthy@ti.com> [161123 00:33]:
>> On Wednesday 23 November 2016 02:03 PM, Lee Jones wrote:
>>> On Wed, 23 Nov 2016, Keerthy wrote:
>>>> On Tuesday 15 November 2016 05:38 AM, Tony Lindgren wrote:
>>>>> * Keerthy <j-keerthy@ti.com> [161109 21:10]:
>>>>>> The PMICs have POWERHOLD set by default which prevents PMIC shutdown
>>>>>> even on DEV_CTRL On bit set to 0 as the Powerhold has higher priority.
>>>>>> So to enable pmic power off this property lets one over ride the default
>>>>>> value and enable pmic power off.
>>>>>
>>>>> This should not cause merge conflicts so probably best to merge along
>>>>> with the driver changes:
>>>>>
>>>>> Acked-by: Tony Lindgren <tony@atomide.com>
>>>>>
>>>>> If you guys want me to pick up this separately let me know.
>>>>
>>>> Hi Lee Jones,
>>>>
>>>> Are you planning to pull DT and Documentation patches as well?
>>>
>>> No need.  They can be safely applied to their own subsystems.
>>
>> Okay. Thanks for the response.
>>
>> Tony,
>>
>> Hope you can pull the DT patches.
>
> Applying both into omap-for-v4.10/dt thanks. Please send dts changes
> seprately next time if there are no dependencies. This leaves out
> the second guessing who should apply what.

Sure Tony.

>
> Regards,
>
> Tony
>
