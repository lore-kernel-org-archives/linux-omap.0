From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3: PM: fix scratchpad memory accesses for off-mode
Date: Mon, 11 Oct 2010 10:03:30 -0700
Message-ID: <20101011170330.GA25462@atomide.com>
References: <1286577825-22029-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49280 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755483Ab0JKRDe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Oct 2010 13:03:34 -0400
Content-Disposition: inline
In-Reply-To: <1286577825-22029-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, jean.pihet@newoldbits.com, "G, Manjunath Kondaiah" <manjugk@ti.com>

* Kevin Hilman <khilman@deeprootsystems.com> [101008 15:35]:
> Commit 914bab936fe0388a529079679e2f137aa4ff548d (OMAP: mach-omap2: Fix
> incorrect assignment warnings) changed a pointer from 'u32 *' to
> 'void *' without also fixing up the pointer arithmetic.
> 
> Fix the scratchpad offsets so they are byte offsets instead of
> word offsets and thus work correctly with a void pointer base.
> 
> Special thanks to Jean Pihet for taking the time track down this
> problem and propose an initial solution.
> 
> Tested with off-idle and off-suspend on 36xx/Zoom3 and 34xx/omap3evm.
> 
> Cc: G, Manjunath Kondaiah <manjugk@ti.com>
> Reported-by: Jean Pihet <jean.pihet@newoldbits.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> Tony, we need this queued for 2.6.37 as this is a regression fix.

Thanks, adding to omap-for-linus.

Tony
