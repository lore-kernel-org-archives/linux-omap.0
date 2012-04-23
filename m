From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv8 07/10] I2C: OMAP: Handle error check for pm runtime
Date: Mon, 23 Apr 2012 22:56:44 +0530
Message-ID: <4F9590D4.7070304@ti.com>
References: <1334842101-20670-1-git-send-email-shubhrajyoti@ti.com> <1334842101-20670-8-git-send-email-shubhrajyoti@ti.com> <20120423162008.GB27321@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:45991 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753549Ab2DWR0x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Apr 2012 13:26:53 -0400
Received: by pbcwz12 with SMTP id wz12so4379612pbc.30
        for <linux-omap@vger.kernel.org>; Mon, 23 Apr 2012 10:26:51 -0700 (PDT)
In-Reply-To: <20120423162008.GB27321@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com


On Monday 23 April 2012 09:50 PM, Wolfram Sang wrote:
> On Thu, Apr 19, 2012 at 06:58:18PM +0530, Shubhrajyoti D wrote:
>> If PM runtime get_sync fails return with the error
>> so that no further reads/writes goes through the interface.
>> This will avoid possible abort. Add a error message in case
>> of failure with the cause of the failure.
> I don't think the error message is especially helpful. You also use different
> string (probably typo).
Will correct and resend
>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>>  drivers/i2c/busses/i2c-omap.c |   19 ++++++++++++++++---
>>  1 files changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index 44e8cfa..d555dcd 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -585,7 +585,11 @@ omap_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
>>  	int i;
>>  	int r;
>>  
>> -	pm_runtime_get_sync(dev->dev);
>> +	r = pm_runtime_get_sync(dev->dev);
>> +	if (r < 0) {
>> +		dev_err(dev->dev, "pm_runtime_get_sync failed %d\n", r);
>> +		return r;
>> +	}
>>  
>>  	r = omap_i2c_wait_for_bb(dev);
>>  	if (r < 0)
>> @@ -1011,7 +1015,11 @@ omap_i2c_probe(struct platform_device *pdev)
>>  		dev->regs = (u8 *)reg_map_ip_v1;
>>  
>>  	pm_runtime_enable(dev->dev);
>> -	pm_runtime_get_sync(dev->dev);
>> +	r = pm_runtime_get_sync(dev->dev);
>> +	if (r < 0) {
>> +		dev_err(dev->dev, "pm_runtime_get_sync failed:%d\n", r);
>> +		return r;
>> +	}
> Smatch says:
>
> drivers/i2c/busses/i2c-omap.c:1021 omap_i2c_probe() warn: 'mem->start' was not released on error
>
> In fact, you are leaking quite more.
Ops  will correct, thanks.
>
>> @@ -1103,12 +1111,17 @@ omap_i2c_remove(struct platform_device *pdev)
>>  {
>>  	struct omap_i2c_dev	*dev = platform_get_drvdata(pdev);
>>  	struct resource		*mem;
>> +	int ret;
>>  
>>  	platform_set_drvdata(pdev, NULL);
>>  
>>  	free_irq(dev->irq, dev);
>>  	i2c_del_adapter(&dev->adapter);
>> -	pm_runtime_get_sync(&pdev->dev);
>> +	ret = pm_runtime_get_sync(&pdev->dev);
>> +	if (ret < 0) {
>> +		dev_err(dev->dev, "pm_runtime_get_sync failed %d\n", ret);
>> +		return ret;
>> +	}
> I am no too familiar with runtime_pm. Is it really so bad to fail remove, when
> get_sync has an error? Why is it checked and e.g. pm_runtime_put later is not?
> Any pointers?
If the get_sync fails the clock were not enabled so checking to prevent
register access.
>
>>  	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
>>  	pm_runtime_put(&pdev->dev);
>>  	pm_runtime_disable(&pdev->dev);
>> -- 
>> 1.7.5.4
>>
> Thanks,
>
>    Wolfram
>

