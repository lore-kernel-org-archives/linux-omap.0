From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 1/2] net: can: c_can: Fix default pinmux glitch at init
Date: Wed, 8 Jul 2015 11:09:02 +0300
Message-ID: <559CDA9E.7050401@ti.com>
References: <1436279277-3386-1-git-send-email-rogerq@ti.com> <1436279277-3386-2-git-send-email-rogerq@ti.com> <559BE34F.8080508@pengutronix.de> <559BE3BE.2020608@ti.com> <559BE433.9020308@ti.com> <559BE579.2020109@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <559BE579.2020109@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com, tony@atomide.com
Cc: jay.schroeder@garmin.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Marc,

On 07/07/15 17:43, Marc Kleine-Budde wrote:
> On 07/07/2015 04:37 PM, Roger Quadros wrote:
>>>>> diff --git a/drivers/net/can/c_can/c_can.c
>>>>> b/drivers/net/can/c_can/c_can.c
>>>>> index 041525d..66e98e7 100644
>>>>> --- a/drivers/net/can/c_can/c_can.c
>>>>> +++ b/drivers/net/can/c_can/c_can.c
>>>>> @@ -605,7 +605,18 @@ static int c_can_start(struct net_device *dev)
>>>>>        priv->can.state = CAN_STATE_ERROR_ACTIVE;
>>>>>
>>>>>        /* activate pins */
>>>>> -    pinctrl_pm_select_default_state(dev->dev.parent);
>>>>> +#ifdef CONFIG_PINCTRL
>>>>
>>>> Please remove the ifdef, AFAICS there are static inline noop functions
>>>> if CONFIG_PINCTRL switched off.
>>>
>>> yes, you are right.
>>
>> On second thoughts
>>
>> device->pins are not defined if CONFIG_PINCTRL is not set.
>> so we can't remove the #ifdef.
>
> Too bad :(
>
> okay - should I add stable@v.k.o on Cc?

I'm not sure if it would help. This patch by itself won't fix anything. 
It needs to go in together with the DTS change in patch 2.

Maybe if Tony can Ack the second patch then both should be applicable
on v4.0+ for stable.

cheers,
-roger
