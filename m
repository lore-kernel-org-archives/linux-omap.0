From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: [PATCHv3 8/17] dmtimer: register mappings moved to hwmod
 database
Date: Thu, 23 Sep 2010 15:04:10 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301F6FE83CE@dbde02.ent.ti.com>
References: <1285059226-26491-1-git-send-email-tarun.kanti@ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94027863D705@dbde02.ent.ti.com>
 <87mxr98nkg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33686 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390Ab0IWJeT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 05:34:19 -0400
In-Reply-To: <87mxr98nkg.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Thursday, September 23, 2010 3:10 AM
> To: G, Manjunath Kondaiah
> Cc: DebBarma, Tarun Kanti; linux-omap@vger.kernel.org; Basak, 
> Partha; Shilimkar, Santosh; Cousson, Benoit; Paul Walmsley; 
> Tony Lindgren
> Subject: Re: [PATCHv3 8/17] dmtimer: register mappings moved 
> to hwmod database
> 
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> > Hi Tarun,
> >
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org 
> >> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of 
> >> DebBarma, Tarun Kanti
> >> Sent: Tuesday, September 21, 2010 2:24 PM
> >> To: linux-omap@vger.kernel.org
> >> Cc: DebBarma, Tarun Kanti; Basak, Partha; Shilimkar, Santosh; 
> >> Cousson, Benoit; Paul Walmsley; Kevin Hilman; Tony Lindgren
> >> Subject: [PATCHv3 8/17] dmtimer: register mappings moved to 
> >> hwmod database
> >> 
> >> This patch adds dmtimer register mappings to hwmod database.
> >> This is to avoid maintaining different several mappings 
> >> within the omap-plat. The mapping is made available to 
> >> platform through dev_attr during device build. The pointer to 
> >> register map is preserved in the platform data.
> >> 
> >> Please note that the cleanup of register map from plat-omap 
> >> will be removed in later patch after conversion to platform driver.
> >> 
> >> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> >> Signed-off-by: Partha Basak <p-basak2@ti.com>
> >> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> Cc: Cousson, Benoit <b-cousson@ti.com>
> >> Cc: Paul Walmsley <paul@pwsan.com>
> >> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> >> Cc: Tony Lindgren <tony@atomide.com>
> >> ---
> >>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |   25 ++++++++++
> >>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |   25 ++++++++++
> >>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   25 ++++++++++
> >>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   67 
> >> ++++++++++++++++++++++++---
> >>  arch/arm/plat-omap/dmtimer.c               |   13 -----
> >>  arch/arm/plat-omap/include/plat/dmtimer.h  |   38 ++++++++++++++++
> >>  6 files changed, 172 insertions(+), 21 deletions(-)
> >> 
> >> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c 
> >> b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> >> index 6003c2e..b3dd8ac 100644
> >> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> >> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> >> @@ -131,8 +131,33 @@ static char *timer_clk_src_names[] = {
> >>  	NULL,
> >>  };
> >>  
> >> +/* OMAP2/3 timers register map */
> >> +static u32 omap_timer_reg_map_v1[] = {
> >> +	[OMAP_TIMER_ID_REG]             = (0x00 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_OCP_CFG_REG]        = (0x10 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_SYS_STAT_REG]       = (0x14 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_STAT_REG]           = (0x18 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_INT_EN_REG]         = (0x1c | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_WAKEUP_EN_REG]      = (0x20 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_CTRL_REG]           = (0x24 | (WP_TCLR << WPSHIFT)),
> >> +	[OMAP_TIMER_COUNTER_REG]        = (0x28 | (WP_TCRR << WPSHIFT)),
> >> +	[OMAP_TIMER_LOAD_REG]           = (0x2c | (WP_TLDR << WPSHIFT)),
> >> +	[OMAP_TIMER_TRIGGER_REG]        = (0x30 | (WP_TTGR << WPSHIFT)),
> >> +	[OMAP_TIMER_WRITE_PEND_REG]     = (0x34 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_MATCH_REG]          = (0x38 | (WP_TMAR << WPSHIFT)),
> >> +	[OMAP_TIMER_CAPTURE_REG]        = (0x3c | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_IF_CTRL_REG]        = (0x40 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_CAPTURE2_REG]       = (0x44 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_POS_REG]       = (0x48 | (WP_TPIR << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_NEG_REG]       = (0x4c | (WP_TNIR << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_COUNT_REG]     = (0x50 | (WP_TCVR << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_INT_MASK_SET_REG]      = (0x54 | 
> >> (WP_TOCR << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_INT_MASK_COUNT_REG]    = (0x58 | 
> >> (WP_TOWR << WPSHIFT)),
> >> +};
> >> +
> >>  static struct omap_timer_dev_attr timer_dev_attr = {
> >>  	.clk_names	= timer_clk_src_names,
> >> +	.reg_map	= omap_timer_reg_map_v1,
> >>  };
> >>  
> >>  static struct omap_hwmod_class_sysconfig omap2420_timer_sysc 
> >> = { diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c 
> >> b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> >> index 4b43fb9..787d3ce 100644
> >> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> >> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> >> @@ -137,8 +137,33 @@ static char *timer_clk_src_names[] = {
> >>  	NULL
> >>  };
> >>  
> >> +/* OMAP2/3 timers register map */
> >> +static u32 omap_timer_reg_map_v1[] = {
> >> +	[OMAP_TIMER_ID_REG]             = (0x00 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_OCP_CFG_REG]        = (0x10 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_SYS_STAT_REG]       = (0x14 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_STAT_REG]           = (0x18 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_INT_EN_REG]         = (0x1c | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_WAKEUP_EN_REG]      = (0x20 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_CTRL_REG]           = (0x24 | (WP_TCLR << WPSHIFT)),
> >> +	[OMAP_TIMER_COUNTER_REG]        = (0x28 | (WP_TCRR << WPSHIFT)),
> >> +	[OMAP_TIMER_LOAD_REG]           = (0x2c | (WP_TLDR << WPSHIFT)),
> >> +	[OMAP_TIMER_TRIGGER_REG]        = (0x30 | (WP_TTGR << WPSHIFT)),
> >> +	[OMAP_TIMER_WRITE_PEND_REG]     = (0x34 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_MATCH_REG]          = (0x38 | (WP_TMAR << WPSHIFT)),
> >> +	[OMAP_TIMER_CAPTURE_REG]        = (0x3c | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_IF_CTRL_REG]        = (0x40 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_CAPTURE2_REG]       = (0x44 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_POS_REG]       = (0x48 | (WP_TPIR << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_NEG_REG]       = (0x4c | (WP_TNIR << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_COUNT_REG]     = (0x50 | (WP_TCVR << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_INT_MASK_SET_REG]      = (0x54 | 
> >> (WP_TOCR << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_INT_MASK_COUNT_REG]    = (0x58 | 
> >> (WP_TOWR << WPSHIFT)),
> >> +};
> >> +
> >>  static struct omap_timer_dev_attr timer_dev_attr = {
> >>  	.clk_names	= timer_clk_src_names,
> >> +	.reg_map	= omap_timer_reg_map_v1,
> >>  };
> >>  
> >>  static struct omap_hwmod_class_sysconfig omap2430_timer_sysc 
> >> = { diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c 
> >> b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> >> index 70446d7..e477ce8 100644
> >> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> >> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> >> @@ -109,8 +109,33 @@ static char *timer_clk_src_names[] = {
> >>  	NULL,
> >>  };
> >>  
> >> +/* OMAP2/3 timers register map */
> >> +static u32 omap_timer_reg_map_v1[] = {
> >> +	[OMAP_TIMER_ID_REG]             = (0x00 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_OCP_CFG_REG]        = (0x10 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_SYS_STAT_REG]       = (0x14 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_STAT_REG]           = (0x18 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_INT_EN_REG]         = (0x1c | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_WAKEUP_EN_REG]      = (0x20 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_CTRL_REG]           = (0x24 | (WP_TCLR << WPSHIFT)),
> >> +	[OMAP_TIMER_COUNTER_REG]        = (0x28 | (WP_TCRR << WPSHIFT)),
> >> +	[OMAP_TIMER_LOAD_REG]           = (0x2c | (WP_TLDR << WPSHIFT)),
> >> +	[OMAP_TIMER_TRIGGER_REG]        = (0x30 | (WP_TTGR << WPSHIFT)),
> >> +	[OMAP_TIMER_WRITE_PEND_REG]     = (0x34 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_MATCH_REG]          = (0x38 | (WP_TMAR << WPSHIFT)),
> >> +	[OMAP_TIMER_CAPTURE_REG]        = (0x3c | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_IF_CTRL_REG]        = (0x40 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_CAPTURE2_REG]       = (0x44 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_POS_REG]       = (0x48 | (WP_TPIR << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_NEG_REG]       = (0x4c | (WP_TNIR << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_COUNT_REG]     = (0x50 | (WP_TCVR << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_INT_MASK_SET_REG]      = (0x54 | 
> >> (WP_TOCR << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_INT_MASK_COUNT_REG]    = (0x58 | 
> >> (WP_TOWR << WPSHIFT)),
> >> +};
> >> +
> >>  static struct omap_timer_dev_attr timer_dev_attr = {
> >>  	.clk_names	= timer_clk_src_names,
> >> +	.reg_map	= omap_timer_reg_map_v1,
> >>  };
> >>  
> >>  /* timer class */
> >> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
> >> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> >> index 7c68228..1f60f8a 100644
> >> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> >> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> >> @@ -471,12 +471,63 @@ static char *timer_clk_src_names_abe[] = {
> >>  	NULL,
> >>  };
> >>  
> >> -static struct omap_timer_dev_attr timer_dev_attr = {
> >> +/* OMAP2/3 timers register map */
> >> +static u32 omap_timer_reg_map_v1[] = {
> >> +	[OMAP_TIMER_ID_REG]             = (0x00 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_OCP_CFG_REG]        = (0x10 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_SYS_STAT_REG]       = (0x14 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_STAT_REG]           = (0x18 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_INT_EN_REG]         = (0x1c | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_WAKEUP_EN_REG]      = (0x20 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_CTRL_REG]           = (0x24 | (WP_TCLR << WPSHIFT)),
> >> +	[OMAP_TIMER_COUNTER_REG]        = (0x28 | (WP_TCRR << WPSHIFT)),
> >> +	[OMAP_TIMER_LOAD_REG]           = (0x2c | (WP_TLDR << WPSHIFT)),
> >> +	[OMAP_TIMER_TRIGGER_REG]        = (0x30 | (WP_TTGR << WPSHIFT)),
> >> +	[OMAP_TIMER_WRITE_PEND_REG]     = (0x34 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_MATCH_REG]          = (0x38 | (WP_TMAR << WPSHIFT)),
> >> +	[OMAP_TIMER_CAPTURE_REG]        = (0x3c | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_IF_CTRL_REG]        = (0x40 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_CAPTURE2_REG]       = (0x44 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_POS_REG]       = (0x48 | (WP_TPIR << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_NEG_REG]       = (0x4c | (WP_TNIR << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_COUNT_REG]     = (0x50 | (WP_TCVR << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_INT_MASK_SET_REG]      = (0x54 | 
> >> (WP_TOCR << WPSHIFT)),
> >> +	[OMAP_TIMER_TICK_INT_MASK_COUNT_REG]    = (0x58 | 
> >> (WP_TOWR << WPSHIFT)),
> >> +};
> >> +
> >> +/* OMAP4 timers register map */
> >> +static u32 omap_timer_reg_map_v2[] = {
> >> +	[OMAP_TIMER_ID_REG]             = (0x00 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_OCP_CFG_REG]        = (0x10 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_SYS_STAT_REG]       = (0x14 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_STAT_REG]           = (0x28 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_INT_EN_REG]         = (0x2c | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_WAKEUP_EN_REG]      = (0x34 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_CTRL_REG]           = (0x38 | (WP_TCLR << WPSHIFT)),
> >> +	[OMAP_TIMER_COUNTER_REG]        = (0x3c | (WP_TCRR << WPSHIFT)),
> >> +	[OMAP_TIMER_LOAD_REG]           = (0x40 | (WP_TLDR << WPSHIFT)),
> >> +	[OMAP_TIMER_TRIGGER_REG]        = (0x44 | (WP_TTGR << WPSHIFT)),
> >> +	[OMAP_TIMER_WRITE_PEND_REG]     = (0x48 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_MATCH_REG]          = (0x4c | (WP_TMAR << WPSHIFT)),
> >> +	[OMAP_TIMER_CAPTURE_REG]        = (0x50 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_IF_CTRL_REG]        = (0x54 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_CAPTURE2_REG]       = (0x58 | (WP_NONE << WPSHIFT)),
> >> +	[OMAP_TIMER_INT_CLR_REG]        = (0x30 | (WP_NONE << WPSHIFT)),
> >> +};
> >> +
> >
> > Why not these defines in mach-omap2/dmtimer.c? since 
> register offsets are
> > same for omap2plus except omap4 which has additional 
> register offsets. Same
> > register offsets are getting repeated in all the omap2plus 
> hwmod database.
> 
> I agree with Manjunath.

Manju, the number of tables needed to manage the information are same really.
Its only where they are located changes from the mach layer to the hwmod
database. So, thats not the point. dev_attrs are pointing to the reg-map
tables, they are not duplicating them.


The offset differences are stemming from the IP differences. 
To my understanding, only IP-integration specific idiosyncrasies into a given
SOC qualifiy as dev_attrs.
IP specific details like reg-map information should be maintained within the driver.
So, this approach will break this paradigm & also not follow existing implementation
of drivers which support this. A given driver may support a set of IPs but still
may cater to even non-OMAP platforms not supporting hwmod.

However, if we see the general usage of dev_attrs, there is no clear line of demarcation
really what should make it and what should not, as is used to plug this sort of 
small gotchas and reduce CPU checks in the code.

We will revert back this change.

> 
> > As kevin suggested for DMA hwmod, i2c driver is already 
> using these defines
> > in .c file even though register offsets are different 
> within omap2plus processors.
> > through dev structure.
> >
> > Can we have similar kind of usage for all upcoming driver 
> hwmod adaptations?
> 
> Yes please.
> 
> hwmod is not the place for register definitions, specially 
> when OMAP4 is
> the only difference.
> 
> Kevin
> 
> 