From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] omap4: Fix multi-omap boot with reset un-used clocks
Date: Mon, 31 May 2010 15:48:25 +0300
Message-ID: <20100531124824.GF30216@atomide.com>
References: <1274287087-4049-1-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1005191708320.27473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59157 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab0EaMsU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 May 2010 08:48:20 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1005191708320.27473@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [100520 02:05]:
> Hi,
> 
> On Wed, 19 May 2010, Santosh Shilimkar wrote:
> 
> > This patch uses "ENABLE_ON_INIT" flag on the emif clock nodes
> > to avoid the emif clk getting cut as part of reset un-used clock
> > routine which prevents boot.
> > 
> > Since omap4 "omap2_clk_init()" calls "clk_enable_init_clocks()"
> > which increases the usecount on all ENABLE_ON_INIT clocks, it
> > prevents "omap2_clk_disable_unused()" from disabling the clock.
> > 
> > The real fix is to have driver for EMIF and do clock get/enable
> > as part of it. The EMIF driver is planned to be done HWMOD way
> > so till that available to keep omap3_defconfig booting on OMAP4430,
> > this patch is necessary.
> > (Will updated the auto-gen script for 44xx accordingly)
> > 
> > The fix was suggested by Paul Walmsley
> > 
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> 
> Thanks, I've added Nishanth's Tested-by: and fixed the patch changelog; 
> the following patch is now queued for 2.6.35-rc, unless there are any 
> further comments.

FYI, I'll also added this into omap-testing branch while we're waiting
for your clock fixes branch to be available.

Regards,

Tony
