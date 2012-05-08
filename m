From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4-alt 3/6] ARM: OMAP3: hwmod data: add gpmc
Date: Tue, 8 May 2012 13:12:07 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E987E55@DBDE01.ent.ti.com>
References: <cover.1335941443.git.afzal@ti.com>
 <99ffbbcc634022ed3c781c37e03989f1d898003e.1335941444.git.afzal@ti.com>
 <alpine.DEB.2.00.1205051949290.20926@utopia.booyaka.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E987188@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49111 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753815Ab2EHNMP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 09:12:15 -0400
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E987188@DBDE01.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

On Mon, May 07, 2012 at 16:42:16, Mohammed, Afzal wrote:

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
> 
> Major reason was that there are some boards that rely on bootloader
> settings, eg. kernel does not do any setting for smsc911x. I did not
> want to break those, at least it causes problem with omap3evm

If HWMOD_NO_INIT_RESET is not present, it would break GPMC on
many of the existing boards.

New version of GPMC HWMOD patch has been posted with HWMOD_NO_IDLEST flag,
which is a squashed one with OMAP2xxx HWMOD

Regards
AFzal
