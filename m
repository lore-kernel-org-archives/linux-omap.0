From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 08/14] ARM: OMAP2: Add functions to save and restore
 pinctrl context.
Date: Fri, 13 Apr 2018 11:46:04 +0530
Message-ID: <26b80d50-efe1-196a-85b0-4ab22f9bda1c@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
 <1523505239-16229-9-git-send-email-j-keerthy@ti.com>
 <20180412141639.GV5700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180412141639.GV5700@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linus.walleij@linaro.org, grygorii.strashko@ti.com, t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com, Russ Dill <Russ.Dill@gmail.com>
List-Id: linux-omap@vger.kernel.org



On Thursday 12 April 2018 07:46 PM, Tony Lindgren wrote:
> Hi,
> 
> * Keerthy <j-keerthy@ti.com> [180412 03:56]:
>> From: Russ Dill <Russ.Dill@gmail.com>
>>
>> This adds a pair of context save/restore functions to save/restore the
>> state of a set of pinctrl registers. This simplifies some of the AM33XX
>> PM code as some of the pinctrl registers are lost when the per power
>> domain loses power. The pincrtl code can perform the necessary
>> save/restore.
> 
> So where's the patch adding callers to this code?

This series was to get all the additional save/restores needed for the
rtc+ddr mode. Caller patch is in the main patch that implements that
mode that i will be posting once the ground is set.

Based on enable_off_mode being set this function was called only for
rtc+ddr mode.

> 
> If this cannot be done from regular driver suspend/resume calls,
> this probably should be done from cpu_pm notifiers CPU_PM_ENTER and
> CPU_PM_EXIT. We should also do the same for GPIO BTW.

I will look into that. Thanks for suggestion.

> 
> BTW, the subject line is wrong here, it should be "pinctrl" :)

Oops yes that should be pinctrl.

> 
> Regards,
> 
> Tony
> 
