From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: Re: [PATCH 1/4] OMAPDSS: Cleanup implementation of LCD channels
Date: Thu, 28 Jun 2012 16:49:05 +0530
Message-ID: <4FEC3DA9.9010405@ti.com>
References: <cover.1340874806.git.cmahapatra@ti.com>  <013a8d0a8698b3f971c5963115b03701141a4688.1340874806.git.cmahapatra@ti.com> <1340880649.5037.39.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:54344 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751589Ab2F1LTM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 07:19:12 -0400
Received: by obbwd20 with SMTP id wd20so4037445obb.37
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 04:19:11 -0700 (PDT)
In-Reply-To: <1340880649.5037.39.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Thursday 28 June 2012 04:20 PM, Tomi Valkeinen wrote:
> On Thu, 2012-06-28 at 15:10 +0530, Chandrabhanu Mahapatra wrote:
>> The current implementation of LCD channels and managers consists of a number of
>> if-else construct which has been replaced by a simpler interface. A constant
>> structure mgr_desc has been created in Display Controller (DISPC) module. The
>> mgr_desc contains for each channel its name, irqs and  is initialized one time
>> with all registers and their corresponding fields to be written to enable
>> various features of Display Subsystem. This structure is later used by various
>> functions of DISPC which simplifies the further implementation of LCD channels
>> and its corresponding managers.
>>
>> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
>> ---
>>  drivers/video/omap2/dss/dispc.c   |  233 +++++++++++++++++--------------------
>>  drivers/video/omap2/dss/dsi.c     |    6 +-
>>  drivers/video/omap2/dss/dss.h     |    6 +
>>  drivers/video/omap2/dss/manager.c |   12 +--
>>  4 files changed, 121 insertions(+), 136 deletions(-)
>>
>> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
>> index 4749ac3..6c16b81 100644
>> --- a/drivers/video/omap2/dss/dispc.c
>> +++ b/drivers/video/omap2/dss/dispc.c
>> @@ -57,6 +57,8 @@
>>  
>>  #define DISPC_MAX_NR_ISRS		8
>>  
>> +#define DISPC_MGR_FLD_MAX		9
> You could have this in the enum mgr_ref_fields, as a last entry. Then
> it'll automatically have the value 9, and will adjust automatically when
> we add new fields. And actually "MAX" is not quite right. MAX would be
> 8, as that's the maximum value for the vields. "NUM" is perhaps more
> correct.
Its really a clever idea to have it as the last field of enum
mgr_ref_fields. To make it distinct from other fields I can add a
comment on top of it saying its for count of above fields or I am fine
with names as DISPC_MGR_FLD_COUNT / NUM.
>  
>> +
>>  struct omap_dispc_isr_data {
>>  	omap_dispc_isr_t	isr;
>>  	void			*arg;
>> @@ -119,6 +121,78 @@ enum omap_color_component {
>>  	DISPC_COLOR_COMPONENT_UV		= 1 << 1,
>>  };
>>  
>> +enum mgr_reg_fields {
>> +	DISPC_MGR_FLD_ENABLE,
>> +	DISPC_MGR_FLD_STNTFT,
>> +	DISPC_MGR_FLD_GO,
>> +	DISPC_MGR_FLD_TFTDATALINES,
>> +	DISPC_MGR_FLD_STALLMODE,
>> +	DISPC_MGR_FLD_TCKENABLE,
>> +	DISPC_MGR_FLD_TCKSELECTION,
>> +	DISPC_MGR_FLD_CPR,
>> +	DISPC_MGR_FLD_FIFOHANDCHECK,
>> +};
>> +
>> +static const struct {
>> +	const char *name;
>> +	u32 vsync_irq;
>> +	u32 framedone_irq;
>> +	u32 sync_lost_irq;
>> +	struct reg_field reg_desc[DISPC_MGR_FLD_MAX];
>> +} mgr_desc[] = {
>> +	[OMAP_DSS_CHANNEL_LCD] = {
>> +		.name		= "LCD",
>> +		.vsync_irq	= DISPC_IRQ_VSYNC,
>> +		.framedone_irq	= DISPC_IRQ_FRAMEDONE,
>> +		.sync_lost_irq	= DISPC_IRQ_SYNC_LOST,
>> +		.reg_desc	= {
>> +			[DISPC_MGR_FLD_ENABLE]		= { DISPC_CONTROL,  0,  0 },
>> +			[DISPC_MGR_FLD_STNTFT]		= { DISPC_CONTROL,  3,  3 },
>> +			[DISPC_MGR_FLD_GO]		= { DISPC_CONTROL,  5,  5 },
>> +			[DISPC_MGR_FLD_TFTDATALINES]	= { DISPC_CONTROL,  9,  8 },
>> +			[DISPC_MGR_FLD_STALLMODE]	= { DISPC_CONTROL, 11, 11 },
>> +			[DISPC_MGR_FLD_TCKENABLE]	= { DISPC_CONFIG,  10, 10 },
>> +			[DISPC_MGR_FLD_TCKSELECTION]	= { DISPC_CONFIG,  11, 11 },
>> +			[DISPC_MGR_FLD_CPR]		= { DISPC_CONFIG,  15, 15 },
>> +			[DISPC_MGR_FLD_FIFOHANDCHECK]	= { DISPC_CONFIG,  16, 16 },
>> +		},
>> +	},
>> +	[OMAP_DSS_CHANNEL_DIGIT] = {
>> +		.name		= "DIGIT",
>> +		.vsync_irq	= DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN,
>> +		.framedone_irq	= DISPC_IRQ_FRAMEDONETV,
> There's a problem with this one. FRAMEDONETV is a new thing, appeared in
> omap4. So for this we need a system to select the data depending on the
> DSS version.
>
> I suggest you remove the framedone_irq entry for now, and keep the old
> code to handle the framedone irq. Let's add it later when we can handle
> the differences between omap versions.
>
> Or actually, looking at the code, perhaps you can keep the framedone_irq
> field, but set it to 0 for DIGIT mgr. This would keep the functionality
> the same as it is now, because there's only one place in dispc.c where
> we use FRAMEDONETV, and your patch doesn't touch it. In other places we
> presume that TV out does not have FRAMEDONE interrupt (i.e. the irq
> number is 0).
The purpose of FRAMEDONETV IRQ as seen from dispc_mgr_enable_digit_out()
looks as to interrupt when active frame related to HDMI is done and so
DISPC is disabled. I think I misinterpreted  and used it here. Can
please explain the exact purpose of DISPC_IRQ_FRAMEDONETV?
>> +		.sync_lost_irq	= DISPC_IRQ_SYNC_LOST_DIGIT,
>> +		.reg_desc	= {
>> +			[DISPC_MGR_FLD_ENABLE]		= { DISPC_CONTROL,  1,  1 },
>> +			[DISPC_MGR_FLD_STNTFT]		= { },
>> +			[DISPC_MGR_FLD_GO]		= { DISPC_CONTROL,  6,  6 },
>> +			[DISPC_MGR_FLD_TFTDATALINES]	= { },
>> +			[DISPC_MGR_FLD_STALLMODE]	= { },
>> +			[DISPC_MGR_FLD_TCKENABLE]	= { DISPC_CONFIG,  12, 12 },
>> +			[DISPC_MGR_FLD_TCKSELECTION]	= { DISPC_CONFIG,  13, 13 },
>> +			[DISPC_MGR_FLD_CPR]		= { },
>> +			[DISPC_MGR_FLD_FIFOHANDCHECK]	= { DISPC_CONFIG,  16, 16 },
>> +		},
>> +	},
>> +	[OMAP_DSS_CHANNEL_LCD2] = {
>> +		.name		= "LCD2",
>> +		.vsync_irq	= DISPC_IRQ_VSYNC2,
>> +		.framedone_irq	= DISPC_IRQ_FRAMEDONE2,
>> +		.sync_lost_irq	= DISPC_IRQ_SYNC_LOST2,
>> +		.reg_desc	= {
>> +			[DISPC_MGR_FLD_ENABLE]		= { DISPC_CONTROL2,  0,  0 },
>> +			[DISPC_MGR_FLD_STNTFT]		= { DISPC_CONTROL2,  3,  3 },
>> +			[DISPC_MGR_FLD_GO]		= { DISPC_CONTROL2,  5,  5 },
>> +			[DISPC_MGR_FLD_TFTDATALINES]	= { DISPC_CONTROL2,  9,  8 },
>> +			[DISPC_MGR_FLD_STALLMODE]	= { DISPC_CONTROL2, 11, 11 },
>> +			[DISPC_MGR_FLD_TCKENABLE]	= { DISPC_CONFIG2,  10, 10 },
>> +			[DISPC_MGR_FLD_TCKSELECTION]	= { DISPC_CONFIG2,  11, 11 },
>> +			[DISPC_MGR_FLD_CPR]		= { DISPC_CONFIG2,  15, 15 },
>> +			[DISPC_MGR_FLD_FIFOHANDCHECK]	= { DISPC_CONFIG2,  16, 16 },
>> +		},
>> +	},
>> +};
>> +
>>  static void _omap_dispc_set_irqs(void);
>>  
>>  static inline void dispc_write_reg(const u16 idx, u32 val)
>> @@ -131,6 +205,19 @@ static inline u32 dispc_read_reg(const u16 idx)
>>  	return __raw_readl(dispc.base + idx);
>>  }
>>  
>> +static u32 mgr_fld_read(enum omap_channel channel, enum mgr_reg_fields regfld)
>> +{
>> +	const struct reg_field rfld = mgr_desc[channel].reg_desc[regfld];
>> +	return FLD_GET(dispc_read_reg(rfld.reg), rfld.high, rfld.low);
> This could use REG_GET(), instead of FLD_GET(dispc_read_reg(...))
ok.
>
>> +}
>> +
>> +static void mgr_fld_write(enum omap_channel channel,
>> +					enum mgr_reg_fields regfld, int val) {
>> +	const struct reg_field rfld = mgr_desc[channel].reg_desc[regfld];
>> +	dispc_write_reg(rfld.reg, FLD_MOD(dispc_read_reg(rfld.reg), val,
>> +				rfld.high, rfld.low));
>> +}
> And this one could use REG_FLD_MOD().
>
> Otherwise, looks good.
>
>  Tomi
>
ok.

-- 
Chandrabhanu Mahapatra
Texas Instruments India Pvt. Ltd.

