From: Archit Taneja <a0393947@ti.com>
Subject: Re: [PATCH 01/23] OMAPDSS: outputs: Create a new entity called outputs
Date: Wed, 29 Aug 2012 16:27:05 +0530
Message-ID: <503DF581.8050809@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>   <1345528711-27801-2-git-send-email-archit@ti.com>  <1345812069.9287.65.camel@lappyti> <503778E8.2060909@ti.com> <1346236370.2623.45.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44036 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541Ab2H2K6n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Aug 2012 06:58:43 -0400
In-Reply-To: <1346236370.2623.45.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com

On Wednesday 29 August 2012 04:02 PM, Tomi Valkeinen wrote:
> On Fri, 2012-08-24 at 18:21 +0530, Archit Taneja wrote:
>
>>>> +enum omap_dss_output_id {
>>>> +	OMAP_DSS_OUTPUT_DPI	= 1 << 0,
>>>> +	OMAP_DSS_OUTPUT_DBI	= 1 << 1,
>>>> +	OMAP_DSS_OUTPUT_SDI	= 1 << 2,
>>>> +	OMAP_DSS_OUTPUT_DSI1	= 1 << 3,
>>>> +	OMAP_DSS_OUTPUT_VENC	= 1 << 4,
>>>> +	OMAP_DSS_OUTPUT_DSI2	= 1 << 5,
>>>> +	OMAP_DSS_OUTPUT_HDMI	= 1 << 6,
>>>> +};
>>>
>>> I'm not sure about this. We already have enum omap_display_type. If you
>>> need the instance number, you could have that as a separate int field.
>>>
>>> Where do you need the output_id?
>>
>> output_id is used to take care of situations where there our multiple
>> outputs of the same type, like DSI1 and DSI2. An enum helps when we
>> check if an overlay manager supports that output instance or not. For
>> ex, on OMAP4, LCD1 connects to DSI1 and not DSI2.
>>
>> I add a func called dss_feat_get_supported_outputs(channel) later to
>> check for this. When setting a new output for a manager, we just do an
>> '&' to see if the output in question is in the mask of the manager's set
>> of supported outputs.
>
> After thinking about this, I think we should remove the
> omap_display_type and the supported_displays stuff. It doesn't really
> work anymore, as we have more complex connections with omap4+. With a
> quick glance to the code, I think it should be quite easy to remove it.
>
> And we need something like your omap_dss_output_id. I'm just not sure
> about the enum. But perhaps it's the easiest option for now, as some
> kind of array of similar would be more complex to implement, and I'm not
> sure if it really gives anything. You could move the VENC away from
> between DSI1 and DSI2, though. I'm not sure why you put VENC in between
> =).

I put the outputs in the order in which they were introduced in OMAPs, 
I'm not sure why I did that, maybe I copied that approach after looking 
at some other enum. I'll change it.

Archit
