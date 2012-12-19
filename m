From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: Re: [PATCH V2 2/6] OMAPDSS: DISPC: Move DISPC specific dss_reg_fields
 to dispc_features
Date: Wed, 19 Dec 2012 14:57:54 +0530
Message-ID: <50D1889A.606@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com> <cover.1354702077.git.cmahapatra@ti.com> <08d6240ab26427a9e437421c2cc76ade29036817.1354702077.git.cmahapatra@ti.com> <50CF1202.70507@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49143 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987Ab2LSJb3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Dec 2012 04:31:29 -0500
In-Reply-To: <50CF1202.70507@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Monday 17 December 2012 06:07 PM, Tomi Valkeinen wrote:
> On 2012-12-05 12:16, Chandrabhanu Mahapatra wrote:
>> The register fields in dss_reg_fields specific to DISPC are moved from struct
>> omap_dss_features to corresponding dispc_reg_fields, initialized in struct
>> dispc_features, thereby enabling local access.
>>
>> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> ---
>>  drivers/video/omap2/dss/dispc.c        |  114 ++++++++++++++++++++++++--------
>>  drivers/video/omap2/dss/dss.h          |    4 ++
>>  drivers/video/omap2/dss/dss_features.c |   28 --------
>>  drivers/video/omap2/dss/dss_features.h |    7 --
>>  4 files changed, 89 insertions(+), 64 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
>> index bbba83f..ee4b152 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -80,6 +80,16 @@ struct dispc_irq_stats {
>>  	unsigned irqs[32];
>>  };
>>  
>> +struct dispc_reg_fields {
>> +	struct omapdss_reg_field firhinc;
>> +	struct omapdss_reg_field firvinc;
>> +	struct omapdss_reg_field fifo_low_thresh;
>> +	struct omapdss_reg_field fifo_high_thresh;
>> +	struct omapdss_reg_field fifosize;
>> +	struct omapdss_reg_field hori_accu;
>> +	struct omapdss_reg_field vert_accu;
>> +};
>> +
>>  struct dispc_features {
>>  	u8 sw_start;
>>  	u8 fp_start;
>> @@ -110,6 +120,8 @@ struct dispc_features {
>>  
>>  	u32 buffer_size_unit; /* in bytes */
>>  	u32 burst_size_unit; /* in bytes */
>> +
>> +	struct dispc_reg_fields *reg_fields;
> 
> This can be pointer to const.
> 

Yes, the same thing can also be done in other dispc and dsi reg_fields
and param_ranges.

>>  };
>>  
>>  #define DISPC_MAX_NR_FIFOS 5
>> @@ -1137,17 +1149,17 @@ static void dispc_mgr_set_size(enum omap_channel channel, u16 width,
>>  
>>  static void dispc_init_fifos(void)
>>  {
>> -	u32 size;
>> +	u32 size, unit;
>>  	int fifo;
>> -	u8 start, end;
>> -	u32 unit;
>> +	const struct omapdss_reg_field *fifo_field;
>>  
>>  	unit = dispc.feat->buffer_size_unit;
>>  
>> -	dss_feat_get_reg_field(FEAT_REG_FIFOSIZE, &start, &end);
>> +	fifo_field = &dispc.feat->reg_fields->fifosize;
>>  
>>  	for (fifo = 0; fifo < dispc.feat->num_fifos; ++fifo) {
>> -		size = REG_GET(DISPC_OVL_FIFO_SIZE_STATUS(fifo), start, end);
>> +		size = REG_GET(DISPC_OVL_FIFO_SIZE_STATUS(fifo),
>> +					fifo_field->start, fifo_field->end);
>>  		size *= unit;
>>  		dispc.fifo_size[fifo] = size;
>>  
>> @@ -1197,8 +1209,8 @@ static u32 dispc_ovl_get_fifo_size(enum omap_plane plane)
>>  
>>  void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
>>  {
>> -	u8 hi_start, hi_end, lo_start, lo_end;
>>  	u32 unit;
>> +	const struct omapdss_reg_field *hi_field, *lo_field;
>>  
>>  	unit = dispc.feat->buffer_size_unit;
>>  
>> @@ -1208,20 +1220,20 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
>>  	low /= unit;
>>  	high /= unit;
>>  
>> -	dss_feat_get_reg_field(FEAT_REG_FIFOHIGHTHRESHOLD, &hi_start, &hi_end);
>> -	dss_feat_get_reg_field(FEAT_REG_FIFOLOWTHRESHOLD, &lo_start, &lo_end);
>> +	hi_field = &dispc.feat->reg_fields->fifo_high_thresh;
>> +	lo_field = &dispc.feat->reg_fields->fifo_low_thresh;
>>  
>>  	DSSDBG("fifo(%d) threshold (bytes), old %u/%u, new %u/%u\n",
>>  			plane,
>>  			REG_GET(DISPC_OVL_FIFO_THRESHOLD(plane),
>> -				lo_start, lo_end) * unit,
>> +				lo_field->start, lo_field->end) * unit,
>>  			REG_GET(DISPC_OVL_FIFO_THRESHOLD(plane),
>> -				hi_start, hi_end) * unit,
>> +				hi_field->start, hi_field->end) * unit,
>>  			low * unit, high * unit);
>>  
>>  	dispc_write_reg(DISPC_OVL_FIFO_THRESHOLD(plane),
>> -			FLD_VAL(high, hi_start, hi_end) |
>> -			FLD_VAL(low, lo_start, lo_end));
>> +			FLD_VAL(high, hi_field->start, hi_field->end) |
>> +			FLD_VAL(low, lo_field->start, lo_field->end));
>>  }
>>  
>>  void dispc_enable_fifomerge(bool enable)
>> @@ -1289,14 +1301,13 @@ static void dispc_ovl_set_fir(enum omap_plane plane,
>>  	u32 val;
>>  
>>  	if (color_comp == DISPC_COLOR_COMPONENT_RGB_Y) {
>> -		u8 hinc_start, hinc_end, vinc_start, vinc_end;
>> +		const struct omapdss_reg_field *hinc_field, *vinc_field;
>>  
>> -		dss_feat_get_reg_field(FEAT_REG_FIRHINC,
>> -					&hinc_start, &hinc_end);
>> -		dss_feat_get_reg_field(FEAT_REG_FIRVINC,
>> -					&vinc_start, &vinc_end);
>> -		val = FLD_VAL(vinc, vinc_start, vinc_end) |
>> -				FLD_VAL(hinc, hinc_start, hinc_end);
>> +		hinc_field = &dispc.feat->reg_fields->firhinc;
>> +		vinc_field = &dispc.feat->reg_fields->firvinc;
>> +
>> +		val = FLD_VAL(vinc, vinc_field->start, vinc_field->end) |
>> +			FLD_VAL(hinc, hinc_field->start, hinc_field->end);
>>  
>>  		dispc_write_reg(DISPC_OVL_FIR(plane), val);
>>  	} else {
>> @@ -1308,13 +1319,13 @@ static void dispc_ovl_set_fir(enum omap_plane plane,
>>  static void dispc_ovl_set_vid_accu0(enum omap_plane plane, int haccu, int vaccu)
>>  {
>>  	u32 val;
>> -	u8 hor_start, hor_end, vert_start, vert_end;
>> +	const struct omapdss_reg_field *haccu_field, *vaccu_field;
>>  
>> -	dss_feat_get_reg_field(FEAT_REG_HORIZONTALACCU, &hor_start, &hor_end);
>> -	dss_feat_get_reg_field(FEAT_REG_VERTICALACCU, &vert_start, &vert_end);
>> +	haccu_field = &dispc.feat->reg_fields->hori_accu;
>> +	vaccu_field = &dispc.feat->reg_fields->vert_accu;
>>  
>> -	val = FLD_VAL(vaccu, vert_start, vert_end) |
>> -			FLD_VAL(haccu, hor_start, hor_end);
>> +	val = FLD_VAL(vaccu, vaccu_field->start, vaccu_field->end) |
>> +		FLD_VAL(haccu, haccu_field->start, haccu_field->end);
>>  
>>  	dispc_write_reg(DISPC_OVL_ACCU0(plane), val);
>>  }
>> @@ -1322,13 +1333,13 @@ static void dispc_ovl_set_vid_accu0(enum omap_plane plane, int haccu, int vaccu)
>>  static void dispc_ovl_set_vid_accu1(enum omap_plane plane, int haccu, int vaccu)
>>  {
>>  	u32 val;
>> -	u8 hor_start, hor_end, vert_start, vert_end;
>> +	const struct omapdss_reg_field *haccu_field, *vaccu_field;
>>  
>> -	dss_feat_get_reg_field(FEAT_REG_HORIZONTALACCU, &hor_start, &hor_end);
>> -	dss_feat_get_reg_field(FEAT_REG_VERTICALACCU, &vert_start, &vert_end);
>> +	haccu_field = &dispc.feat->reg_fields->hori_accu;
>> +	vaccu_field = &dispc.feat->reg_fields->vert_accu;
>>  
>> -	val = FLD_VAL(vaccu, vert_start, vert_end) |
>> -			FLD_VAL(haccu, hor_start, hor_end);
>> +	val = FLD_VAL(vaccu, vaccu_field->start, vaccu_field->end) |
>> +		FLD_VAL(haccu, haccu_field->start, haccu_field->end);
>>  
>>  	dispc_write_reg(DISPC_OVL_ACCU1(plane), val);
>>  }
>> @@ -4048,6 +4059,46 @@ static void _omap_dispc_initial_config(void)
>>  	dispc_ovl_enable_zorder_planes();
>>  }
>>  
>> +static struct dispc_reg_fields omap2_dispc_reg_fields = {
>> +	.firhinc		=	{ 11,  0 },
>> +	.firvinc		=	{ 27, 16 },
>> +	.fifo_low_thresh	=	{  8,  0 },
>> +	.fifo_high_thresh	=	{ 24, 16 },
>> +	.fifosize		=	{  8,  0 },
>> +	.hori_accu		=	{  9,  0 },
>> +	.vert_accu		=	{ 25, 16 },
>> +};
> 
> And these tables can be consts.
> 
>> +static struct dispc_reg_fields omap3_dispc_reg_fields = {
>> +	.firhinc		=	{ 12,  0 },
>> +	.firvinc		=	{ 28, 16 },
>> +	.fifo_low_thresh	=	{ 11,  0 },
>> +	.fifo_high_thresh	=	{ 27, 16 },
>> +	.fifosize		=	{ 10,  0 },
>> +	.hori_accu		=	{  9,  0 },
>> +	.vert_accu		=	{ 25, 16 },
>> +};
>> +
>> +static struct dispc_reg_fields omap4_dispc_reg_fields = {
>> +	.firhinc		=	{ 12,  0 },
>> +	.firvinc		=	{ 28, 16 },
>> +	.fifo_low_thresh	=	{ 15,  0 },
>> +	.fifo_high_thresh	=	{ 31, 16 },
>> +	.fifosize		=	{ 15,  0 },
>> +	.hori_accu		=	{ 10,  0 },
>> +	.vert_accu		=	{ 26, 16 },
>> +};
>> +
>> +static struct dispc_reg_fields omap5_dispc_reg_fields = {
>> +	.firhinc		=	{ 12,  0 },
>> +	.firvinc		=	{ 28, 16 },
>> +	.fifo_low_thresh	=	{ 15,  0 },
>> +	.fifo_high_thresh	=	{ 31, 16 },
>> +	.fifosize		=	{ 15,  0 },
>> +	.hori_accu		=	{ 10,  0 },
>> +	.vert_accu		=	{ 26, 16 },
>> +};
>> +
>>  static const struct dispc_features omap24xx_dispc_feats __initconst = {
>>  	.sw_start		=	5,
>>  	.fp_start		=	15,
>> @@ -4065,6 +4116,7 @@ static const struct dispc_features omap24xx_dispc_feats __initconst = {
>>  	.no_framedone_tv	=	true,
>>  	.buffer_size_unit	=	1,
>>  	.burst_size_unit	=	8,
>> +	.reg_fields		=	&omap2_dispc_reg_fields,
>>  };
>>  
>>  static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
>> @@ -4084,6 +4136,7 @@ static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
>>  	.no_framedone_tv	=	true,
>>  	.buffer_size_unit	=	1,
>>  	.burst_size_unit	=	8,
>> +	.reg_fields		=	&omap3_dispc_reg_fields,
>>  };
>>  
>>  static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
>> @@ -4103,6 +4156,7 @@ static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
>>  	.no_framedone_tv	=	true,
>>  	.buffer_size_unit	=	1,
>>  	.burst_size_unit	=	8,
>> +	.reg_fields		=	&omap3_dispc_reg_fields,
>>  };
>>  
>>  static const struct dispc_features omap44xx_dispc_feats __initconst = {
>> @@ -4122,6 +4176,7 @@ static const struct dispc_features omap44xx_dispc_feats __initconst = {
>>  	.gfx_fifo_workaround	=	true,
>>  	.buffer_size_unit	=	16,
>>  	.burst_size_unit	=	16,
>> +	.reg_fields		=	&omap4_dispc_reg_fields,
>>  };
>>  
>>  static const struct dispc_features omap54xx_dispc_feats __initconst = {
>> @@ -4141,6 +4196,7 @@ static const struct dispc_features omap54xx_dispc_feats __initconst = {
>>  	.gfx_fifo_workaround	=	true,
>>  	.buffer_size_unit	=	16,
>>  	.burst_size_unit	=	16,
>> +	.reg_fields		=	&omap5_dispc_reg_fields,
>>  };
> 
> There's one thing to note here (and the same applies to DSI patches).
> The *_dispc_feats tables above are __initconst, and we make a copy of
> the needed table at probe time, so that the unneeded tables can be
> discarded. Now you add new tables, but they are not handled the same
> way. This is not a bug, but it's a bit inconsistent.
> 
> So I think we have three options:
> 
> - Make the new tables also __initconst, and create a copy of the needed
> tables, and fix up the pointers to point to the copied tables.
> 
> - Embed the new tables into the *_dispc_feats table, as you suggested
> previously. This would mean multiple copies of the same data in some cases.
> 
> - Remove the __initconst and the copy code.
> 
> I'm not sure which one to pick. The first one feels a bit complex, but
> perhaps it should be tried first to see how the actual code would look
> like. If it's just a few lines per table, I guess it's ok.
> 
>  Tomi
> 
> 

I would like to go with first approach. The code will look like this

static int __init dispc_init_features(struct platform_device *pdev)
{
.....................................
	const struct dispc_param_ranges *src_param;
	struct dispc_param_ranges *dst_param;

	dst_param = devm_kzalloc(&pdev->dev, sizeof(*dst_param), 	GFP_KERNEL);
	if (!dst_param) {
		dev_err(&pdev->dev, "Failed to allocate DISPC Param Ranges\n");
		return -ENOMEM;
	}

	switch (omapdss_get_version()) {
 	case OMAPDSS_VER_OMAP24xx:
 		src = &omap24xx_dispc_feats;
		src_param = &omap2_dispc_param_ranges;
 		break;
.............................
	}

	memcpy(dst, src, sizeof(*dst));
	memcpy(dst_param, src_param, sizeof(*dst_param));
	dst->params = dst_param;

 	dispc.feat = dst;

	return 0;
}

Yes, the code looks a bit complex but still well manageable.

-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
