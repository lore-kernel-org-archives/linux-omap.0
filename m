From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: Re: [PATCH 2/7] OMAPDSS: DISPC: Move DISPC specific dss_reg_fields
 to dispc_features
Date: Fri, 30 Nov 2012 15:32:54 +0530
Message-ID: <50B8844E.2010903@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com> <a5bbbc9af3ef5ca2636d3c4dea6cbbe9834e0f62.1354086150.git.cmahapatra@ti.com> <50B74F98.2030108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35740 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193Ab2K3KGS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Nov 2012 05:06:18 -0500
In-Reply-To: <50B74F98.2030108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 29 November 2012 05:35 PM, Tomi Valkeinen wrote:
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
>>  
>>  #define DISPC_MAX_NR_FIFOS 5
>> @@ -1150,7 +1162,8 @@ static void dispc_init_fifos(void)
>>  
>>  	unit = dispc.feat->buffer_size_unit;
>>  
>> -	dss_feat_get_reg_field(FEAT_REG_FIFOSIZE, &start, &end);
>> +	start = dispc.feat->reg_fields[FEAT_REG_FIFOSIZE].start;
>> +	end = dispc.feat->reg_fields[FEAT_REG_FIFOSIZE].end;
>>  
>>  	for (fifo = 0; fifo < dispc.feat->num_fifos; ++fifo) {
>>  		size = REG_GET(DISPC_OVL_FIFO_SIZE_STATUS(fifo), start, end);
>> @@ -1214,8 +1227,10 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
>>  	low /= unit;
>>  	high /= unit;
>>  
>> -	dss_feat_get_reg_field(FEAT_REG_FIFOHIGHTHRESHOLD, &hi_start, &hi_end);
>> -	dss_feat_get_reg_field(FEAT_REG_FIFOLOWTHRESHOLD, &lo_start, &lo_end);
>> +	hi_start = dispc.feat->reg_fields[FEAT_REG_FIFOHIGHTHRESHOLD].start;
>> +	hi_end = dispc.feat->reg_fields[FEAT_REG_FIFOHIGHTHRESHOLD].end;
>> +	lo_start = dispc.feat->reg_fields[FEAT_REG_FIFOLOWTHRESHOLD].start;
>> +	lo_end = dispc.feat->reg_fields[FEAT_REG_FIFOLOWTHRESHOLD].end;
> 
> I think these are quite verbose. Perhaps a helper function which does
> the same as dss_feat_get_reg_field() would be better. Or alternatively,
> maybe something like:
> 
> const struct dss_reg_field *hi_field =
> &dispc.feat->reg_fields[FEAT_REG_FIFOHIGHTHRESHOLD];
> 
> and then use "hi_field.start" instead of hi_start.
> 
> Or something else that makes the above easier to read.

OK.

> 
>> diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
>> index 84a7f6a..aa273d8 100644
>> --- a/drivers/video/omap2/dss/dss.h
>> +++ b/drivers/video/omap2/dss/dss.h
>> @@ -143,6 +143,10 @@ struct reg_field {
>>  	u8 low;
>>  };
>>  
>> +struct register_field {
>> +	u8 start, end;
>> +};
>> +
> 
> We already have the dss_reg_field struct. I think it's better to move
> that to dss.h, and use it, instead of creating an exact duplicate.
> 
>  Tomi
> 
> 

register_field appears to be a more generic a name rather than
dss_reg_field. Also I was thinking to initialise

struct dispc_reg_fields {
	struct register_field firhinc;
	struct register_field firvinc;
	struct register_field fifo_low_threshold;
	...
};
 similarly, dss_reg_fields and dsi_reg_fields from register_field.

-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.
