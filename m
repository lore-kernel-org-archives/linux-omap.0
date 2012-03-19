From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/4] ARM: OMAP: boards: changes to support dynamic
 irq alloc
Date: Mon, 19 Mar 2012 12:17:44 -0700
Message-ID: <20120319191743.GB9859@atomide.com>
References: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:44576 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032559Ab2CSTRr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 15:17:47 -0400
Content-Disposition: inline
In-Reply-To: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, b-cousson@ti.com, grant.likely@secretlab.ca, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [120319 05:09]:
> These two patches incorporate changes to OMAP1 and OMAP2 platforms
> board files whereby older references to OMAP_GPIO_IRQ macro are
> now replaced with gpio_to_irq(), thereby getting rid of static
> irq references.
> 
> Reference: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git omap/dt
> Commit: 9a0cee711448335ec43eae83272495e9334c0098

Can you please tell the exact two commits causing this
breakage?

I'm baffled how despite all the effort for previnting
issues like this this still happen. These all seem valid
fixes and clean up things, but how come this was not seen
earlier?

Regards,

Tony
