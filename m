From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 02/23] OMAPDSS: outputs: Create and initialize output
 instances
Date: Mon, 27 Aug 2012 11:49:08 +0530
Message-ID: <503B115C.7040904@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>  <1345528711-27801-3-git-send-email-archit@ti.com> <1345814042.9287.72.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42047 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122Ab2H0GUp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Aug 2012 02:20:45 -0400
In-Reply-To: <1345814042.9287.72.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com

On Friday 24 August 2012 06:44 PM, Tomi Valkeinen wrote:
> On Tue, 2012-08-21 at 11:28 +0530, Archit Taneja wrote:
>> Create output instances by having an init function in the probes of the platform
>> device drivers for different interfaces. Create a small function for each
>> interface to initialize the output entity's fields type and id.
>>
>> In the probe of each interface driver, the output entities are created before
>> the *_probe_pdata() functions intentionally. This is done to ensure that the
>> output entity is prepared before the panels connected to the output are
>> registered. We need the output entities to be ready because OMAPDSS will try
>> to make connections between overlays, managers, outputs and devices during the
>> panel's probe.
>
> You're referring to the recheck_connections stuff? I have a patch that
> moves that to omapfb side. But of course it doesn't hurt to initialize
> the output early.

I've seen that patch. omapfb would need to take care of connecting 
outputs to displays, and managers to outputs. This is added in 
recheck_connections done in a patch #9 of the series.

The question is whether we want some initial connections made between 
outputs and displays by DSS, or should that be left completely to 
omapfb/omapdrm?

>
> We should generally do the initialization in output driver's probe more
> or less so that we first setup everything related to the output driver,
> and after that we register the dssdevs. But I think that's what is
> already done.
>
> So, no complaints =).

Another thing that comes up with delaying the recheck_connections stuff 
is that we can't assume that at the point of panel driver's probe, there 
is an output connected to the display. That makes it a bit tricky to 
call an output function in the panel's probe, since it isn't connected 
to any output at all. An example is when we request for a VC in 
taal_probe. Since the panel isn't connected to any output yet, we can't 
really call a dsi function to request for the VC. This particular case 
can be solved by requesting VCs only when we enable the panel(probably 
makes more sense this way), but there might be other situations which 
could get tricky to tackle.

>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>   drivers/video/omap2/dss/dpi.c  |   20 ++++++++++++++++++++
>>   drivers/video/omap2/dss/dsi.c  |   26 ++++++++++++++++++++++++--
>>   drivers/video/omap2/dss/hdmi.c |   18 ++++++++++++++++++
>>   drivers/video/omap2/dss/rfbi.c |   19 +++++++++++++++++++
>>   drivers/video/omap2/dss/sdi.c  |   20 ++++++++++++++++++++
>>   drivers/video/omap2/dss/venc.c |   20 ++++++++++++++++++++
>>   6 files changed, 121 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
>> index f260343..4eca2e7 100644
>> --- a/drivers/video/omap2/dss/dpi.c
>> +++ b/drivers/video/omap2/dss/dpi.c
>> @@ -408,10 +408,30 @@ static void __init dpi_probe_pdata(struct platform_device *pdev)
>>   	}
>>   }
>>
>> +static int __init dpi_init_output(struct platform_device *pdev)
>> +{
>> +	struct omap_dss_output *out;
>> +
>> +	out = dss_create_output(pdev);
>> +	if (!out)
>> +		return -ENOMEM;
>> +
>> +	out->id = OMAP_DSS_OUTPUT_DPI;
>> +	out->type = OMAP_DISPLAY_TYPE_DPI;
>> +
>> +	return 0;
>> +}
>> +
>>   static int __init omap_dpi_probe(struct platform_device *pdev)
>>   {
>> +	int r;
>> +
>>   	mutex_init(&dpi.lock);
>>
>> +	r = dpi_init_output(pdev);
>> +	if (r)
>> +		return r;
>> +
>>   	dpi_probe_pdata(pdev);
>>
>>   	return 0;
>> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
>> index 659b6cd..22e0873 100644
>> --- a/drivers/video/omap2/dss/dsi.c
>> +++ b/drivers/video/omap2/dss/dsi.c
>> @@ -4903,6 +4903,23 @@ static void __init dsi_probe_pdata(struct platform_device *dsidev)
>>   	}
>>   }
>>
>> +static int __init dsi_init_output(struct platform_device *dsidev,
>> +		struct dsi_data *dsi)
>> +{
>> +	struct omap_dss_output *out;
>> +
>> +	out = dss_create_output(dsidev);
>> +	if (!out)
>> +		return -ENOMEM;
>> +
>> +	out->id = dsi->module_id == 0 ?
>> +			OMAP_DSS_OUTPUT_DSI1 : OMAP_DSS_OUTPUT_DSI2;
>> +
>> +	out->type = OMAP_DISPLAY_TYPE_DSI;
>> +
>> +	return 0;
>
> As I mentioned in the last email, I think this could be something like:
>
> struct omap_dss_output *out = &dsi->output;
>
> out->pdev = dsidev;
> out->id = xxx;
> out->type = yyy;
> dss_register_output(out);
>

Right, this is much better, will do it this way.

>
>> +}
>> +
>>   /* DSI1 HW IP initialisation */
>>   static int __init omap_dsihw_probe(struct platform_device *dsidev)
>>   {
>> @@ -4997,10 +5014,14 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
>>   	else
>>   		dsi->num_lanes_supported = 3;
>>
>> -	dsi_probe_pdata(dsidev);
>> -
>>   	dsi_runtime_put(dsidev);
>>
>> +	r = dsi_init_output(dsidev, dsi);
>> +	if (r)
>> +		goto err_init_output;
>> +
>> +	dsi_probe_pdata(dsidev);
>> +
>
> Why do you change the sequence here? Isn't it enough to just add the
> init_output before probe_pdata?

Yes, I think I didn't see the point in keeping the clocks on for 
dsi_init_output() and dsi_probe_pdata(), so tried to incorporate that in 
this patch too :), I'll change this back to the old way, it doesn't make 
sense in moving around pm runtime calls in this series.

Archit

