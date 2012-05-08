From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH v4-alt 3/6] ARM: OMAP3: hwmod data: add gpmc
Date: Tue, 8 May 2012 09:32:33 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205080915220.9984@utopia.booyaka.com>
References: <cover.1335941443.git.afzal@ti.com> <99ffbbcc634022ed3c781c37e03989f1d898003e.1335941444.git.afzal@ti.com> <alpine.DEB.2.00.1205051949290.20926@utopia.booyaka.com> <C8443D0743D26F4388EA172BF4E2A7A93E987188@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56303 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755460Ab2EHPce (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 11:32:34 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E987188@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 7 May 2012, Mohammed, Afzal wrote:

> On Sun, May 06, 2012 at 07:34:07, Paul Walmsley wrote:

(attribution lost)

> > > +static struct omap_hwmod omap3xxx_gpmc_hwmod = {
> > > +	.name		= "gpmc",
> > > +	.class		= &omap3xxx_gpmc_hwmod_class,
> > > +	.clkdm_name	= "l3_init_clkdm",
> > > +	.mpu_irqs	= omap3xxx_gpmc_irqs,
> > > +	.main_clk	= "gpmc_fck",
> > > +	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
> > > +};
> > 
> > Is there some reason why you are setting the HWMOD_INIT_NO_RESET flag 
> > here?  Seems to me that the kernel should not rely on the bootloader GPMC 
> > configuration, but should use a configuration from the board file or DT.
> 
> Major reason was that there are some boards that rely on bootloader
> settings, eg. kernel does not do any setting for smsc911x. I did not
> want to break those, at least it causes problem with omap3evm, see below

But this is the whole point.  The Linux GPMC driver and integration code 
should be setting up the GPMC registers based on board file and/or DT 
data, before the kernel touches any GPMC devices.

We don't want to rely on the bootloader settings unless we absolutely have 
no other choice.  Otherwise, the stability of the kernel could easily be 
impacted by the bootloader's GPMC timings and other register settings, and 
we want to minimize those potential sources of variation.

So if we absolutely have no choice than to keep HWMOD_INIT_NO_RESET here, 
which doesn't sound like the case so far, we need to understand exactly 
why this is so.

> Removing it causes multiple problems, one is that CS0 is valid after 
> reset of module, with base address starting from zero, which causes 
> requesting resource failure for CS0, with the way it is currently coded 
> (GPMC resource starts from 1MB).

Can't this be handled by using a custom hwmod reset function for the GPMC?

> Even upon skipping CS0, kernel oops at seemingly unrelated location as 
> follows, probably due to gpmc reset, as bootloader configured values are 
> modified to reset value.  Omap3 evm uses smsc911x.

Sounds like you've got a good test platform, then :-)

> Another issue on OMAP3EVM is the detection of evm revision based on phy id,
> by reading hardcoded address, 0x2c000000. It had to be skipped to reach till
> above mentioned.

Looking at omap3_evm_get_revision() it seems that the OMAP3EVM detection 
happens by reading the Ethernet chip's revision register.  So can't this 
be fixed by programming the GPMC appropriately to access the Ethernet 
chip first?


- Paul
