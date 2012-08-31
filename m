From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v2 02/23] OMAPDSS: outputs: Create and register output
 instances
Date: Fri, 31 Aug 2012 17:33:45 +0530
Message-ID: <5040A821.2030100@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>  <1346326845-16583-1-git-send-email-archit@ti.com>  <1346326845-16583-3-git-send-email-archit@ti.com> <1346414265.18766.9.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51651 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366Ab2HaMDb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 08:03:31 -0400
In-Reply-To: <1346414265.18766.9.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 31 August 2012 05:27 PM, Tomi Valkeinen wrote:
> On Thu, 2012-08-30 at 17:10 +0530, Archit Taneja wrote:
>> Add output structs to output driver's private data. Register output instances by
>> having an init function in the probes of the platform device drivers for
>> different outputs. The *_init_output for each output registers the output and
>> fill up the output's plaform device, type and id fields.
>>
>> In the probe of each interface driver, the output entities are initialized
>> before the *_probe_pdata() functions intentionally. This is done to ensure that
>> the output entity is prepared before the panels connected to the output are
>> registered. We need the output entities to be ready because OMAPDSS will try
>> to make connections between overlays, managers, outputs and devices during the
>> panel's probe.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>   drivers/video/omap2/dss/dpi.c  |   15 +++++++++++++++
>>   drivers/video/omap2/dss/dsi.c  |   18 ++++++++++++++++++
>>   drivers/video/omap2/dss/hdmi.c |   15 +++++++++++++++
>>   drivers/video/omap2/dss/rfbi.c |   17 +++++++++++++++++
>>   drivers/video/omap2/dss/sdi.c  |   15 +++++++++++++++
>>   drivers/video/omap2/dss/venc.c |   15 +++++++++++++++
>>   6 files changed, 95 insertions(+)
>>
>> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
>> index 25fb895..9a7aee5 100644
>> --- a/drivers/video/omap2/dss/dpi.c
>> +++ b/drivers/video/omap2/dss/dpi.c
>> @@ -45,6 +45,8 @@ static struct {
>>   	struct omap_video_timings timings;
>>   	struct dss_lcd_mgr_config mgr_config;
>>   	int data_lines;
>> +
>> +	struct omap_dss_output output;
>>   } dpi;
>>
>>   static struct platform_device *dpi_get_dsidev(enum omap_dss_clk_source clk)
>> @@ -410,10 +412,23 @@ static void __init dpi_probe_pdata(struct platform_device *pdev)
>>   	}
>>   }
>>
>> +static void __init dpi_init_output(struct platform_device *pdev)
>> +{
>> +	struct omap_dss_output *out = &dpi.output;
>> +
>> +	dss_register_output(out);
>> +
>> +	out->pdev = pdev;
>> +	out->id = OMAP_DSS_OUTPUT_DPI;
>> +	out->type = OMAP_DISPLAY_TYPE_DPI;
>> +}
>
> I think you should first initialize the output, and then register it.
> Not the other way around.

Ok.

>
> I believe you need to implement unregister also. Normally unregister
> won't be done, but the probe of an output driver can fail after the
> output has been registered, and thus the output needs to be unregistered
> at cleanup.

Ah, right.

>
> And it doesn't harm to unregister at the driver's remove.

I'll fix these, thanks.

Archit

