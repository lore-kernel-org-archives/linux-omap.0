From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCHv3 8/17] dmtimer: register mappings moved to hwmod
 database
Date: Tue, 12 Oct 2010 11:47:29 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DBBA1482@dbde02.ent.ti.com>
References: <1285059226-26491-1-git-send-email-tarun.kanti@ti.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94027863D705@dbde02.ent.ti.com>
 <87mxr98nkg.fsf@deeprootsystems.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301F6FE83CE@dbde02.ent.ti.com>
 <4C9B8401.3070704@ti.com>
  <5A47E75E594F054BAF48C5E4FC4B92AB035E970A11@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44021 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752539Ab0JLGRi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Oct 2010 02:17:38 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB035E970A11@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "Basak, Partha" <p-basak2@ti.com>



> -----Original Message-----
> From: DebBarma, Tarun Kanti 
> Sent: Monday, October 11, 2010 12:38 PM
> To: Cousson, Benoit
> Cc: Kevin Hilman; G, Manjunath Kondaiah; 
> linux-omap@vger.kernel.org; Shilimkar, Santosh; Paul 
> Walmsley; Tony Lindgren; Basak, Partha
> Subject: RE: [PATCHv3 8/17] dmtimer: register mappings moved 
> to hwmod database
> 
> Benoit and Manju,
[...]
> > >
> > > You do not really need that to reduce the CPU check in the code.
> > > In that case, only the IP version should be stored in the 
> dev_attr.
> > > Based on that IP version, you know exactly what register map you 
> > > have to handle. For the moment you just have 2 layouts to 
> handle + 
> > > the extra register for the 1ms timers.
> > >
> > > Also, I'm not sure that you have to handle each register 
> separately 
> > > considering that you have one offset to handle for the functional 
> > > register.
> > > The change in sysconfig and interrupt register are all standard 
> > > mapping that stick to TI highlander standard.
> > > Meaning, as soon as an IP is a v2 (highlander version) all these 
> > > registers will be at the same place... at least in theory :-)
> > >
> > > Here are the deltas between the legacy and the new one:
> > >
> > > [OMAP_TIMER_ID_REG]             0x00,
> > > [OMAP_TIMER_OCP_CFG_REG]        0x10, same
> > > [OMAP_TIMER_SYS_STAT_REG]       0x14, (not used anymore)
> > >
> > > You should not care about these ones, because hwmod will 
> handle them.
> > >
> > > [OMAP_TIMER_STAT_REG]           0x28, +10
> > > [OMAP_TIMER_INT_EN_REG]         0x2c, +10
> > > [OMAP_TIMER_INT_CLR_REG]        0x30, (new)
> > >
> > > These ones are standard registers
> > >
> > > [OMAP_TIMER_WAKEUP_EN_REG]      0x34, +14
> > > [OMAP_TIMER_CTRL_REG]           0x38, +14
> > > [OMAP_TIMER_COUNTER_REG]        0x3c, +14
> > > [OMAP_TIMER_LOAD_REG]           0x40, +14
> > > [OMAP_TIMER_TRIGGER_REG]        0x44, +14
> > > [OMAP_TIMER_WRITE_PEND_REG]     0x48, +14
> > > [OMAP_TIMER_MATCH_REG]          0x4c, +14
> > > [OMAP_TIMER_CAPTURE_REG]        0x50, +14
> > > [OMAP_TIMER_IF_CTRL_REG]        0x54, +14
> > > [OMAP_TIMER_CAPTURE2_REG]       0x58, +14
> > >
> > > You can probably handle that with only 2 offsets instead 
> of having 
> > > one address per registers.
> > >
> > To keep aligned with other driver implementations, I would like to 
> > follow
> > this:
> > 
> > 1) move the table in mach-omap1/2 since
> > 2) remove entries which are handled by hwmod.
> > However, I am not sure if there is any issue in keeping 
> them in the table.
> Hmm... I have second thought on this implementation and I 
> need your inputs.
> If I go with the above implementation then I would end up 
> having duplicate tables for mach-omap1 and mach-omap2. I have 
> looked at the I2C implementation and would like to follow 
> this implementation where they have two tables in plat:
> One for OMAP1/2/3 and second for OMAP4.

1. register offset tables are in i2c-omap.c under drivers/i2c/busses
and not in plat.

2. i2c is different type of driver where register offsets are required
only in i2c-omap.c and not in plat. If you don't require register offsets
in mach-omapx or other places then it doesnot matter where you define 
these tables. Otherwise, it has to be in mach-omap2 since it should feed
omap_device_build so that, offsets can be accessed at other places.

-Manjunath