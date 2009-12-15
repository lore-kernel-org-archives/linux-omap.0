From: "Krishnamoorthy, Balaji T" <balajitk@ti.com>
Subject: RE: [PATCH v2] mfd: twl: fix twl4030 rename for remaining driver,
 board files
Date: Tue, 15 Dec 2009 21:40:24 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739404372AAFA4@dbde02.ent.ti.com>
References: <1260887942-32644-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47577 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754452AbZLOQKw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 11:10:52 -0500
In-Reply-To: <1260887942-32644-1-git-send-email-balajitk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "tony@atomide.com" <tony@atomide.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>

Hi Samuel,
Could you please take this patch through the mfd tree.

Thanks and Regards,
Balaji T K

> -----Original Message-----
> From: Krishnamoorthy, Balaji T
> Sent: Tuesday, December 15, 2009 8:09 PM
> To: linux-omap@vger.kernel.org; sameo@linux.intel.com
> Cc: broonie@opensource.wolfsonmicro.com; tony@atomide.com;
> sfr@canb.auug.org.au; felipe.balbi@nokia.com; lrg@slimlogic.co.uk;
> Krishnamoorthy, Balaji T
> Subject: [PATCH v2] mfd: twl: fix twl4030 rename for remaining driver, board
> files
> 
> From: Balaji T K <balajitk@ti.com>
> 
> 	This patch renames include twl4030.h to include twl.h
> 	and also renames twl4030_i2c_ routines
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Reviewed-by: Felipe Balbi <felipe.balbi@nokia.com>
> ---
> 	rebased the patch on latest mainline
> 	commit 3ea6b3d0e6d0ffd91c0f8cadeb69b7133c038b32
> 
>  arch/arm/mach-omap2/board-cm-t35.c           |    2 +-
>  arch/arm/mach-omap2/board-igep0020.c         |    2 +-
>  arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
>  arch/arm/mach-omap2/board-omap3touchbook.c   |    2 +-
>  arch/arm/mach-omap2/board-rx51-peripherals.c |    2 +-
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    2 +-
>  drivers/mfd/twl4030-codec.c                  |   10 +++++-----
>  drivers/video/omap/lcd_ldp.c                 |    4 ++--
>  drivers/video/omap/lcd_omap2evm.c            |   10 +++++-----
>  drivers/video/omap/lcd_omap3beagle.c         |    2 +-
>  drivers/video/omap/lcd_omap3evm.c            |   10 +++++-----
>  drivers/video/omap/lcd_overo.c               |    2 +-
>  sound/soc/omap/sdp3430.c                     |    6 +++---
>  13 files changed, 28 insertions(+), 28 deletions(-)
