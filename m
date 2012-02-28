From: Tony Lindgren <tony@atomide.com>
Subject: Re: More randconfig OMAP build errors
Date: Tue, 28 Feb 2012 14:46:23 -0800
Message-ID: <20120228224623.GG18901@atomide.com>
References: <20120228102229.GE18045@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40863 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456Ab2B1Wq0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 17:46:26 -0500
Content-Disposition: inline
In-Reply-To: <20120228102229.GE18045@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

Tomi,

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120228 01:50]:
> Todays randconfig found this:
> 
> drivers/video/omap2/displays/panel-dvi.c: In function 'panel_dvi_ddc_read':
> drivers/video/omap2/displays/panel-dvi.c:239: error: implicit declaration of function 'i2c_transfer'
> drivers/video/omap2/displays/panel-dvi.c: In function 'panel_dvi_read_edid':
> drivers/video/omap2/displays/panel-dvi.c:265: error: implicit declaration of function 'i2c_get_adapter'
> 
> caused by I2C being disabled.
> 
> There's also some warnings in arch/arm/mach-omap2/omap_l3_smx.c and
> drivers/video/omap2/dss/apply.c about unused variables:
> 
> arch/arm/mach-omap2/omap_l3_smx.c: In function 'omap3_l3_block_irq':
> arch/arm/mach-omap2/omap_l3_smx.c:156: warning: unused variable 'address'
> arch/arm/mach-omap2/omap_l3_smx.c:155: warning: unused variable 'multi'
> arch/arm/mach-omap2/omap_l3_smx.c:154: warning: unused variable 'initid'
> arch/arm/mach-omap2/omap_l3_smx.c:153: warning: unused variable 'code'
> arch/arm/mach-omap2/omap_l3_smx.c: At top level:
> arch/arm/mach-omap2/omap_l3_smx.c:68: warning: 'omap3_l3_code_string' defined but not used
> arch/arm/mach-omap2/omap_l3_smx.c:90: warning: 'omap3_l3_initiator_string' defined but not used
> drivers/video/omap2/dss/apply.c:350: warning: 'wait_pending_extra_info_updates' defined but not used

Care to take a look at fixing the above?

Tony
