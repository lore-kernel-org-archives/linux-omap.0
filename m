From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v1 2/5] extcon: Return -EPROBE_DEFER when extcon device
 is not found
Date: Wed, 14 Nov 2018 08:52:35 +0900
Message-ID: <5BEB63C3.1020504@samsung.com>
References: <20181110181101.24557-1-andriy.shevchenko@linux.intel.com>
        <CGME20181110181155epcas2p1ac9bffb2dc7dd6337db5c37f8a87bd5e@epcas2p1.samsung.com>
        <20181110181101.24557-2-andriy.shevchenko@linux.intel.com>
        <5BE8C821.5080002@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <5BE8C821.5080002@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Roger Quadros <rogerq@ti.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Sebastian Reichel <sre@kernel.org>, linux-omap@vger.kernel.org, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-omap@vger.kernel.org

Hi Andy,

I was thinking about again to change from NULL to EPROBE_DEFER.

extcon_get_extcon_dev() function was almost called in the probe function.
But, this function might be called on other position instead of probe.

ENODEV is more correct error instead of EPROBE_DEFER.

Sorry. I'll withdraw my opinion related acked-by tag until we are clarifying it.

On 2018년 11월 12일 09:24, Chanwoo Choi wrote:
> Hi Andy,
> 
> On 2018년 11월 11일 03:10, Andy Shevchenko wrote:
>> All current users of extcon_get_extcon_dev() API considers
>> an extcon device a mandatory to appear. Thus, they all convert
>> NULL pointer to -EPROBE_DEFER error code.
>>
>> There is one more caller anticipated with the same requirements.
>>
>> To decrease a code duplication and a burden to the callers,
>> return -EPROBE_DEFER directly from extcon_get_extcon_dev().
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> ---
>>  drivers/extcon/extcon-axp288.c        | 4 ++--
>>  drivers/extcon/extcon.c               | 2 +-
>>  drivers/power/supply/axp288_charger.c | 8 ++++----
>>  drivers/usb/phy/phy-omap-otg.c        | 6 +++---
>>  drivers/usb/typec/tcpm/fusb302.c      | 4 ++--
>>  5 files changed, 12 insertions(+), 12 deletions(-)
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
> Best Regards,
> Chanwoo Choi
> 
>>
>> diff --git a/drivers/extcon/extcon-axp288.c b/drivers/extcon/extcon-axp288.c
>> index a983708b77a6..3472d3b756ed 100644
>> --- a/drivers/extcon/extcon-axp288.c
>> +++ b/drivers/extcon/extcon-axp288.c
>> @@ -360,8 +360,8 @@ static int axp288_extcon_probe(struct platform_device *pdev)
>>  		name = acpi_dev_get_first_match_name("INT3496", NULL, -1);
>>  		if (name) {
>>  			info->id_extcon = extcon_get_extcon_dev(name);
>> -			if (!info->id_extcon)
>> -				return -EPROBE_DEFER;
>> +			if (IS_ERR(info->id_extcon))
>> +				return PTR_ERR(info->id_extcon);
>>  
>>  			dev_info(dev, "controlling USB role\n");
>>  		} else {
>> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
>> index 5ab0498be652..2bd0f2f33f05 100644
>> --- a/drivers/extcon/extcon.c
>> +++ b/drivers/extcon/extcon.c
>> @@ -884,7 +884,7 @@ struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>>  		if (!strcmp(sd->name, extcon_name))
>>  			goto out;
>>  	}
>> -	sd = NULL;
>> +	sd = ERR_PTR(-EPROBE_DEFER);


(snip)

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
