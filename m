From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 10/10] OMAP3: update OMAP3 Beagle defconfig, v3
Date: Wed, 19 Aug 2009 16:40:56 +0300
Message-ID: <20090819134056.GC30306@nokia.com>
References: <20090812120926.17601.85860.stgit@localhost>
 <20090812122415.17601.44872.stgit@localhost>
 <20090812122710.GA23166@nokia.com>
 <20090812165258.GM7278@atomide.com>
 <87d471vti5.fsf@deeprootsystems.com>
 <20090812191109.GB21001@gandalf>
 <20090813070233.GP7278@atomide.com>
 <loom.20090816T011000-32@post.gmane.org>
 <20090816154154.GC7278@atomide.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:60693 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbZHSNmr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Aug 2009 09:42:47 -0400
Content-Disposition: inline
In-Reply-To: <20090816154154.GC7278@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: Eric Witcher <ewitcher@mindspring.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Sun, Aug 16, 2009 at 05:42:00PM +0200, ext Tony Lindgren wrote:
> From f9356c9b5ca663feb3a985b42d0409da5625d537 Mon Sep 17 00:00:00 2001
> From: Paul Walmsley <paul@pwsan.com>
> Date: Sun, 16 Aug 2009 18:29:49 +0300
> Subject: [PATCH] OMAP3: update OMAP3 Beagle defconfig
> 
> Update the OMAP3 Beagle defconfig to add EHCI, MMC, TWL4030 GPIO support.
> Beagle can again use MMC rootfs after this patch.  Tested on BeagleBoard
> rev C2.
> 
> Patch updated to enable PM and OTG options as suggested by
> Eric Witcher <ewitcher@mindspring.com>.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Jason Kridner <jkridner@beagleboard.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

now that we have REGULATOR and TWL4030_USB it will work.

-- 
balbi
