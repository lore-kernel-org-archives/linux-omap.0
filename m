From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 1/2] omap i2c: make errata 1.153 workaround a separate
 function
Date: Thu, 17 Dec 2009 18:48:24 +0530
Message-ID: <4B2A2FA0.6080804@ti.com>
References: <1260972144-31593-1-git-send-email-virtuoso@slind.org> <1260972144-31593-2-git-send-email-virtuoso@slind.org> <4B29A036.2040807@ti.com> <20091217124843.GB29059@shisha.kicks-ass.net>
Reply-To: <nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46412 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764629AbZLQNSj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Dec 2009 08:18:39 -0500
In-Reply-To: <20091217124843.GB29059@shisha.kicks-ass.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

Alexander Shishkin said the following on 12/17/2009 06:18 PM:
> On Thu, Dec 17, 2009 at 08:36:30 +0530, Menon, Nishanth wrote:
>   
>> Alexander Shishkin said the following on 12/16/2009 07:32 PM:
>>     
>>> This is to avoid insanely long lines and levels of indentation.
>>>
>>> Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
>>> CC: linux-i2c@vger.kernel.org
>>> CC: linux-omap@vger.kernel.org
>>> ---
>>> drivers/i2c/busses/i2c-omap.c |   43 ++++++++++++++++++++++------------------
>>> 1 files changed, 24 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>>> index 75bf3ad..ad8242a 100644
>>> --- a/drivers/i2c/busses/i2c-omap.c
>>> +++ b/drivers/i2c/busses/i2c-omap.c
>>> @@ -671,6 +671,27 @@ omap_i2c_rev1_isr(int this_irq, void *dev_id)
>>> #define omap_i2c_rev1_isr		NULL
>>> #endif
>>> +/*
>>> + * OMAP3430 Errata 1.153: When an XRDY/XDR is hit, wait for XUDF before writing
>>> + * data to DATA_REG. Otherwise some data bytes can be lost while transferring
>>> + * them from the memory to the I2C interface.
>>> + */
>>> +static int omap3430_workaround(struct omap_i2c_dev *dev, u16 *stat, int *err)
>>>       
>> note, though this is identified as being part of 3430, it is not
>> really restricted to 3430 alone
>> we might want to rename this as errata_omap3_1p153() perhaps?
>>     
>
> Ok, I don't see why not.
>   
Thanks..
>   
>>> +{
>>> +	while (!(*stat & OMAP_I2C_STAT_XUDF)) {
>>> +		if (*stat & (OMAP_I2C_STAT_NACK | OMAP_I2C_STAT_AL)) {
>>> +			omap_i2c_ack_stat(dev, *stat & (OMAP_I2C_STAT_XRDY |
>>> +							OMAP_I2C_STAT_XDR));
>>> +			*err |= OMAP_I2C_STAT_XUDF;
>>> +			return -1;
>>> +		}
>>> +		cpu_relax();
>>> +		*stat = omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>>       
>> wonder if using an inline might help throw away the function call
>> overhead (considering it is used only once)?
>>     
>
> objdump -S says it's implicitly inlined already. I actually had in mind
> the conversation about generalizing the features/erratas for chips/IPs
> and that somehow stopped me from explicitly inlining this. Do you think
> it makes sense (for the next version of this patchset) to explicitly
> inline this?
>   
I guess that might allow folks to realize that without objdump -S ;)
[...]

regards,
Nishanth Menon
