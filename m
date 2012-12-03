From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: Re: [PATCH 2/7] OMAPDSS: DISPC: Move DISPC specific dss_reg_fields
 to dispc_features
Date: Mon, 3 Dec 2012 11:59:26 +0530
Message-ID: <50BC46C6.3050707@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com> <a5bbbc9af3ef5ca2636d3c4dea6cbbe9834e0f62.1354086150.git.cmahapatra@ti.com> <50B7528C.1090507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34201 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab2LCGcz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Dec 2012 01:32:55 -0500
In-Reply-To: <50B7528C.1090507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 29 November 2012 05:48 PM, Tomi Valkeinen wrote:
> On 2012-11-28 12:41, Chandrabhanu Mahapatra wrote:
>> The register fields in dss_reg_fields specific to DISPC are moved from struct
>> omap_dss_features to corresponding dispc_reg_fields, initialized in struct
>> dispc_features, thereby enabling local access.
>>
>> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> ---
>>  drivers/video/omap2/dss/dispc.c        |   87 ++++++++++++++++++++++++++++----
>>  drivers/video/omap2/dss/dss.h          |    4 ++
>>  drivers/video/omap2/dss/dss_features.c |   28 ----------
>>  drivers/video/omap2/dss/dss_features.h |    7 ---
>>  4 files changed, 80 insertions(+), 46 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
>> index 9f259ba..21fc522 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -80,6 +80,16 @@ struct dispc_irq_stats {
>>  	unsigned irqs[32];
>>  };
>>  
>> +enum dispc_feat_reg_field {
>> +	FEAT_REG_FIRHINC,
>> +	FEAT_REG_FIRVINC,
>> +	FEAT_REG_FIFOLOWTHRESHOLD,
>> +	FEAT_REG_FIFOHIGHTHRESHOLD,
>> +	FEAT_REG_FIFOSIZE,
>> +	FEAT_REG_HORIZONTALACCU,
>> +	FEAT_REG_VERTICALACCU,
>> +};
>> +
>>  struct dispc_features {
>>  	u8 sw_start;
>>  	u8 fp_start;
>> @@ -107,6 +117,8 @@ struct dispc_features {
>>  
>>  	u32 buffer_size_unit;
>>  	u32 burst_size_unit;
>> +
>> +	struct register_field *reg_fields;
>>  };
> 
> Hmm, would it be simpler to have an explicit struct for the reg fields.
> I mean something like:
> 
> struct dispc_reg_fields {
> 	struct register_field firhinc;
> 	struct register_field firvinc;
> 	struct register_field fifo_low_threshold;
> 	...
> };
> 
> Then accessing it would be
> 
> dispc.feat->reg_fields.firhinc.start;
> 
> instead of
> 
> dispc.feat->reg_fields[FEAT_REG_FIFOSIZE].start;
> 
> Not a big difference, but I don't see any benefit in having an array of
> reg fields here.
> 
>  Tomi
> 
> 

I was thinking to move reg_fields into the dispc_feats structure as

	.burst_size_unit	=	8,
	.reg_fields		=	{
		.firhinc			= { 12,  0 },
		.firvinc			= { 28, 16 },
		.fifo_low_thresh		= { 11,  0 },
		.fifo_high_thresh		= { 27, 16 },
		.fifosize			= { 10,  0 },
		.hori_accu			= {  9,  0 },
		.vert_accu			= { 25, 16 },
	},

This would give us dispc.feat->reg_fields.firhinc.start;
but at the same time would create duplicate information for
omap34xx_rev1_0_dispc_feats and omap34xx_rev3_0_dispc_feats. However,
this duplication never occurs anywhere else in dss.c or dsi.c.

If we still go with the older approach of having dispc_reg_fields
outside dispc_feats the only way  it works is

.reg_fields		=	&omap2_dispc_reg_fields

which changes as dispc.feat->reg_fields->firhinc.start;

but avoids duplicate information. Both approaches seem good enough to me.


-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
