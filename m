From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: Move omap2_check_revision and omap_sram_init out
 of map_io
Date: Mon, 14 Feb 2011 17:53:20 -0800
Message-ID: <20110215015320.GX20795@atomide.com>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
 <20110123174814.GI30094@n2100.arm.linux.org.uk>
 <20110124201731.GC13589@atomide.com>
 <20110214234520.GT20795@atomide.com>
 <20110214235238.GU20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63758 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab1BOBxh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Feb 2011 20:53:37 -0500
Content-Disposition: inline
In-Reply-To: <20110214235238.GU20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [110214 15:51]:
> With the early init changes we just want to map IO in map_io.
> Both omap2_check_revision and omap_sram_init can be moved to
> happen later in omap2_init_common_infrastructure.
> 
> Note that now we can now remove _omap2_map_common_io and remove
> the extra flushes too as devicemaps_init will take care of it.

Hmm this one seems to need a bit more work, won't work on 2420.

Tony
