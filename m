From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH 2/3] ARM: OMAP2+: onenand: cleanup for gpmc driver
 conversion
Date: Tue, 12 Jun 2012 06:16:14 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E997D47@DBDE01.ent.ti.com>
References: <cover.1339419244.git.afzal@ti.com>
 <2d6f0fb31cde98cd700d7a4268683b4aeeee87f2.1339419244.git.afzal@ti.com>
 <4FD63AAE.90008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39515 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069Ab2FLGT0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 02:19:26 -0400
In-Reply-To: <4FD63AAE.90008@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Jon,

On Tue, Jun 12, 2012 at 00:06:30, Hunter, Jon wrote:

> I agree with getting rid of the first instance at the beginning of
> _set_async_mode, but why get rid of the above one? Are you assuming that
> by default it is in async mode? Could be nice to keep it to be explicit.

Second one is achieved below

> > @@ -191,19 +181,21 @@ static int omap2_onenand_set_sync_mode(struct omap_onenand_platform_data *cfg,
> >  	u32 reg;
> >  	bool clk_dep = false;
> >  
> > +	/* Ensure sync read and sync write are disabled */
> > +	reg = readw(onenand_base + ONENAND_REG_SYS_CFG1);
> > +	reg &= ~ONENAND_SYS_CFG1_SYNC_READ & ~ONENAND_SYS_CFG1_SYNC_WRITE;
> > +	writew(reg, onenand_base + ONENAND_REG_SYS_CFG1);
> > +
> 
> Should we only set these after we have checked the flags and depending
> on which flags are set?

Even for sync mode, setting async mode initially is required

> > @@ -421,6 +413,8 @@ void __init gpmc_onenand_init(struct omap_onenand_platform_data *_onenand_data)
> >  	gpmc_onenand_resource.end = gpmc_onenand_resource.start +
> >  							ONENAND_IO_SIZE - 1;
> >  
> > +	omap2_onenand_set_async_mode(gpmc_onenand_data->cs);
> > +
> 
> What about putting this in the gpmc_onenand_setup() function before the
> call to _set_sync_mode? Seems nice to have these together.

Intention of this patch is to setup GPMC async mode before driver starts
its job so that reconfiguring GPMC needs to be to be done only once (this
helps in avoiding issues when it has to work with gpmc driver).

With the existing code, set_async was done as part of set_sync, hence
requiring GPMC to be configured twice after driver takes control, with
your suggestion too, GPMC would have to be configured twice.

Regards
Afzal
