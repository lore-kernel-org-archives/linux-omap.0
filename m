From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH v2 6/8] omapdss: Features: Fix some parameter ranges
Date: Wed, 27 Mar 2013 13:08:20 +0530
Message-ID: <5152A1EC.8010801@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1364305525-28496-1-git-send-email-archit@ti.com> <1364305525-28496-7-git-send-email-archit@ti.com> <5152A0E6.3010300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60187 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739Ab3C0HjI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 Mar 2013 03:39:08 -0400
In-Reply-To: <5152A0E6.3010300@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: robdclark@gmail.com, andy.gross@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Wednesday 27 March 2013 01:03 PM, Tomi Valkeinen wrote:
> On 2013-03-26 15:45, Archit Taneja wrote:
>> Increase the DSS_FCLK and DSI_FCLK max supported frequencies, these come because
>> some frequencies were increased from OMAP5 ES1 to OMAP5 ES2. We support only
>> OMAP5 ES2 in the kernel, so replace the ES1 values with ES2 values. Increase the
>> DSI PLL Fint range, this was previously just copied from the OMAP4 param range
>> struct.
>>
>> Fix the maximum DSS_FCLK on OMAP2, it's 133 Mhz according to the TRM.
>>
>> Signed-off-by: Archit Taneja <archit@ti.com>
>> ---
>>   drivers/video/omap2/dss/dss_features.c |    8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
>> index 7f791ae..77dbe0c 100644
>> --- a/drivers/video/omap2/dss/dss_features.c
>> +++ b/drivers/video/omap2/dss/dss_features.c
>> @@ -414,7 +414,7 @@ static const char * const omap5_dss_clk_source_names[] = {
>>   };
>>
>>   static const struct dss_param_range omap2_dss_param_range[] = {
>> -	[FEAT_PARAM_DSS_FCK]			= { 0, 173000000 },
>> +	[FEAT_PARAM_DSS_FCK]			= { 0, 133000000 },
>>   	[FEAT_PARAM_DSS_PCD]			= { 2, 255 },
>>   	[FEAT_PARAM_DSIPLL_REGN]		= { 0, 0 },
>>   	[FEAT_PARAM_DSIPLL_REGM]		= { 0, 0 },
>> @@ -459,15 +459,15 @@ static const struct dss_param_range omap4_dss_param_range[] = {
>>   };
>>
>>   static const struct dss_param_range omap5_dss_param_range[] = {
>> -	[FEAT_PARAM_DSS_FCK]			= { 0, 200000000 },
>> +	[FEAT_PARAM_DSS_FCK]			= { 0, 209250000 },
>>   	[FEAT_PARAM_DSS_PCD]			= { 1, 255 },
>>   	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 8) - 1 },
>>   	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 12) - 1 },
>>   	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, (1 << 5) - 1 },
>>   	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, (1 << 5) - 1 },
>> -	[FEAT_PARAM_DSIPLL_FINT]		= { 500000, 2500000 },
>> +	[FEAT_PARAM_DSIPLL_FINT]		= { 150000, 52000000 },
>
> Just a note, I think the PLL FINT range for OMAP3/4 may be wrong also.
> Some TRMs mention the FINT range being up to 52MHz or so. I don't think
> it's ever very clearly stated, though...

I'll drop the FINT range modification for now. It's not that critical 
anyway since we manage to lock the PLL for most frequencies anyway. I'll 
do an update later after reading more detailed specs of the PLL.

Archit

