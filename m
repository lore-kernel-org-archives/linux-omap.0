From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 00/11] Make omap24xx booting device tree based for v3.14
 merge window
Date: Fri, 15 Nov 2013 20:47:44 +0200
Message-ID: <20131115184744.GA10997@blackmetal.musicnaut.iki.fi>
References: <1384474198-20756-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:46321 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843Ab3KOSrw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Nov 2013 13:47:52 -0500
Content-Disposition: inline
In-Reply-To: <1384474198-20756-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi,

On Thu, Nov 14, 2013 at 04:09:47PM -0800, Tony Lindgren wrote:
> Here are some early patches for the v3.14 merge window to make
> omap2 booting device tree based before we make omap3 device
> tree only. Otherwise we cannot remove the shared platform data
> between omap2 and 3 for things like some hwmod entries.
> 
> I've added minimal support for 2430sdp to boot it to serial
> console with ethernet working, and kept n8x0 support using
> the legacy init for the drivers. Then the old H4 I have not
> updated as I'm not using it.
> 
> Hopefully if there are still people using n8x0 they can
> pick up the work from here on removing the rest of the legacy
> platform data init as we're planning to drop those things
> completely over next few merge cycles.

Thanks for the effort, I'll try to continue this work. You can add my
Tested-by for N8x0 bits.

> Note that these patches are against mainline commit 10d0c9705
> as there are few device tree related fixes to stuff the resources.   
> These also depend on the recently posted fixes series
> "[PATCH 0/8] Various omap device tree usability fixes for v3.13
> merge window"

I noticed one bug. If you disable MACH_NOKIA_N8X0 from .config, there
is a compilation failure:

arch/arm/mach-omap2/built-in.o: In function `omap2420_n8x0_legacy_init':
/home/aaro/git/linux/arch/arm/mach-omap2/pdata-quirks.c:76: undefined reference to `n8x0_legacy_init'

A.
