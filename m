From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 01/23] OMAPDSS: outputs: Create a new entity called outputs
Date: Fri, 24 Aug 2012 18:21:52 +0530
Message-ID: <503778E8.2060909@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>  <1345528711-27801-2-git-send-email-archit@ti.com> <1345812069.9287.65.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36477 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759339Ab2HXMxZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Aug 2012 08:53:25 -0400
In-Reply-To: <1345812069.9287.65.camel@lappyti>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com

On Friday 24 August 2012 06:11 PM, Tomi Valkeinen wrote:
> On Tue, 2012-08-21 at 11:28 +0530, Archit Taneja wrote:
>
>> diff --git a/drivers/video/omap2/dss/output.c b/drivers/video/omap2/dss/output.c
>> new file mode 100644
>> index 0000000..034ebbe
>> --- /dev/null
>> +++ b/drivers/video/omap2/dss/output.c
>> @@ -0,0 +1,58 @@
>> +/*
>> + * Copyright (C) 2012 Texas Instruments Ltd
>> + * Author: Archit Taneja <archit@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms of the GNU General Public License version 2 as published by
>> + * the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along with
>> + * this program.  If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +
>> +#include <video/omapdss.h>
>> +
>> +#include "dss.h"
>> +
>> +static struct list_head output_list;
>
> You can do:
>
> static LIST_HEAD(output_list);
>
> Then you don't need to initialize it separately.

Oh ok. I'll fix this.

>
>> +
>> +struct omap_dss_output *dss_create_output(struct platform_device *pdev)
>> +{
>> +	struct omap_dss_output *out;
>> +
>> +	out = kzalloc(sizeof(struct omap_dss_output *), GFP_KERNEL);
>> +	if (!out)
>> +		return NULL;
>
> A patch that adds kzalloc but no free is always a bit suspicious =).
>
>> +
>> +	out->pdev = pdev;
>> +
>> +	list_add_tail(&out->list, &output_list);
>> +
>> +	return out;
>> +}
>
> Instead of allocating omap_dss_output here, you could let the caller do
> it, and only initialize it here with default values (if that's even
> needed). Then the caller can use kzalloc, or can just embed the stuct
> into its own data-struct, which may be often a better choice.

So output can be in each interface driver's private data, and we just 
add that to our list of outputs?

>
>> +struct omap_dss_output *omap_dss_get_output(enum omap_dss_output_id id)
>> +{
>> +	struct omap_dss_output *out;
>> +
>> +	list_for_each_entry(out, &output_list, list) {
>> +		if (out->id == id)
>> +			return out;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +void dss_init_outputs(void)
>> +{
>> +	INIT_LIST_HEAD(&output_list);
>> +}
>> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
>> index b868123..0ba613f 100644
>> --- a/include/video/omapdss.h
>> +++ b/include/video/omapdss.h
>> @@ -207,6 +207,16 @@ enum omap_hdmi_flags {
>>   	OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP = 1 << 0,
>>   };
>>
>> +enum omap_dss_output_id {
>> +	OMAP_DSS_OUTPUT_DPI	= 1 << 0,
>> +	OMAP_DSS_OUTPUT_DBI	= 1 << 1,
>> +	OMAP_DSS_OUTPUT_SDI	= 1 << 2,
>> +	OMAP_DSS_OUTPUT_DSI1	= 1 << 3,
>> +	OMAP_DSS_OUTPUT_VENC	= 1 << 4,
>> +	OMAP_DSS_OUTPUT_DSI2	= 1 << 5,
>> +	OMAP_DSS_OUTPUT_HDMI	= 1 << 6,
>> +};
>
> I'm not sure about this. We already have enum omap_display_type. If you
> need the instance number, you could have that as a separate int field.
>
> Where do you need the output_id?

output_id is used to take care of situations where there our multiple 
outputs of the same type, like DSI1 and DSI2. An enum helps when we 
check if an overlay manager supports that output instance or not. For 
ex, on OMAP4, LCD1 connects to DSI1 and not DSI2.

I add a func called dss_feat_get_supported_outputs(channel) later to 
check for this. When setting a new output for a manager, we just do an 
'&' to see if the output in question is in the mask of the manager's set 
of supported outputs.

>
>> +
>>   /* RFBI */
>>
>>   struct rfbi_timings {
>> @@ -492,6 +502,24 @@ struct omap_dsi_pin_config {
>>   	int pins[OMAP_DSS_MAX_DSI_PINS];
>>   };
>>
>> +struct omap_dss_output {
>> +	struct list_head list;
>> +
>> +	/* display type supported by the output */
>> +	enum omap_display_type type;
>> +
>> +	/* output instance */
>> +	enum omap_dss_output_id id;
>
> So instead of omap_dss_output_id, you'd have omap_display_type type and
> int id, which together tell the supported output and also the output
> driver instance.
>
>   Tomi
>

