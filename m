From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 8/17] dmtimer: register mappings moved to hwmod database
Date: Wed, 22 Sep 2010 14:39:59 -0700
Message-ID: <87mxr98nkg.fsf@deeprootsystems.com>
References: <1285059226-26491-1-git-send-email-tarun.kanti@ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94027863D705@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52937 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab0IVVkD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 17:40:03 -0400
Received: by iwn5 with SMTP id 5so821159iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Sep 2010 14:40:02 -0700 (PDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027863D705@dbde02.ent.ti.com>
	(Manjunath Kondaiah G.'s message of "Thu, 23 Sep 2010 00:30:00 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

> Hi Tarun,
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
>> DebBarma, Tarun Kanti
>> Sent: Tuesday, September 21, 2010 2:24 PM
>> To: linux-omap@vger.kernel.org
>> Cc: DebBarma, Tarun Kanti; Basak, Partha; Shilimkar, Santosh; 
>> Cousson, Benoit; Paul Walmsley; Kevin Hilman; Tony Lindgren
>> Subject: [PATCHv3 8/17] dmtimer: register mappings moved to 
>> hwmod database
>> 
>> This patch adds dmtimer register mappings to hwmod database.
>> This is to avoid maintaining different several mappings 
>> within the omap-plat. The mapping is made available to 
>> platform through dev_attr during device build. The pointer to 
>> register map is preserved in the platform data.
>> 
>> Please note that the cleanup of register map from plat-omap 
>> will be removed in later patch after conversion to platform driver.
>> 
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Signed-off-by: Partha Basak <p-basak2@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Cousson, Benoit <b-cousson@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> ---
>>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |   25 ++++++++++
>>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |   25 ++++++++++
>>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   25 ++++++++++
>>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   67 
>> ++++++++++++++++++++++++---
>>  arch/arm/plat-omap/dmtimer.c               |   13 -----
>>  arch/arm/plat-omap/include/plat/dmtimer.h  |   38 ++++++++++++++++
>>  6 files changed, 172 insertions(+), 21 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c 
>> b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>> index 6003c2e..b3dd8ac 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
>> @@ -131,8 +131,33 @@ static char *timer_clk_src_names[] = {
>>  	NULL,
>>  };
>>  
>> +/* OMAP2/3 timers register map */
>> +static u32 omap_timer_reg_map_v1[] = {
>> +	[OMAP_TIMER_ID_REG]             = (0x00 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_OCP_CFG_REG]        = (0x10 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_SYS_STAT_REG]       = (0x14 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_STAT_REG]           = (0x18 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_INT_EN_REG]         = (0x1c | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_WAKEUP_EN_REG]      = (0x20 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_CTRL_REG]           = (0x24 | (WP_TCLR << WPSHIFT)),
>> +	[OMAP_TIMER_COUNTER_REG]        = (0x28 | (WP_TCRR << WPSHIFT)),
>> +	[OMAP_TIMER_LOAD_REG]           = (0x2c | (WP_TLDR << WPSHIFT)),
>> +	[OMAP_TIMER_TRIGGER_REG]        = (0x30 | (WP_TTGR << WPSHIFT)),
>> +	[OMAP_TIMER_WRITE_PEND_REG]     = (0x34 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_MATCH_REG]          = (0x38 | (WP_TMAR << WPSHIFT)),
>> +	[OMAP_TIMER_CAPTURE_REG]        = (0x3c | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_IF_CTRL_REG]        = (0x40 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_CAPTURE2_REG]       = (0x44 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_POS_REG]       = (0x48 | (WP_TPIR << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_NEG_REG]       = (0x4c | (WP_TNIR << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_COUNT_REG]     = (0x50 | (WP_TCVR << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_INT_MASK_SET_REG]      = (0x54 | 
>> (WP_TOCR << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_INT_MASK_COUNT_REG]    = (0x58 | 
>> (WP_TOWR << WPSHIFT)),
>> +};
>> +
>>  static struct omap_timer_dev_attr timer_dev_attr = {
>>  	.clk_names	= timer_clk_src_names,
>> +	.reg_map	= omap_timer_reg_map_v1,
>>  };
>>  
>>  static struct omap_hwmod_class_sysconfig omap2420_timer_sysc 
>> = { diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c 
>> b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> index 4b43fb9..787d3ce 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
>> @@ -137,8 +137,33 @@ static char *timer_clk_src_names[] = {
>>  	NULL
>>  };
>>  
>> +/* OMAP2/3 timers register map */
>> +static u32 omap_timer_reg_map_v1[] = {
>> +	[OMAP_TIMER_ID_REG]             = (0x00 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_OCP_CFG_REG]        = (0x10 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_SYS_STAT_REG]       = (0x14 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_STAT_REG]           = (0x18 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_INT_EN_REG]         = (0x1c | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_WAKEUP_EN_REG]      = (0x20 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_CTRL_REG]           = (0x24 | (WP_TCLR << WPSHIFT)),
>> +	[OMAP_TIMER_COUNTER_REG]        = (0x28 | (WP_TCRR << WPSHIFT)),
>> +	[OMAP_TIMER_LOAD_REG]           = (0x2c | (WP_TLDR << WPSHIFT)),
>> +	[OMAP_TIMER_TRIGGER_REG]        = (0x30 | (WP_TTGR << WPSHIFT)),
>> +	[OMAP_TIMER_WRITE_PEND_REG]     = (0x34 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_MATCH_REG]          = (0x38 | (WP_TMAR << WPSHIFT)),
>> +	[OMAP_TIMER_CAPTURE_REG]        = (0x3c | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_IF_CTRL_REG]        = (0x40 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_CAPTURE2_REG]       = (0x44 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_POS_REG]       = (0x48 | (WP_TPIR << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_NEG_REG]       = (0x4c | (WP_TNIR << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_COUNT_REG]     = (0x50 | (WP_TCVR << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_INT_MASK_SET_REG]      = (0x54 | 
>> (WP_TOCR << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_INT_MASK_COUNT_REG]    = (0x58 | 
>> (WP_TOWR << WPSHIFT)),
>> +};
>> +
>>  static struct omap_timer_dev_attr timer_dev_attr = {
>>  	.clk_names	= timer_clk_src_names,
>> +	.reg_map	= omap_timer_reg_map_v1,
>>  };
>>  
>>  static struct omap_hwmod_class_sysconfig omap2430_timer_sysc 
>> = { diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c 
>> b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> index 70446d7..e477ce8 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>> @@ -109,8 +109,33 @@ static char *timer_clk_src_names[] = {
>>  	NULL,
>>  };
>>  
>> +/* OMAP2/3 timers register map */
>> +static u32 omap_timer_reg_map_v1[] = {
>> +	[OMAP_TIMER_ID_REG]             = (0x00 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_OCP_CFG_REG]        = (0x10 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_SYS_STAT_REG]       = (0x14 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_STAT_REG]           = (0x18 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_INT_EN_REG]         = (0x1c | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_WAKEUP_EN_REG]      = (0x20 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_CTRL_REG]           = (0x24 | (WP_TCLR << WPSHIFT)),
>> +	[OMAP_TIMER_COUNTER_REG]        = (0x28 | (WP_TCRR << WPSHIFT)),
>> +	[OMAP_TIMER_LOAD_REG]           = (0x2c | (WP_TLDR << WPSHIFT)),
>> +	[OMAP_TIMER_TRIGGER_REG]        = (0x30 | (WP_TTGR << WPSHIFT)),
>> +	[OMAP_TIMER_WRITE_PEND_REG]     = (0x34 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_MATCH_REG]          = (0x38 | (WP_TMAR << WPSHIFT)),
>> +	[OMAP_TIMER_CAPTURE_REG]        = (0x3c | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_IF_CTRL_REG]        = (0x40 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_CAPTURE2_REG]       = (0x44 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_POS_REG]       = (0x48 | (WP_TPIR << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_NEG_REG]       = (0x4c | (WP_TNIR << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_COUNT_REG]     = (0x50 | (WP_TCVR << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_INT_MASK_SET_REG]      = (0x54 | 
>> (WP_TOCR << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_INT_MASK_COUNT_REG]    = (0x58 | 
>> (WP_TOWR << WPSHIFT)),
>> +};
>> +
>>  static struct omap_timer_dev_attr timer_dev_attr = {
>>  	.clk_names	= timer_clk_src_names,
>> +	.reg_map	= omap_timer_reg_map_v1,
>>  };
>>  
>>  /* timer class */
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
>> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> index 7c68228..1f60f8a 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -471,12 +471,63 @@ static char *timer_clk_src_names_abe[] = {
>>  	NULL,
>>  };
>>  
>> -static struct omap_timer_dev_attr timer_dev_attr = {
>> +/* OMAP2/3 timers register map */
>> +static u32 omap_timer_reg_map_v1[] = {
>> +	[OMAP_TIMER_ID_REG]             = (0x00 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_OCP_CFG_REG]        = (0x10 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_SYS_STAT_REG]       = (0x14 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_STAT_REG]           = (0x18 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_INT_EN_REG]         = (0x1c | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_WAKEUP_EN_REG]      = (0x20 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_CTRL_REG]           = (0x24 | (WP_TCLR << WPSHIFT)),
>> +	[OMAP_TIMER_COUNTER_REG]        = (0x28 | (WP_TCRR << WPSHIFT)),
>> +	[OMAP_TIMER_LOAD_REG]           = (0x2c | (WP_TLDR << WPSHIFT)),
>> +	[OMAP_TIMER_TRIGGER_REG]        = (0x30 | (WP_TTGR << WPSHIFT)),
>> +	[OMAP_TIMER_WRITE_PEND_REG]     = (0x34 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_MATCH_REG]          = (0x38 | (WP_TMAR << WPSHIFT)),
>> +	[OMAP_TIMER_CAPTURE_REG]        = (0x3c | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_IF_CTRL_REG]        = (0x40 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_CAPTURE2_REG]       = (0x44 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_POS_REG]       = (0x48 | (WP_TPIR << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_NEG_REG]       = (0x4c | (WP_TNIR << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_COUNT_REG]     = (0x50 | (WP_TCVR << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_INT_MASK_SET_REG]      = (0x54 | 
>> (WP_TOCR << WPSHIFT)),
>> +	[OMAP_TIMER_TICK_INT_MASK_COUNT_REG]    = (0x58 | 
>> (WP_TOWR << WPSHIFT)),
>> +};
>> +
>> +/* OMAP4 timers register map */
>> +static u32 omap_timer_reg_map_v2[] = {
>> +	[OMAP_TIMER_ID_REG]             = (0x00 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_OCP_CFG_REG]        = (0x10 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_SYS_STAT_REG]       = (0x14 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_STAT_REG]           = (0x28 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_INT_EN_REG]         = (0x2c | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_WAKEUP_EN_REG]      = (0x34 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_CTRL_REG]           = (0x38 | (WP_TCLR << WPSHIFT)),
>> +	[OMAP_TIMER_COUNTER_REG]        = (0x3c | (WP_TCRR << WPSHIFT)),
>> +	[OMAP_TIMER_LOAD_REG]           = (0x40 | (WP_TLDR << WPSHIFT)),
>> +	[OMAP_TIMER_TRIGGER_REG]        = (0x44 | (WP_TTGR << WPSHIFT)),
>> +	[OMAP_TIMER_WRITE_PEND_REG]     = (0x48 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_MATCH_REG]          = (0x4c | (WP_TMAR << WPSHIFT)),
>> +	[OMAP_TIMER_CAPTURE_REG]        = (0x50 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_IF_CTRL_REG]        = (0x54 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_CAPTURE2_REG]       = (0x58 | (WP_NONE << WPSHIFT)),
>> +	[OMAP_TIMER_INT_CLR_REG]        = (0x30 | (WP_NONE << WPSHIFT)),
>> +};
>> +
>
> Why not these defines in mach-omap2/dmtimer.c? since register offsets are
> same for omap2plus except omap4 which has additional register offsets. Same
> register offsets are getting repeated in all the omap2plus hwmod database.

I agree with Manjunath.

> As kevin suggested for DMA hwmod, i2c driver is already using these defines
> in .c file even though register offsets are different within omap2plus processors.
> through dev structure.
>
> Can we have similar kind of usage for all upcoming driver hwmod adaptations?

Yes please.

hwmod is not the place for register definitions, specially when OMAP4 is
the only difference.

Kevin

