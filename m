From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP2+: System timer updates
Date: Wed, 3 Apr 2013 11:04:47 -0700
Message-ID: <20130403180447.GX10155@atomide.com>
References: <515A3E01.1060308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21041 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762890Ab3DCSEu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 14:04:50 -0400
Content-Disposition: inline
In-Reply-To: <515A3E01.1060308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [130401 19:14]:
> The following changes since commit 2d61aecee8f32259920cdf90a452fa26ffc64e9f:
> 
>   Merge commit '6bb27d7349db51b50c40534710fe164ca0d58902' into omap-timer-for-v3.10 (2013-04-01 13:47:29 -0500)
> 
> are available in the git repository at:
> 
> 
>   git://github.com/jonhunter/linux.git omap-timer-for-v3.10
> 
> for you to fetch changes up to 4615943cf3a531bc76f589c22bd366da092b7c0f:
> 
>   ARM: OMAP4+: Fix sparse warning in system timers (2013-04-01 13:49:46 -0500)
> 
> ----------------------------------------------------------------
> This series consists mainly of clean-ups for clockevents and
> clocksource timers on OMAP2+ devices. The most significant change
> in functionality comes from the 5th patch which is changing the
> selection of the clocksource timer for OMAP3 and AM335x devices
> when gptimers are used for clocksource.
> 
> This series is dependent on commit 7185684 (ARM: OMAP: use
> consistent error checking) from RMK's clean-up branch and commit
> 6bb27d7 (ARM: delete struct sys_timer)

Thanks pulling into omap-for-v3.10/timer. I ended up merging this
with omap-for-v3.10/fixes-non-critical because of the omap5 merge
conflict.

Regards,

Tony

> ----------------------------------------------------------------
> 
> Jon Hunter (7):
>       ARM: OMAP2+: Display correct system timer name
>       ARM: OMAP2+: Remove hard-coded test on timer ID
>       ARM: OMAP2+: Simplify system timer clock definitions
>       ARM: OMAP2+: Simplify system timers definitions
>       ARM: OMAP3: Update clocksource timer selection
>       ARM: OMAP2+: Store ID of system timers in timer structure
>       ARM: OMAP4+: Fix sparse warning in system timers
> 
>  arch/arm/mach-omap2/board-cm-t3517.c |    2 +-
>  arch/arm/mach-omap2/board-generic.c  |    2 +-
>  arch/arm/mach-omap2/common.h         |    3 +-
>  arch/arm/mach-omap2/timer.c          |  121 +++++++++++++++++-----------------
>  4 files changed, 65 insertions(+), 63 deletions(-)
