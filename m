From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] mfd: twl: fix twl4030 rename for remaining driver,
 board files
Date: Tue, 15 Dec 2009 15:11:02 +0200
Message-ID: <20091215131102.GL3689@nokia.com>
References: <1260881723-17255-1-git-send-email-balajitk@ti.com>
 <20091215130546.GK3689@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:62049 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756956AbZLONMF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 08:12:05 -0500
Content-Disposition: inline
In-Reply-To: <20091215130546.GK3689@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>
Cc: "ext balajitk@ti.com" <balajitk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "tony@atomide.com" <tony@atomide.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>

Hi,

On Tue, Dec 15, 2009 at 02:05:46PM +0100, Balbi Felipe (Nokia-D/Helsinki) wrote:
>also, this patch doesn't apply neither on top of linus's master nor
>tony's master:
>
>$ git am ~/check.diff
>Applying: mfd: twl: fix twl4030 rename for remaining driver, board files
>error: patch failed: drivers/video/omap/lcd_omap2evm.c:24
>error: drivers/video/omap/lcd_omap2evm.c: patch does not apply
>error: patch failed: drivers/video/omap/lcd_omap3beagle.c:23
>error: drivers/video/omap/lcd_omap3beagle.c: patch does not apply
>error: patch failed: drivers/video/omap/lcd_omap3evm.c:23
>error: drivers/video/omap/lcd_omap3evm.c: patch does not apply
>Patch failed at 0001 mfd: twl: fix twl4030 rename for remaining driver, board files
>When you have resolved this problem run "git am --resolved".
>If you would prefer to skip this patch, instead run "git am --skip".
>To restore the original branch and stop patching run "git am --abort".
>
>please rebase.

<fixed tony's address>

and btw, linux-omap doesn't have this problem (just yet). It's missing a 
merge.

-- 
balbi
