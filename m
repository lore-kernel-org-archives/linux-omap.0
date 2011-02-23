From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/8] OMAP2+: hwmod/clockevent: allow late-init of
 individual hwmods
Date: Wed, 23 Feb 2011 11:12:57 -0800
Message-ID: <20110223191256.GB15225@atomide.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53333 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754605Ab1BWTNB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 14:13:01 -0500
Content-Disposition: inline
In-Reply-To: <20110223070455.5874.51326.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Thara Gopinath <thara@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

* Paul Walmsley <paul@pwsan.com> [110222 23:11]:
> Hello,
> 
> This series adds the ability to late-initialize individual
> hwmods.  The goal here is for clockevent (and eventually
> clocksource) hwmods to be late-initialized individually, and
> right before they are needed, in the timer init code.  Then
> omap_hwmod_late_init(), which late-inits the rest of the hwmods,
> is intended to run as an initcall -- much later in the boot
> process.

Sounds good to me!

Tony
