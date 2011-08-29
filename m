From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv6 1/3] OMAP: I2C: Reset support
Date: Mon, 29 Aug 2011 15:01:54 +0530
Message-ID: <4E5B5C8A.8090800@ti.com>
References: <1312524035-5549-1-git-send-email-shubhrajyoti@ti.com> <87bovbzsay.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:37084 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753358Ab1H2JcE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 05:32:04 -0400
In-Reply-To: <87bovbzsay.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, balajitk@ti.com, santosh.shilimkar@ti.com

On Saturday 27 August 2011 04:36 AM, Kevin Hilman wrote:
> Shubhrajyoti D<shubhrajyoti@ti.com>  writes:
>
>> Under some error conditions the i2c driver may do a reset.
>> Adding a reset field and support in the device-specific code.
>>
>> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
> Needs update/rebase to apply against my for_3.2/i2c-cleanup branch...
>
> [...]
Will rebase and send.
>> diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
>> index 98ae49b..8aa91b6 100644
>> --- a/include/linux/i2c-omap.h
>> +++ b/include/linux/i2c-omap.h
>> @@ -38,6 +38,7 @@ struct omap_i2c_bus_platform_data {
>>   	int		(*device_enable) (struct platform_device *pdev);
>>   	int		(*device_shutdown) (struct platform_device *pdev);
>>   	int		(*device_idle) (struct platform_device *pdev);
> The above functions no longer exist in the platform_data struct.
>
>> +	int		(*device_reset) (struct device *dev);
>>   };
>>
>>   #endif
> Kevin

