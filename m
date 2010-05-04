From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/11] omap2/3/4: Disable CONFIG_FB_OMAP in
 omap3_defconfig
Date: Mon, 3 May 2010 17:52:22 -0700
Message-ID: <20100504005222.GD29604@atomide.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
 <20100430203411.25812.30019.stgit@baageli.muru.com>
 <20100430205003.GG29604@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Zi0sgQQBxRFxMTsj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52610 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab0EDAwX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 20:52:23 -0400
Content-Disposition: inline
In-Reply-To: <20100430205003.GG29604@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [100430 13:47]:
> * Tony Lindgren <tony@atomide.com> [100430 13:32]:
> > Looks like CONFIG_FB_OMAP prevents somehow mounting root on MMC
> > at least on zoom3 for multi-omap. Disable CONFIG_FB until the
> > omap FB code is fixed.
> 
> This one I'll drop as soon as the problem is sorted out with
> CONFIG_FB_OMAP.

This one seems to be something under drivers/video/omap, so
I'll change CONFIG_FB_OMAP to be a module now. Updated patch
below.

I'll update omap for-next accordingly, then Tomi can figure
it out :)

Regards,

Tony

--Zi0sgQQBxRFxMTsj
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="omapfb-module.patch"

>From 0c35e7c44eb579a532accb8e9cb65d1bac1af349 Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 30 Apr 2010 12:57:17 -0700
Subject: [PATCH] omap2/3/4: Set CONFIG_FB_OMAP=m in omap3_defconfig

Looks like CONFIG_FB_OMAP prevents somehow mounting root on MMC
at least on zoom3 for multi-omap. Disable CONFIG_FB until the
omap FB code is fixed.

This allows booting omap3_defconfig on various omaps. Tested on
2420-n8x0, 3430-n900, 3630-zoom3 and 4430-blaze. Note that n8x0
still has issues with starting user space because of TLS and
VFP.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/configs/omap3_defconfig b/arch/arm/configs/omap3_defconfig
index 7855edb..9ed6de8 100644
--- a/arch/arm/configs/omap3_defconfig
+++ b/arch/arm/configs/omap3_defconfig
@@ -1359,7 +1359,7 @@ CONFIG_FB_TILEBLITTING=y
 # CONFIG_FB_METRONOME is not set
 # CONFIG_FB_MB862XX is not set
 # CONFIG_FB_BROADSHEET is not set
-CONFIG_FB_OMAP=y
+CONFIG_FB_OMAP=m
 CONFIG_FB_OMAP_LCD_VGA=y
 # CONFIG_FB_OMAP_031M3R is not set
 # CONFIG_FB_OMAP_048M3R is not set

--Zi0sgQQBxRFxMTsj--
