From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv8 06/13] I2C: OMAP: Correct I2C revision for OMAP3
Date: Wed, 20 Jun 2012 18:31:32 +0530
Message-ID: <4FE1C9AC.3020104@ti.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com> <1340029828-20751-7-git-send-email-shubhrajyoti@ti.com> <20120620103235.GD12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog136.obsmtp.com ([74.125.149.85]:48999 "EHLO
	na3sys009aog136.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753360Ab2FTNBj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jun 2012 09:01:39 -0400
Received: by obbtb18 with SMTP id tb18so11652636obb.33
        for <linux-omap@vger.kernel.org>; Wed, 20 Jun 2012 06:01:38 -0700 (PDT)
In-Reply-To: <20120620103235.GD12766@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, w.sang@pengutronix.de, Jon Hunter <jon-hunter@ti.com>

On Wednesday 20 June 2012 04:02 PM, Tony Lindgren wrote:
> * Shubhrajyoti D <shubhrajyoti@ti.com> [120618 07:35]:
>> From: Jon Hunter <jon-hunter@ti.com>
>>
>> The OMAP3530 is based upon the same silicon as the OMAP3430 and so the I2C
>> revision is the same for 3430 and 3530. However, the OMAP3630 device has the
>> same I2C revision as OMAP4. Correct the revision definition to reflect this.
>>
>> This patch is based on work done by Jon Hunter <jon-hunter@ti.com>
>> Changes from his patch
>> - Update OMAP_I2C_REV_ON_3430 also to reflect that it is same as 3530
> ...
>>  /* timeout waiting for the controller to respond */
>>  #define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
>> @@ -298,7 +298,7 @@ static int omap_i2c_reset(struct omap_i2c_dev *dev)
>>  			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
>>  					   SYSC_AUTOIDLE_MASK);
>>  
>> -		} else if (dev->rev >= OMAP_I2C_REV_ON_3430) {
>> +		} else if (dev->rev >= OMAP_I2C_REV_ON_3430_3530) {
>>  			dev->syscstate = SYSC_AUTOIDLE_MASK;
>>  			dev->syscstate |= SYSC_ENAWAKEUP_MASK;
>>  			dev->syscstate |= (SYSC_IDLEMODE_SMART <<
> Having to patch all over the place for these revision defines leads
> into unmaintainable code as new SoCs get added.
>
> Please instead just check the revision once during init, then set
> up some feature bits like I2C_OMAP_NEEDS_XYZ_RESET that the runtime
> code can check.
Even now at probe

dev->rev is set by reading the rev register.

The (macro)name used to identify is only changed.

Also all the ips need reset the difference is that 2430 has less bits eg only autoidle and reset.
So a flag needs reset may not be meaningful.



>
>
>> @@ -1055,7 +1055,7 @@ omap_i2c_probe(struct platform_device *pdev)
>>  	if (dev->flags & OMAP_I2C_FLAG_APPLY_ERRATA_I207)
>>  		dev->errata |= I2C_OMAP_ERRATA_I207;
>>  
>> -	if (dev->rev <= OMAP_I2C_REV_ON_3430)
>> +	if (dev->rev <= OMAP_I2C_REV_ON_3430_3530)
>>  		dev->errata |= I2C_OMAP_ERRATA_I462;
>>  
>>  	if (!(dev->flags & OMAP_I2C_FLAG_NO_FIFO)) {
>> @@ -1073,7 +1073,7 @@ omap_i2c_probe(struct platform_device *pdev)
>>  
>>  		dev->fifo_size = (dev->fifo_size / 2);
>>  
>> -		if (dev->rev >= OMAP_I2C_REV_ON_3530_4430)
>> +		if (dev->rev >= OMAP_I2C_REV_ON_3630_4430)
>>  			dev->b_hw = 0; /* Disable hardware fixes */
>>  		else
>>  			dev->b_hw = 1; /* Enable hardware fixes */
> That way the code does not need to change when new SoC revisions
> get added.
I think it might still not need to change because of >= .
I have just renamed

OMAP_I2C_REV_ON_3530_4430 as 3530 rev is not the same as 4430 that the name implies.

>
> Tony

