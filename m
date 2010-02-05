From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCHv2 1/4] Regulator: OMAP: Creating TWL4030 file having
 supplies & init data
Date: Fri, 5 Feb 2010 12:23:35 +0200
Message-ID: <20100205102335.GD30421@esdhcp037198.research.nokia.com>
References: <1263287632-10135-1-git-send-email-anuj.aggarwal@ti.com>
 <20100205084501.GA30421@esdhcp037198.research.nokia.com>
 <1265364568.3177.3.camel@odin>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38926 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209Ab0BEKYI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Feb 2010 05:24:08 -0500
Content-Disposition: inline
In-Reply-To: <1265364568.3177.3.camel@odin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, ext Anuj Aggarwal <anuj.aggarwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>

On Fri, Feb 05, 2010 at 11:09:28AM +0100, Liam Girdwood wrote:
> On Fri, 2010-02-05 at 10:45 +0200, Eduardo Valentin wrote:
> > Hello Anuj,
> > 
> > First of all, I liked the idea of unifying the regulator definitions
> > for boards that use twl regulators.
> > 
> > But I guess we need to improve a little bit.
> > 
> > See following comments.
> > 
> > On Tue, Jan 12, 2010 at 10:13:52AM +0100, ext Anuj Aggarwal wrote:
> > > A new file for TWL4030/TPS65950 is created which has common supplies
> > > and regulator init data structures. They will be referenced from the
> > > various board-evm files depending upon the EVM requirements, using
> > > the twl4030-pmic.h header file.
> > > 
> > > Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
> > > ---
> > >  arch/arm/mach-omap2/twl4030-pmic.c |  175 ++++++++++++++++++++++++++++++++++++
> > >  arch/arm/mach-omap2/twl4030-pmic.h |   34 +++++++
> > >  2 files changed, 209 insertions(+), 0 deletions(-)
> > >  create mode 100644 arch/arm/mach-omap2/twl4030-pmic.c
> > >  create mode 100644 arch/arm/mach-omap2/twl4030-pmic.h
> > > 
> > > diff --git a/arch/arm/mach-omap2/twl4030-pmic.c b/arch/arm/mach-omap2/twl4030-pmic.c
> > > new file mode 100644
> > > index 0000000..0c0a860
> > > --- /dev/null
> > > +++ b/arch/arm/mach-omap2/twl4030-pmic.c
> > > @@ -0,0 +1,175 @@
> > > +/*
> > > + * twl4030-pmic.c
> > > + *
> > > + * Common regulator supplies and init data structs for TWL4030/TPS65950
> > > + * PMIC for OMAP3 based EVMs. They can be used in various board-evm
> > > + * files for OMAP3 based platforms using TWL4030.
> > > + *
> > > + * Copyright (C) 2010 Texas Instrument Incorporated - http://www.ti.com/
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> > > + * modify it under the terms of the GNU General Public License as
> > > + * published by the Free Software Foundation version 2.
> > > + *
> > > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any kind,
> > > + * whether express or implied; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > > + * General Public License for more details.
> > > + */
> > > +
> > > +#include <linux/regulator/machine.h>
> > > +
> > > +/* VDAC */
> > > +struct regulator_consumer_supply twl4030_vdac_supply = {
> > > +	.supply	= "vdac",
> > > +};
> > > +
> > > +/* VMMC1 */
> > > +struct regulator_consumer_supply twl4030_vmmc1_supply = {
> > > +	.supply	= "vmmc",
> > > +};
> > > +
> > > +/* VMMC2 */
> > > +struct regulator_consumer_supply twl4030_vmmc2_supply = {
> > > +	.supply	= "vmmc",
> > > +};
> > > +
> > > +/* VSIM */
> > > +struct regulator_consumer_supply twl4030_vsim_supply = {
> > > +	.supply	= "vmmc_aux",
> > > +};
> > > +
> > > +/* VPLL2 for digital video outputs */
> > > +struct regulator_consumer_supply twl4030_vpll2_supply = {
> > > +	.supply	= "vdvi",
> > > +};
> > 
> > 
> > Ohh no! This is not good! Defining here the supply list would make things harder.
> > Because from board to board the supply list will change! That's the
> > whole point of having the supply list. We can't share them for all boards
> > definitions.
> 
> OK, my understanding here was that this change was only to support a set
> of similar OMAP + TWL4030 boards and not *all* OMAP + TWL4030 boards.

Right. Yeah. Now I read patches carefully and that is the case. His patch
set is designed to board-evm's. Which I suppose is TI's boards.

But, can't we extend the set to keep the code available for all of them?

I guess that would be just a matter of defining the twl regulators inside twl4030-pmic.c
and exporting them via that header, but supplies are left for board specific code?

> 
> Anuj, what were your intentions here ?
> 
> Thanks
> 
> Liam
> 
> -- 
> Freelance Developer, SlimLogic Ltd
> ASoC and Voltage Regulator Maintainer.
> http://www.slimlogic.co.uk
> 

-- 
Eduardo Valentin
