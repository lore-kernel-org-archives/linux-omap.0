From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv3 8/17] dmtimer: register mappings moved to hwmod
 database
Date: Mon, 11 Oct 2010 12:38:20 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB035E970A11@dbde02.ent.ti.com>
References: <1285059226-26491-1-git-send-email-tarun.kanti@ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94027863D705@dbde02.ent.ti.com>
 <87mxr98nkg.fsf@deeprootsystems.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301F6FE83CE@dbde02.ent.ti.com>
 <4C9B8401.3070704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35165 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753127Ab0JKHIe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 03:08:34 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "Basak, Partha" <p-basak2@ti.com>

Benoit and Manju,

> -----Original Message-----
> From: DebBarma, Tarun Kanti
> Sent: Saturday, October 09, 2010 9:10 PM
> To: Cousson, Benoit; Basak, Partha
> Cc: Kevin Hilman; G, Manjunath Kondaiah; linux-omap@vger.kernel.org;
> Shilimkar, Santosh; Paul Walmsley; Tony Lindgren
> Subject: RE: [PATCHv3 8/17] dmtimer: register mappings moved to hwmod
> database
> 
> Benoit,
> 
> > -----Original Message-----
> > From: Cousson, Benoit
> > Sent: Thursday, September 23, 2010 10:15 PM
> > To: Basak, Partha
> > Cc: Kevin Hilman; G, Manjunath Kondaiah; DebBarma, Tarun Kanti; linux-
> > omap@vger.kernel.org; Shilimkar, Santosh; Paul Walmsley; Tony Lindgren
> > Subject: Re: [PATCHv3 8/17] dmtimer: register mappings moved to hwmod
> > database
> >
> > On 9/23/2010 11:34 AM, Basak, Partha wrote:
> > >
> > >
> > >> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> > >> Sent: Thursday, September 23, 2010 3:10 AM
> > >>
> > >> "G, Manjunath Kondaiah"<manjugk@ti.com>  writes:
> > >>
> > >>> Hi Tarun,
> > >>>
> > >>>> From: linux-omap-owner@vger.kernel.org
> > >>>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> > >>>> DebBarma, Tarun Kanti
> > >>>>
> >
> > <...>
> >
> > >>>> +static u32 omap_timer_reg_map_v1[] = {
> > >>>> +  [OMAP_TIMER_ID_REG]             = (0x00 | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_OCP_CFG_REG]        = (0x10 | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_SYS_STAT_REG]       = (0x14 | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_STAT_REG]           = (0x18 | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_INT_EN_REG]         = (0x1c | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_WAKEUP_EN_REG]      = (0x20 | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_CTRL_REG]           = (0x24 | (WP_TCLR<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_COUNTER_REG]        = (0x28 | (WP_TCRR<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_LOAD_REG]           = (0x2c | (WP_TLDR<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_TRIGGER_REG]        = (0x30 | (WP_TTGR<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_WRITE_PEND_REG]     = (0x34 | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_MATCH_REG]          = (0x38 | (WP_TMAR<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_CAPTURE_REG]        = (0x3c | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_IF_CTRL_REG]        = (0x40 | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_CAPTURE2_REG]       = (0x44 | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_TICK_POS_REG]       = (0x48 | (WP_TPIR<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_TICK_NEG_REG]       = (0x4c | (WP_TNIR<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_TICK_COUNT_REG]     = (0x50 | (WP_TCVR<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_TICK_INT_MASK_SET_REG]      = (0x54 |
> > >>>> (WP_TOCR<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_TICK_INT_MASK_COUNT_REG]    = (0x58 |
> > >>>> (WP_TOWR<<  WPSHIFT)),
> > >>>> +};
> > >>>> +
> > >>>> +/* OMAP4 timers register map */
> > >>>> +static u32 omap_timer_reg_map_v2[] = {
> > >>>> +  [OMAP_TIMER_ID_REG]             = (0x00 | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_OCP_CFG_REG]        = (0x10 | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_SYS_STAT_REG]       = (0x14 | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_STAT_REG]           = (0x28 | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_INT_EN_REG]         = (0x2c | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_WAKEUP_EN_REG]      = (0x34 | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_CTRL_REG]           = (0x38 | (WP_TCLR<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_COUNTER_REG]        = (0x3c | (WP_TCRR<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_LOAD_REG]           = (0x40 | (WP_TLDR<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_TRIGGER_REG]        = (0x44 | (WP_TTGR<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_WRITE_PEND_REG]     = (0x48 | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_MATCH_REG]          = (0x4c | (WP_TMAR<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_CAPTURE_REG]        = (0x50 | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_IF_CTRL_REG]        = (0x54 | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_CAPTURE2_REG]       = (0x58 | (WP_NONE<<  WPSHIFT)),
> > >>>> +  [OMAP_TIMER_INT_CLR_REG]        = (0x30 | (WP_NONE<<  WPSHIFT)),
> > >>>> +};
> > >>>> +
> > >>>
> > >>> Why not these defines in mach-omap2/dmtimer.c? since
> > >> register offsets are
> > >>> same for omap2plus except omap4 which has additional
> > >> register offsets. Same
> > >>> register offsets are getting repeated in all the omap2plus
> > >> hwmod database.
> > >>
> > >> I agree with Manjunath.
> > >
> > > Manju, the number of tables needed to manage the information are same
> > really.
> > > Its only where they are located changes from the mach layer to the
> hwmod
> > > database. So, thats not the point. dev_attrs are pointing to the reg-
> map
> > > tables, they are not duplicating them.
> > >
> > >
> > > The offset differences are stemming from the IP differences.
> > > To my understanding, only IP-integration specific idiosyncrasies into
> a
> > given
> > > SOC qualifiy as dev_attrs.
> > > IP specific details like reg-map information should be maintained
> within
> > the driver.
> > > So, this approach will break this paradigm&  also not follow existing
> > implementation
> > > of drivers which support this. A given driver may support a set of IPs
> > but still
> > > may cater to even non-OMAP platforms not supporting hwmod.
> > >
> > > However, if we see the general usage of dev_attrs, there is no clear
> > line of demarcation
> > > really what should make it and what should not, as is used to plug
> this
> > sort of
> > > small gotchas and reduce CPU checks in the code.
> >
> > You do not really need that to reduce the CPU check in the code.
> > In that case, only the IP version should be stored in the dev_attr.
> > Based on that IP version, you know exactly what register map you have to
> > handle. For the moment you just have 2 layouts to handle + the extra
> > register for the 1ms timers.
> >
> > Also, I'm not sure that you have to handle each register separately
> > considering that you have one offset to handle for the functional
> > register.
> > The change in sysconfig and interrupt register are all standard mapping
> > that stick to TI highlander standard.
> > Meaning, as soon as an IP is a v2 (highlander version) all these
> > registers will be at the same place... at least in theory :-)
> >
> > Here are the deltas between the legacy and the new one:
> >
> > [OMAP_TIMER_ID_REG]             0x00,
> > [OMAP_TIMER_OCP_CFG_REG]        0x10, same
> > [OMAP_TIMER_SYS_STAT_REG]       0x14, (not used anymore)
> >
> > You should not care about these ones, because hwmod will handle them.
> >
> > [OMAP_TIMER_STAT_REG]           0x28, +10
> > [OMAP_TIMER_INT_EN_REG]         0x2c, +10
> > [OMAP_TIMER_INT_CLR_REG]        0x30, (new)
> >
> > These ones are standard registers
> >
> > [OMAP_TIMER_WAKEUP_EN_REG]      0x34, +14
> > [OMAP_TIMER_CTRL_REG]           0x38, +14
> > [OMAP_TIMER_COUNTER_REG]        0x3c, +14
> > [OMAP_TIMER_LOAD_REG]           0x40, +14
> > [OMAP_TIMER_TRIGGER_REG]        0x44, +14
> > [OMAP_TIMER_WRITE_PEND_REG]     0x48, +14
> > [OMAP_TIMER_MATCH_REG]          0x4c, +14
> > [OMAP_TIMER_CAPTURE_REG]        0x50, +14
> > [OMAP_TIMER_IF_CTRL_REG]        0x54, +14
> > [OMAP_TIMER_CAPTURE2_REG]       0x58, +14
> >
> > You can probably handle that with only 2 offsets instead of having one
> > address per registers.
> >
> To keep aligned with other driver implementations, I would like to follow
> this:
> 
> 1) move the table in mach-omap1/2 since
> 2) remove entries which are handled by hwmod.
> However, I am not sure if there is any issue in keeping them in the table.
Hmm... I have second thought on this implementation and I need your inputs.
If I go with the above implementation then I would end up having duplicate tables for mach-omap1 and mach-omap2. I have looked at the I2C implementation and would like to follow this implementation where they have two tables in plat:
One for OMAP1/2/3 and second for OMAP4.

-tarun
