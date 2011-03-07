From: archit taneja <archit@ti.com>
Subject: Re: [PATCH] OMAP: DSS2: FEATURES: DSI PLL parameter cleanup
Date: Mon, 7 Mar 2011 14:47:51 +0530
Message-ID: <4D74A2BF.3050908@ti.com>
References: <1299236625-1057-1-git-send-email-archit@ti.com> <1299484471.2281.50.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60852 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754055Ab1CGJON (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 04:14:13 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p279EAqG017367
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 03:14:12 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p279E9Jh028548
	for <linux-omap@vger.kernel.org>; Mon, 7 Mar 2011 14:44:09 +0530 (IST)
In-Reply-To: <1299484471.2281.50.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Monday 07 March 2011 01:24 PM, Valkeinen, Tomi wrote:
> On Fri, 2011-03-04 at 05:03 -0600, Taneja, Archit wrote:
>> The DSI PLL parameters (regm, regn, regm_dispc, regm_dsi, fint) have different
>> fields and also different Max values on OMAP3 and OMAP4. Use dss features to
>> calculate the register fields and Max values based on current OMAP revision
>>
>> Also, introduce a new function in dss_features "dss_feat_get_param_range" which
>> returns the maximum and minimum values supported by the parameter for
>> the current OMAP revision.
>
> See comment about "also" in the last mail =). You are introducing a new
> kind of dss feature as a sidenote. I think it should clearly be a
> separate patch.
>
> <snip>
>
>> +void dss_feat_get_param_range(enum dss_range_param param, int *min, int *max)
>> +{
>> +	*min = omap_current_dss_features->dss_params[param].min;
>> +	*max = omap_current_dss_features->dss_params[param].max;
>
> This isn't right. Here you're using the param as index, but in the param
> array itself the param is just part of the struct. So it's just luck
> that the index is correct.

The param part of the struct is just for readability, and possibly more 
thorough checking for later on.

The index isn't correct by luck, its mainly because during defining the 
array, we fill it up in the sequence in which the enum is defined.

>
> This is actually wrong with the reg fields and clock sources also...
>
> I believe there was a way to give entries in an array by the index.
> Something like:
>
> static struct foo bar[] = {
> 	[0] = { stuff },
> 	[1] = { stuff },
> };

I agree this is better , I didn't know we could use this.

>
> In that solution it's not necessary to have the index in the struct
> itself, like now.
>
> Alternatively, with the current struct, we could iterate through the
> array to find a matching id.

Yes, my earlier patch for dss features used a list and we iterated to 
get the matching id, but that was bit of an overkill.

>
>> +}
>> +
>>   /* DSS has_feature check */
>>   bool dss_has_feature(enum dss_feat_id id)
>>   {
>> diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
>> index 3302247..78b51a9 100644
>> --- a/drivers/video/omap2/dss/dss_features.h
>> +++ b/drivers/video/omap2/dss/dss_features.h
>> @@ -52,6 +52,14 @@ enum dss_feat_reg_field {
>>   	FEAT_REG_HORIZONTALACCU,
>>   	FEAT_REG_VERTICALACCU,
>>   	FEAT_REG_DISPC_CLK_SWITCH,
>> +	FEAT_REG_DSIPLL_REGM,
>> +	FEAT_REG_DSIPLL_REGN,
>> +	FEAT_REG_DSIPLL_REGM_DISPC,
>> +	FEAT_REG_DSIPLL_REGM_DSI,
>> +};
>> +
>> +enum dss_range_param {
>> +	FEAT_DSI_FINT,
>>   };
>>
>>   /* DSS Feature Functions */
>> @@ -63,6 +71,7 @@ enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane);
>>   bool dss_feat_color_mode_supported(enum omap_plane plane,
>>   		enum omap_color_mode color_mode);
>>   const char *dss_feat_get_clk_source_name(enum dss_clk_source id);
>> +void dss_feat_get_param_range(enum dss_range_param param, int *min, int *max);
>
> Currently used only for fint, but if it's supposed to handle clock
> rates, unsigned long instead of int could be better.
>
> I was also thinking that we now have dss_feat_get_max_dss_fck(), which
> is somewhat similar to this.
>
> Could something like this work:
>
> unsigned long dss_feat_get_param_min(enum dss_range_param param);
> unsigned long dss_feat_get_param_max(enum dss_range_param param);
>

I agree. Should we remove the max_dss_fck patch since we are moving to 
this approach?

Archit
