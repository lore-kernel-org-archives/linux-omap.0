From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH 2/4] omap_dss: add FocalTech ETM070003DH6 display support
Date: Thu, 17 Nov 2011 08:52:54 +0200
Message-ID: <4EC4AF46.3080601@compulab.co.il>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com> <1320797568-11169-3-git-send-email-yanok@emcraft.com> <4EC45535.9060708@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:41025
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751674Ab1KQGxE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Nov 2011 01:53:04 -0500
In-Reply-To: <4EC45535.9060708@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Hi Ilya,

You should have CC'd Tomi and linux-fbdev - done now.

On 11/17/11 02:28, Ilya Yanok wrote:
> Hi guys,
> 
> what about this patch? Can it be applied? It's pretty independent from
> other ones.
> 
> Regards, Ilya.
> 
> On 09.11.2011 04:12, Ilya Yanok wrote:
>> Add data for the FocalTech ETM070003DH6 display to the generic_dpi_panel
>> display driver.
>>
>> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
>> ---
>>  drivers/video/omap2/displays/panel-generic-dpi.c |   24 ++++++++++++++++++++++
>>  1 files changed, 24 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
>> index 519c47d..42bfe47 100644
>> --- a/drivers/video/omap2/displays/panel-generic-dpi.c
>> +++ b/drivers/video/omap2/displays/panel-generic-dpi.c
>> @@ -297,6 +297,30 @@ static struct panel_config generic_dpi_panels[] = {
>>  
>>  		.name			= "apollon",
>>  	},
>> +	/* FocalTech ETM070003DH6 */
>> +	{
>> +		{
>> +			.x_res		= 800,
>> +			.y_res		= 480,
>> +
>> +			.pixel_clock	= 28000,
>> +
>> +			.hsw		= 48,
>> +			.hfp		= 40,
>> +			.hbp		= 40,
>> +
>> +			.vsw		= 3,
>> +			.vfp		= 13,
>> +			.vbp		= 29,
>> +		},
>> +		.acbi			= 0x0,
>> +		.acb			= 0x28,
>> +		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
>> +					  OMAP_DSS_LCD_IHS,
>> +		.power_on_delay		= 50,
>> +		.power_off_delay	= 100,
>> +		.name			= "focaltech_etm070003dh6",
>> +	},
>>  };
>>  
>>  struct panel_drv_data {
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Regards,
Igor.
