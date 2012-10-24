From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: PM fixes for v3.7-rc3
Date: Tue, 23 Oct 2012 18:37:01 -0700
Message-ID: <20121024013700.GB5605@atomide.com>
References: <87d3087s5k.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:57344 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754422Ab2JXBhF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Oct 2012 21:37:05 -0400
Content-Disposition: inline
In-Reply-To: <87d3087s5k.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

* Kevin Hilman <khilman@deeprootsystems.com> [121023 15:15]:
> Tony,
> 
> Here are a few more fixes PM-related fixes for v3.7-rc
> 
> Kevin
> 
> 
> The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:
> 
>   Linux 3.7-rc2 (2012-10-20 12:11:32 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/for_3.7-rc3-fixes-pm
> 
> for you to fetch changes up to 65bf7ca0005d7d827596d5df28583c83c9158da6:
> 
>   ARM: OMAP3: Beagle: fix OPP customization and initcall ordering (2012-10-22 16:01:42 -0700)
> 
> ----------------------------------------------------------------
> Misc. OMAP PM-related fixes for v3.7-rc

Thanks pulling into omap-for-v3.7-rc1/fixes.

Regards,

Tony
 
> ----------------------------------------------------------------
> Kevin Hilman (2):
>       ARM: OMAP2: UART: fix console UART mismatched runtime PM status
>       ARM: OMAP3: Beagle: fix OPP customization and initcall ordering
> 
> Paul Walmsley (1):
>       ARM: OMAP3: PM: apply part of the erratum i582 workaround
> 
>  arch/arm/mach-omap2/board-omap3beagle.c | 22 +++++++++++++---------
>  arch/arm/mach-omap2/pm.h                |  1 +
>  arch/arm/mach-omap2/pm34xx.c            | 30 ++++++++++++++++++++++++++++--
>  arch/arm/mach-omap2/serial.c            |  5 +++++
>  4 files changed, 47 insertions(+), 11 deletions(-)
