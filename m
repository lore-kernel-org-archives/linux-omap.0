From: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH][RFC] OMAP4: I2C : I2C context save
Date: Tue, 05 Jul 2011 11:31:23 -0700
Message-ID: <87y60cr344.fsf@ti.com>
References: <1308559552-24028-1-git-send-email-shubhrajyoti@ti.com>
	<87ips08qis.fsf@ti.com> <4DFF6A9E.5050209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4DFF6A9E.5050209-l0cyMroinI0@public.gmane.org> (shubhrajyoti-l0cyMroinI0@public.gmane.org's message of "Mon,
	20 Jun 2011 21:13:26 +0530")
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org> writes:

> On Monday 20 June 2011 09:05 PM, Kevin Hilman wrote:
>> shubhrajyoti-l0cyMroinI0@public.gmane.org writes:
>>
>>> From: Shubhrajyoti D<shubhrajyoti-l0cyMroinI0@public.gmane.org>
>>>
>>> Currently the OMAP4 doesnot hit device off still the
>>> driver may have support for it.Adding support for the
>>> same.
>>>
>>> Signed-off-by: Shubhrajyoti D<shubhrajyoti-l0cyMroinI0@public.gmane.org>
>> Please Cc linux-omap as this change to the hwmod data would go through
>> Tony.
> Yes , missed out.
>> Also, please describe why this hwmod data change affects the problem
>> described in the changelog.
>>
> After Andy's patch set
> <code snippet>
> static void omap_i2c_unidle(struct omap_i2c_dev *dev)
> {
> <snip>
>
>         pm_runtime_get_sync(&pdev->dev);
>
>         if (pdata->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
>                 omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>                 omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
>                 omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
>                 omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
>                 omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
>                 omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, dev->syscstate);
>                 omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
>                 omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
>         }
>         dev->idle = 0;
>
> This is dependent on the flag, I am making it true for OMAP4 also.

What I meant was: please describe this in the changelog.  Without more
detail, the hwmod change itself is not understandable.

Kevin
