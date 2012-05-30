From: Xiao Jiang <jgq516@gmail.com>
Subject: Re: [PATCH 3/3] watchdog: omap_wdt: add device tree support
Date: Wed, 30 May 2012 11:18:09 +0800
Message-ID: <4FC59171.8040009@gmail.com>
References: <1337942552-28218-1-git-send-email-jgq516@gmail.com> <1337942552-28218-4-git-send-email-jgq516@gmail.com> <4FC51008.1050004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FC51008.1050004@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux@arm.linux.org.uk, b-cousson@ti.com, rob.herring@calxeda.com, grant.likely@secretlab.ca, rnayak@ti.com, tony@atomide.com, wim@iguana.be, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Jon Hunter wrote:
> On 05/25/2012 05:42 AM, jgq516@gmail.com wrote:
>   
>> From: Xiao Jiang <jgq516@gmail.com>
>>
>> Add device table for omap_wdt to support dt.
>>
>> Signed-off-by: Xiao Jiang <jgq516@gmail.com>
>> ---
>>  drivers/watchdog/omap_wdt.c |    8 ++++++++
>>  1 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
>> index 8285d65..d98c615 100644
>> --- a/drivers/watchdog/omap_wdt.c
>> +++ b/drivers/watchdog/omap_wdt.c
>> @@ -430,6 +430,13 @@ static int omap_wdt_resume(struct platform_device *pdev)
>>  #define	omap_wdt_resume		NULL
>>  #endif
>>  
>> +static const struct of_device_id omap_wdt_of_match[] = {
>> +	{ .compatible = "ti,omap3-wdt", },
>> +	{ .compatible = "ti,omap4-wdt", },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, omap_wdt_of_match);
>> +
>>  static struct platform_driver omap_wdt_driver = {
>>  	.probe		= omap_wdt_probe,
>>  	.remove		= __devexit_p(omap_wdt_remove),
>> @@ -439,6 +446,7 @@ static struct platform_driver omap_wdt_driver = {
>>  	.driver		= {
>>  		.owner	= THIS_MODULE,
>>  		.name	= "omap_wdt",
>> +		.of_match_table = omap_wdt_of_match,
>>  	},
>>  };
>>  
>>     
>
> I think we need to add some code to the probe function that calls
> of_match_device() and ensures we find a match. For example ...
>
> 	if (of_have_populated_dt())
> 		if (!of_match_device(omap_wdt_of_match, &pdev->dev))
> 			return -EINVAL;
>
>   
Will add it in v2, thanks for suggestion.

Regards,
Xiao
> Cheers
> Jon
>   
