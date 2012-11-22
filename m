From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/5] remaining omap multiplatform patches for v3.8
	merge window
Date: Thu, 22 Nov 2012 20:24:31 +0000
Message-ID: <20121122202431.GS3332@n2100.arm.linux.org.uk>
References: <20121121174201.25576.61961.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49110 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211Ab2KVUZn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Nov 2012 15:25:43 -0500
Content-Disposition: inline
In-Reply-To: <20121121174201.25576.61961.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Wed, Nov 21, 2012 at 09:42:19AM -0800, Tony Lindgren wrote:
> There are few drivers still breaking because of their
> use of plat/cpu.h and cpu_is_omap macros. The following
> already have patches queued in linux next:
> 
> - drivers/staging/omapdrm/omap_drv.c
> - drivers/staging/omapdrm/omap_dmm_tiler.h

Note that there's a bunch of OMAP drivers in staging which are trivially
broken anyway; I've not been bothering to report their breakages which
my build system is finding - I figure that if they're trivially broken
with compile time errors which aren't config related, and no one's
bothering to fixing them, then no one is even trying to build them -
which means they're not being used.

And if they're not being used, it's pointless them being in mainline.
