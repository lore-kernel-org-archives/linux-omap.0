From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] mfd: twl: fix twl4030 rename for remaining driver, board files
Date: Wed, 16 Dec 2009 09:28:17 +0200
Message-ID: <200912160928.17397.peter.ujfalusi@nokia.com>
References: <1260881723-17255-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:55439 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934642AbZLPH2y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Dec 2009 02:28:54 -0500
In-Reply-To: <1260881723-17255-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext balajitk@ti.com" <balajitk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "tony@atomide.co" <tony@atomide.co>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>

On Tuesday 15 December 2009 14:55:23 ext balajitk@ti.com wrote:
> From: Balaji T K <balajitk@ti.com>
> 
>         This patch renames include twl4030.h to include twl.h
> 	and also renames twl4030_i2c_ routines
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
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

I have not followed the thread too closely, but have you made the changes also 
to the sound/soc/codec/twl4030.c driver as well, since that also includes the 
linux/i2c/twl4030.h ?

If that has been taken care by other patch, than:

Acked-By: Peter Ujfalusi <peter.ujfalusi@nokia.com>
