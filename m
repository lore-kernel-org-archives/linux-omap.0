From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH v2 1/5] Documentation: pinctrl: palmas: Add
 ti,palmas-powerhold-override property definition
Date: Mon, 28 Nov 2016 09:21:41 +0530
Message-ID: <60b58c15-0106-d402-ab63-409800b2c116@ti.com>
References: <1478754560-27923-1-git-send-email-j-keerthy@ti.com>
 <1478754560-27923-2-git-send-email-j-keerthy@ti.com>
 <20161115014352.5d3qwoonlo63mp5p@rob-hp-laptop>
 <23bf98ee-bcdc-e100-54ce-6f4b1e13ffcf@ti.com>
 <20161124084544.GS10134@dell.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20161124084544.GS10134@dell.home>
Sender: linux-gpio-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh@kernel.org>, tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org



On Thursday 24 November 2016 02:15 PM, Lee Jones wrote:
> On Thu, 24 Nov 2016, Keerthy wrote:
>
>>
>>
>> On Tuesday 15 November 2016 07:13 AM, Rob Herring wrote:
>>> On Thu, Nov 10, 2016 at 10:39:16AM +0530, Keerthy wrote:
>>>> GPIO7 is configured in POWERHOLD mode which has higher priority
>>>> over DEV_ON bit and keeps the PMIC supplies on even after the DEV_ON
>>>> bit is turned off. This property enables driver to over ride the
>>>> POWERHOLD value to GPIO7 so as to turn off the PMIC in power off
>>>> scenarios.
>>>>
>>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt | 9 +++++++++
>>>>  1 file changed, 9 insertions(+)
>>>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>
>> Tony,
>>
>> Are you planning to pick this one as well?
>
> This should be taken by LinusW.

Okay. I will post this separately.

>
