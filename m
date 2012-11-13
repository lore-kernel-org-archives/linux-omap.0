From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: DMTIMER fixes
Date: Tue, 13 Nov 2012 14:12:32 -0800
Message-ID: <20121113221231.GL6801@atomide.com>
References: <50A28086.6050500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:11087 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753209Ab2KMWMf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 17:12:35 -0500
Content-Disposition: inline
In-Reply-To: <50A28086.6050500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [121113 09:18]:
> The following changes since commit d308ba50a1234b299a00e63a95e61fdeb2f1a2df:
> 
>   Merge branch 'omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3' into omap-for-v3.8/dt (2012-11-09 14:58:34 -0800)
> 
> are available in the git repository at:
> 
> 
>   git@github.com:jonhunter/linux.git fixes-timer
> 
> for you to fetch changes up to b1538832191d59e29b1077e64cf416a7617b45bc:
> 
>   ARM: OMAP: Remove __omap_dm_timer_set_source function (2012-11-12 16:23:57 -0600)
> 
> ----------------------------------------------------------------
> Several fixes for the OMAP DMTIMER driver including ...
> 1. Adding workaround for OMAP3+ errata i103/i767
> 2. Fixing posted mode support
> 3. Spurious interrupts when using match interrupt
> 4. HWMOD fixes for timers
> 5. Unnecessary restoration of read-only registers
> 6. Adds function for disabling timer interrupts
> 7. Fixing timer1 reset for OMAP1

Thanks pulling into omap-for-v3.8/timer.

Regards,

Tony
Thanks pulled into omap-for-v3.8/timer.
