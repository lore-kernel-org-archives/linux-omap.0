From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: TWL6040 fails to initialize
Date: Wed, 26 Feb 2014 10:53:02 +0100
Message-ID: <530DB97E.80309@epfl.ch>
References: <530C70B3.4010103@epfl.ch> <530CA8DA.8050806@ti.com> <530CB9C6.60806@epfl.ch> <530D972F.805@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:37965 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbaBZJxO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Feb 2014 04:53:14 -0500
In-Reply-To: <530D972F.805@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, =?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?= <philippe.retornaz@epfl.ch>

Hi,

First, thanks for your help.

On 02/26/2014 08:26 AM, Peter Ujfalusi wrote:
> On 02/25/2014 05:41 PM, Florian Vaussard wrote:
>> If the power was not enabled at all, I would be unable to read the
>> revision register, no? And delaying the probe by one millisecond would
>> be of no help in this case IMHO.
> 
> One thing which might cause this is that if the audpwron GPIO is set high
> before the twl6040 module is probing. When I request the GPIO I ask it to be
> set to low. If the line was high before this means we initiate the power off
> sequence.
> Can you try something like this:
> 

I statistically checked that the sleep should be placed after the GPIO
request, so indeed this seems to be the problem, and your explanation is
plausible. Can you send a proper patch?

Now, related to this, I managed to found a part of the datasheet on the
Great Internet. Looking at the "Power-Up Sequence" section, it is written:

- NRESPWRON goes high -> plug detect and GPO are available
- V2V1 goes high -> hook-detect available by I2C programming (sleep mode)
- AUDPWRON goes high && READYINT -> ready to communicate through I2C and PDM

So, although there seems to be some contradictions on when it is
possible to access the I2C, shouldn't we enable the AUDPWRON GPIO
_before_ making any I2C access?

For the twl6040_probe, the following path would seem more correct to me:

1) enable regulators
2) request AUDPWRON
3) twl6040_power(ON) && regcache_cache_only(false)
4) wait for READYINT (or sleep if deterministic)
5) perform all required I2C accesses (read revision, etc.)
6) twl6040_power(OFF) && regcache_cache_only(true)

What do you think?

Thanks,
Florian

> diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
> index 75316fb33448..d2a0bd1539ae 100644
> --- a/drivers/mfd/twl6040.c
> +++ b/drivers/mfd/twl6040.c
> @@ -674,6 +674,9 @@ static int twl6040_probe(struct i2c_client *client,
>                                             GPIOF_OUT_INIT_LOW, "audpwron");
>                 if (ret)
>                         goto gpio_err;
> +
> +               /* power-down sequence latency */
> +               usleep_range(500, 700);
>         }
> 
>         ret = regmap_add_irq_chip(twl6040->regmap, twl6040->irq, IRQF_ONESHOT,
> 
> 
