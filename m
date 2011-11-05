From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP: few more PM cleanup/fixes for v3.2
Date: Fri, 4 Nov 2011 17:42:02 -0700
Message-ID: <20111105004202.GP31337@atomide.com>
References: <87sjn4jyzx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56461 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab1KEAmE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 20:42:04 -0400
Content-Disposition: inline
In-Reply-To: <87sjn4jyzx.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

* Kevin Hilman <khilman@ti.com> [111007 13:29]:
> Tony,
> 
> Please pull the (hopefully) last few PM fixes/cleanups for v3.2.
> 
> Kevin
> 
> 
> The following changes since commit 976d167615b64e14bc1491ca51d424e2ba9a5e84:
> 
>   Linux 3.1-rc9 (2011-10-04 18:11:50 -0700)
> 
> are available in the git repository at:
>   git://github.com/khilman/linux-omap-pm.git for_3.2/pm-cleanup-2

Thanks pulling into fixes.

Tony
 
> Charulatha V (1):
>       ARM: OMAP3: PM: fix pwrdm_post_transition call sequence
> 
> Paul Walmsley (2):
>       ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock control detection
>       ARM: OMAP3: PM: restrict erratum i443 handling to OMAP3430 only
> 
>  arch/arm/mach-omap2/id.c              |    5 ++-
>  arch/arm/mach-omap2/pm34xx.c          |   70 +++++++++++++++++---------------
>  arch/arm/plat-omap/include/plat/cpu.h |   17 ++++++--
>  3 files changed, 53 insertions(+), 39 deletions(-)
