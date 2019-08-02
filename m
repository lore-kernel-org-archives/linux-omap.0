From: David Lechner <david@lechnology.com>
Subject: Re: [PATCH 2/4] counter: new TI eQEP driver
Date: Fri, 2 Aug 2019 11:09:13 -0500
Message-ID: <f45ec1f4-6463-12d9-9459-35fe7b46671a@lechnology.com>
References: <20190722154538.5314-1-david@lechnology.com>
 <20190722154538.5314-3-david@lechnology.com> <20190802092727.GB30522@icarus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190802092727.GB30522@icarus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Thierry Reding <thierry.reding@gmail.com>, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-omap@vger.kernel.org

On 8/2/19 4:27 AM, William Breathitt Gray wrote:
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index a7e57516959e..ddcbb8573894 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -499,7 +499,7 @@ config  PWM_TIEHRPWM
>>   
>>   config  PWM_TIPWMSS
>>   	bool
>> -	default y if (ARCH_OMAP2PLUS) && (PWM_TIECAP || PWM_TIEHRPWM)
>> +	default y if (ARCH_OMAP2PLUS) && (PWM_TIECAP || PWM_TIEHRPWM || TI_EQEP)
>>   	help
>>   	  PWM Subsystem driver support for AM33xx SOC.
> I was surprised to see this pwm Kconfig change in this patch. Is
> PWM_TIPWMSS required for TI_EQEP to work? If not required, then this
> could be a separate patch; otherwise, put in a mention about why in the
> commit message so that the purpose of this change is clearer.
> 

This enables the parent bus for power management. Since this is the second
comment about this, I wonder if it would make sense to move this out of the
PWM subsystem and into drivers/bus/ since it is no longer exclusive to PWM
devices.
