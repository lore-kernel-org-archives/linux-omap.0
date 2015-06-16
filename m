From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 1/1] add pwm capability to dm816x
Date: Tue, 16 Jun 2015 15:56:54 -0500
Message-ID: <55808D96.4000705@ti.com>
References: <CAFZh4h8ikia8oKsZ6B12QZ1HdTV8Teu-+U9x_Ydu_-uOyh7-HA@mail.gmail.com> <557F286B.6010003@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42234 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbbFPU5D (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jun 2015 16:57:03 -0400
In-Reply-To: <557F286B.6010003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kristo, Tero" <t-kristo@ti.com>, Brian Hutchinson <b.hutchman@gmail.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Brian,

On 06/15/2015 02:32 PM, Kristo, Tero wrote:
> On 06/15/2015 09:36 PM, Brian Hutchinson wrote:
>> Clocks 4-7 are capable of PWM output on dm816x.
>>
>> This adds the pwm capability to those timers.
> 
> Use checkpatch pls, I see lots of whitespace errors.
> 
> Also, I don't think Mike / Stephen care about this patch, as it is 
> against omap hwmod data only.

The capabilities should be added to the DT nodes, not to the hwmods.
The hwmod timer capabilities are needed only for non-DT SoCs, and dm816x
is DT boot only.

regards
Suman

> 
> -Tero
> 
>>
>> Cc: Paul Walmsley <paul@pwsan.com <mailto:paul@pwsan.com>>
>> Cc: Tero Kristo <t-kristo@ti.com <mailto:t-kristo@ti.com>>
>> Cc: Tony Lindgren <tony@atomide.com <mailto:tony@atomide.com>>
>> Signed-off-by: Brian Hutchinson <b.hutchman@gmail.com
>> <mailto:b.hutchman@gmail.com><mailto:tony@atomide.com>>
>>
>> --- arch/arm/mach-omap2/omap_hwmod_81xx_data.c_orig     2015-06-15
>> 13:20:43.174343431 -0400
>> +++ arch/arm/mach-omap2/omap_hwmod_81xx_data.c  2015-06-15
>> 13:34:51.770551392 -0400
>> @@ -546,6 +546,14 @@ static struct omap_timer_capability_dev_
>>          .timer_capability       = OMAP_TIMER_ALWON,
>>   };
>>
>> +/* pwm timers dev attribute.
>> + * timers 4-7 may be used for PWM output - see datasheet timer terminal
>> + * functions table
>> + */
>> +static struct omap_timer_capability_dev_attr capability_pwm_dev_attr = {
>> +       .timer_capability       = OMAP_TIMER_ALWON | OMAP_TIMER_HAS_PWM,
>> +};
>> +
>>   static struct omap_hwmod dm816x_timer1_hwmod = {
>>          .name           = "timer1",
>>          .clkdm_name     = "alwon_l3s_clkdm",
>> @@ -619,7 +627,7 @@ static struct omap_hwmod dm816x_timer4_h
>>                          .modulemode = MODULEMODE_SWCTRL,
>>                  },
>>          },
>> -       .dev_attr       = &capability_alwon_dev_attr,
>> +       .dev_attr       = &capability_pwm_dev_attr,
>>          .class          = &dm816x_timer_hwmod_class,
>>   };
>>
>> @@ -640,7 +648,7 @@ static struct omap_hwmod dm816x_timer5_h
>>                          .modulemode = MODULEMODE_SWCTRL,
>>                  },
>>          },
>> -       .dev_attr       = &capability_alwon_dev_attr,
>> +       .dev_attr       = &capability_pwm_dev_attr,
>>          .class          = &dm816x_timer_hwmod_class,
>>   };
>>
>> @@ -661,7 +669,7 @@ static struct omap_hwmod dm816x_timer6_h
>>                          .modulemode = MODULEMODE_SWCTRL,
>>                  },
>>          },
>> -       .dev_attr       = &capability_alwon_dev_attr,
>> +       .dev_attr       = &capability_pwm_dev_attr,
>>          .class          = &dm816x_timer_hwmod_class,
>>   };
>>
>> @@ -682,7 +690,7 @@ static struct omap_hwmod dm816x_timer7_h
>>                          .modulemode = MODULEMODE_SWCTRL,
>>                  },
>>          },
>> -       .dev_attr       = &capability_alwon_dev_attr,
>> +       .dev_attr       = &capability_pwm_dev_attr,
>>          .class          = &dm816x_timer_hwmod_class,
>>   };
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

