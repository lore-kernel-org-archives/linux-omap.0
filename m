From: Michael Trimarchi <michael-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Subject: Re: [PATCH 3/8] i2c: omap: fix error checking
Date: Thu, 25 Oct 2012 12:33:18 +0200
Message-ID: <5089156E.7020701@amarulasolutions.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com> <1350899218-13624-4-git-send-email-balbi@ti.com> <5087FE07.6090504@amarulasolutions.com> <20121025101010.GC21217@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121025101010.GC21217-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Shubhrajyoti Datta <shubhrajyoti-l0cyMroinI0@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi

On 10/25/2012 12:10 PM, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Oct 24, 2012 at 04:41:11PM +0200, Michael Trimarchi wrote:
>> Hi
>>
>> On 10/22/2012 11:46 AM, Felipe Balbi wrote:
>>> It's impossible to have Arbitration Lost,
>>> Read Overflow, and Tranmist Underflow all
>>> asserted at the same time.
>>>
>>> Those error conditions are mutually exclusive
>>> so what the code should be doing, instead, is
>>> check each error flag separataly.
>>>
>>> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>> ---
>>>  drivers/i2c/busses/i2c-omap.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>>> index bea0277..e0eab38 100644
>>> --- a/drivers/i2c/busses/i2c-omap.c
>>> +++ b/drivers/i2c/busses/i2c-omap.c
>>> @@ -587,9 +587,9 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
>>>  		goto err_i2c_init;
>>>  	}
>>>  
>>> -	/* We have an error */
>>> -	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
>>> -			    OMAP_I2C_STAT_XUDF)) {
>>> +	if ((dev->cmd_err & OMAP_I2C_STAT_AL)
>>> +			|| (dev->cmd_err & OMAP_I2C_STAT_ROVR)
>>> +			|| (dev->cmd_err & OMAP_I2C_STAT_XUDF)) {
>>
>> Sorry, what is the difference? I didn't understand the optimisation
>> and why now is more clear. Can you just add a comment?
> 
> semantically they're not the same, right ? We want to check if each of
> those bits are set, not if all of them are set together.
> 
> my 2 cents.

You are doing the same thing, but of course is better with just one *if* as before . A general rule is: when you have logic expression you can use undefined states to simplify the logic. 

Michael 
