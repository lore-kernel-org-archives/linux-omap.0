From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] OMAP2/3: update default defconfig, towards smaller
	kernel
Date: Mon, 1 Feb 2010 13:49:26 -0600
Message-ID: <20100201194926.GA5819@lixom.net>
References: <1264811216-25989-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:50548 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755845Ab0BATqd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Feb 2010 14:46:33 -0500
Content-Disposition: inline
In-Reply-To: <1264811216-25989-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Fri, Jan 29, 2010 at 04:26:56PM -0800, Kevin Hilman wrote:
> Update omap3_defconfig to work towards a minimal kernel by building
> most things as modules.  Some drivers that cannot currently be built
> as modules and need to be fixed:

Why? I introduced the omap3_defconfig with the intent of making it as
inclusive as possible, to catch build errors and build a common binary
for many platforms. It's the only OMAP defconfig that Stephen Rothwell
builds as part of a linux-next cycle, and it will as such need to catch
build errors when others break ARM/OMAP.

> - MMC: platform code uses MMC core regulator functions directly
> - ASoC: drivers call omap_ctrl_[read|write] directly
> 
> In addition some additional changes:
> 
> - use new SLUB allocator instead of SLAB (increased debugability)
> - compile with PREEMPT enabled by default
> - disable OABI_COMPAT.  We should not pretend to support this IMHO
> - disable CPUfreq: not yet supported in mainline
> - disable PM_DEBUG_VERBOSE
> - enable fb/DSS2 as modules
> - disable Kprobes
> 
> zImage size comparison
> before: 3160272
> after:  2610108
> 
> Some ideas for reducing this further:
> - fix MMC and ASoC, then build those as modules
> - disable all the kernel debug features
> - convert MTD and all flash fs to modules
> 
> Then, we should have platform specific initramfs configs so rootfs
> from flash, MMC, etc. could be done using modules in initramfs.

I'm all for allowing an "allmodconfig" kernel to be booted, and it's good
to clear up some of these dependencies. But I'd prefer if it wasn't done
under omap3_defconfig. :)


-Olof

