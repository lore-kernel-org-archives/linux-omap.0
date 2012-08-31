From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH v2 03/23] OMAPDSS: output: Add set/unset device ops for
 omap_dss_output
Date: Fri, 31 Aug 2012 17:54:01 +0530
Message-ID: <5040ACE1.8080502@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>  <1346326845-16583-1-git-send-email-archit@ti.com>  <1346326845-16583-4-git-send-email-archit@ti.com> <1346414621.18766.13.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51022 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129Ab2HaMXr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Aug 2012 08:23:47 -0400
In-Reply-To: <1346414621.18766.13.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Friday 31 August 2012 05:33 PM, Tomi Valkeinen wrote:
> On Thu, 2012-08-30 at 17:10 +0530, Archit Taneja wrote:
>> An output entity represented by the struct omap_dss_output connects to a
>> omap_dss_device entity. Add functions to set or unset an output's device. This
>> is similar to how managers and devices were connected previously. An output can
>> connect to a device without being connected to a manager. However, the output
>> needs to eventually connect to a manager so that the connected panel can be
>> enabled.
>>
>> Keep the omap_overlay_manager pointer in omap_dss_device for now to prevent
>> breaking things. This will be removed later when outputs are supported
>> completely.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>   drivers/video/omap2/dss/output.c |   67 ++++++++++++++++++++++++++++++++++++++
>>   include/video/omapdss.h          |    5 +++
>>   2 files changed, 72 insertions(+)
>>
>> diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
>> index 7d81be5..abc3aa2 100644
>> --- a/drivers/video/omap2/dss/output.c
>> +++ b/drivers/video/omap2/dss/output.c
>> @@ -24,9 +24,76 @@
>>   #include "dss.h"
>>
>>   static LIST_HEAD(output_list);
>> +static DEFINE_MUTEX(output_lock);
>> +
>> +static int dss_output_set_device(struct omap_dss_output *out,
>> +		struct omap_dss_device *dssdev)
>> +{
>> +	int r;
>> +
>> +	mutex_lock(&output_lock);
>> +
>> +	if (out->device) {
>> +		DSSERR("output already has device %s connected to it\n",
>> +			out->device->name);
>> +		r = -EINVAL;
>> +		goto err;
>> +	}
>> +
>> +	if (out->type != dssdev->type) {
>> +		DSSERR("output type and display type don't match\n");
>> +		r = -EINVAL;
>> +		goto err;
>> +	}
>> +
>> +	out->device = dssdev;
>> +	dssdev->output = out;
>> +
>> +	mutex_unlock(&output_lock);
>> +
>> +	return 0;
>> +err:
>> +	mutex_unlock(&output_lock);
>> +
>> +	return r;
>> +}
>> +
>> +static int dss_output_unset_device(struct omap_dss_output *out)
>> +{
>> +	int r;
>> +
>> +	mutex_lock(&output_lock);
>> +
>> +	if (!out->device) {
>> +		DSSERR("output doesn't have a device connected to it\n");
>> +		r = -EINVAL;
>> +		goto err;
>> +	}
>> +
>> +	if (out->device->state != OMAP_DSS_DISPLAY_DISABLED) {
>> +		DSSERR("device %s is not disabled, cannot unset device\n",
>> +				out->device->name);
>> +		r = -EINVAL;
>> +		goto err;
>> +	}
>> +
>> +	out->device->output = NULL;
>> +	out->device = NULL;
>> +
>> +	mutex_unlock(&output_lock);
>> +
>> +	return 0;
>> +err:
>> +	mutex_unlock(&output_lock);
>> +
>> +	return r;
>> +}
>>
>>   void dss_register_output(struct omap_dss_output *out)
>>   {
>> +	out->set_device = &dss_output_set_device;
>> +	out->unset_device = &dss_output_unset_device;
>> +
>>   	list_add_tail(&out->list, &output_list);
>>   }
>
> I don't think there's need for this indirection. We should use function
> pointers only when the func pointer may lead to different functions.
> Here we'll always have just one function, dss_output_set_device. We can
> as well call the function directly.

Okay. I understand that. But in general, don't func pointers prevent us 
from exporting more symbols?

>
> I know we have similar func pointers for ovls/mgrs currently, but I
> don't think they are good either. They are a relic from the time we
> supported "virtual" overlays and managers, and thus could have different
> implementations for the operations.

Oh okay, I guess you mean the L4/sDMA updates for DSI command mode.

Archit

