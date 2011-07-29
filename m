From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHV2 3/5] OMAP: I2C: Remove the reset in the init path
Date: Fri, 29 Jul 2011 16:57:44 +0530
Message-ID: <4E329930.4040301@ti.com>
References: <1311246554-22975-1-git-send-email-shubhrajyoti@ti.com> <1311246554-22975-4-git-send-email-shubhrajyoti@ti.com> <4E280D0B.1040701@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:51084 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932106Ab1G2L1y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jul 2011 07:27:54 -0400
In-Reply-To: <4E280D0B.1040701@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, rnayak@ti.com, balajitk@ti.com

On Thursday 21 July 2011 04:57 PM, Santosh Shilimkar wrote:
Thanks for your review.
> On 7/21/2011 4:39 PM, Shubhrajyoti D wrote:
>
<snip>
>> +        /*
>> +         * Enabling all wakup sources to stop I2C freezing on
>> +         * WFI instruction.
>> +         * REVISIT: Some wkup sources might not be needed.
>> +         */
> Surely not related to your patch. But the 'REVISIT:' caught
> my attention. Is the comment still valid.

Yes I will look and optimise the settings. Obviously all of them may not 
be needed.
Will get back on this.

Also I see that we are not writing it for " < OMAP_I2C_REV_ON_3530_4430"
I will send a patch correcting the same.

>
>> +        dev->westate = OMAP_I2C_WE_ALL;
>> +        if (dev->rev<  OMAP_I2C_REV_ON_3530_4430)
> Space if (dev->rev <  OMAP_I2C_REV_ON_3530_4430)
>> +            omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
>> +                            dev->westate);
>>       }
>>       omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>>
>> @@ -612,6 +572,11 @@ static int omap_i2c_xfer_msg(struct i2c_adapter 
>> *adap,
>>           return r;
>>       if (r == 0) {
>>           dev_err(dev->dev, "controller timed out\n");
>> +        if (dev->device_reset != NULL) {
>> +            r = dev->device_reset(dev->dev);
>> +            if (r<  0)
> ditto
>> +                dev_err(dev->dev, "reset failed\n");
>> +        }
>>           omap_i2c_init(dev);
>>           return -ETIMEDOUT;
>>       }
>> @@ -622,6 +587,11 @@ static int omap_i2c_xfer_msg(struct i2c_adapter 
>> *adap,
>>       /* We have an error */
>>       if (dev->cmd_err&  (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
> You can fix this one as well.
>>                   OMAP_I2C_STAT_XUDF)) {
>> +        if (dev->device_reset != NULL) {
>> +            r = dev->device_reset(dev->dev);
>> +            if (r<  0)
> here too.
>> +                dev_err(dev->dev, "reset failed\n");
>> +        }
>>           omap_i2c_init(dev);
>>           return -EIO;
>>       }
>> @@ -1024,6 +994,7 @@ omap_i2c_probe(struct platform_device *pdev)
>>       if (pdata != NULL) {
>>           speed = pdata->clkrate;
>>           dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
>> +        dev->device_reset = pdata->device_reset;
>>       } else {
>>           speed = 100;    /* Default speed */
>>           dev->set_mpu_wkup_lat = NULL;
>
> Regards
> Santosh

