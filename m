From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: Timer build warnings fixes for v3.8-rc
Date: Fri, 14 Dec 2012 09:12:35 -0800
Message-ID: <20121214171235.GN4989@atomide.com>
References: <50CB57AB.8080503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57515 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756224Ab2LNRMi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 12:12:38 -0500
Content-Disposition: inline
In-Reply-To: <50CB57AB.8080503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [121214 08:48]:
> The following changes since commit 698d601224824bc1a5bf17f3d86be902e2aabff0:
> 
>   Merge tag 'drivers' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2012-12-13 10:59:11 -0800)
> 
> are available in the git repository at:
> 
> 
>   git://github.com/jonhunter/linux.git fixes-timer-build
> 
> for you to fetch changes up to bf85f205d95eb223e849914101e0db1a5a576a3c:
> 
>   ARM: OMAP2+: Fix sparse warnings in timer.c (2012-12-14 10:14:55 -0600)
> 
> ----------------------------------------------------------------
> Fixes for a few timer warnings observed with different kernel
> configurations for OMAP2+ devices.
> 
> I have dropped the patch to fix a build error for OMAP4 in the
> timer code as Olof already has this fix merged.

Thanks pulling into omap-for-v3.8/fixes-for-merge-window.

Regards,

Tony

> ----------------------------------------------------------------
> 
> Jon Hunter (2):
>       ARM: OMAP2+: Fix realtime_counter_init warning in timer.c
>       ARM: AM335x: Fix warning in timer.c
> 
> Vaibhav Hiremath (1):
>       ARM: OMAP2+: Fix sparse warnings in timer.c
> 
>  arch/arm/mach-omap2/Kconfig |    3 ++-
>  arch/arm/mach-omap2/timer.c |    6 +++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
