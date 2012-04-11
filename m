From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv7 11/18] I2C: OMAP: use devm_* functions
Date: Wed, 11 Apr 2012 17:26:26 +0530
Message-ID: <4F85716A.4030308@ti.com>
References: <1334142776-10583-1-git-send-email-shubhrajyoti@ti.com> <1334142776-10583-12-git-send-email-shubhrajyoti@ti.com> <20120411113456.GF12064@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:54542 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758105Ab2DKL4d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Apr 2012 07:56:33 -0400
Received: by obbuo13 with SMTP id uo13so1212195obb.6
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 04:56:31 -0700 (PDT)
In-Reply-To: <20120411113456.GF12064@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de

On Wednesday 11 April 2012 05:04 PM, Felipe Balbi wrote:
> On Wed, Apr 11, 2012 at 04:42:49PM +0530, Shubhrajyoti D wrote:
>> The various devm_ functions allocate memory that is released when a driver
>> detaches. This patch uses devm_kzalloc, devm_request_mem_region and
>> devm_ioremap for data that is allocated in the probe function of a platform
>> device and is only freed in the remove function.
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>>  drivers/i2c/busses/i2c-omap.c |   29 +++++++++--------------------
>>  1 files changed, 9 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
>> index 121c52e..86be475 100644
>> --- a/drivers/i2c/busses/i2c-omap.c
>> +++ b/drivers/i2c/busses/i2c-omap.c
>> @@ -995,17 +995,17 @@ omap_i2c_probe(struct platform_device *pdev)
>>  		return -ENODEV;
>>  	}
>>  
>> -	ioarea = request_mem_region(mem->start, resource_size(mem),
>> -			pdev->name);
>> +	ioarea = devm_request_mem_region(&pdev->dev, mem->start,
>> +			resource_size(mem), pdev->name);
> you could use devm_request_and_ioremap()
OK will do that.

thanks,

