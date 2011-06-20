From: Shubhrajyoti <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH][RFC] OMAP4: I2C : I2C context save
Date: Mon, 20 Jun 2011 21:13:26 +0530
Message-ID: <4DFF6A9E.5050209@ti.com>
References: <1308559552-24028-1-git-send-email-shubhrajyoti@ti.com> <87ips08qis.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87ips08qis.fsf-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, andy.green-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Monday 20 June 2011 09:05 PM, Kevin Hilman wrote:
> shubhrajyoti-l0cyMroinI0@public.gmane.org writes:
>
>> From: Shubhrajyoti D<shubhrajyoti-l0cyMroinI0@public.gmane.org>
>>
>> Currently the OMAP4 doesnot hit device off still the
>> driver may have support for it.Adding support for the
>> same.
>>
>> Signed-off-by: Shubhrajyoti D<shubhrajyoti-l0cyMroinI0@public.gmane.org>
> Please Cc linux-omap as this change to the hwmod data would go through
> Tony.
Yes , missed out.
> Also, please describe why this hwmod data change affects the problem
> described in the changelog.
>
After Andy's patch set
<code snippet>
static void omap_i2c_unidle(struct omap_i2c_dev *dev)
{
<snip>

         pm_runtime_get_sync(&pdev->dev);

         if (pdata->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
                 omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
                 omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
                 omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
                 omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
                 omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
                 omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, dev->syscstate);
                 omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
                 omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
         }
         dev->idle = 0;

This is dependent on the flag, I am making it true for OMAP4 also.

> Kevin
>
>> ---
>> Applies on top of patches from Andy Green
>> http://www.spinics.net/lists/linux-i2c/msg05632.html
>>
>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 ++-
>>   1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> index 0fe9556..5e2c748 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -2130,7 +2130,8 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
>>   };
>>
>>   static struct omap_i2c_dev_attr i2c_dev_attr = {
>> -	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE,
>> +	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE |
>> +			OMAP_I2C_FLAG_RESET_REGS_POSTIDLE,
>>   };
>>
>>   /* i2c1 */
