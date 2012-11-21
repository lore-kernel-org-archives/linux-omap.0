From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP: Timer Clean-up
Date: Wed, 21 Nov 2012 10:22:55 -0800
Message-ID: <20121121182254.GW18567@atomide.com>
References: <50A6751C.6080800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:28116 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755409Ab2KUSXA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Nov 2012 13:23:00 -0500
Content-Disposition: inline
In-Reply-To: <50A6751C.6080800@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Jon Hunter <jon-hunter@ti.com> [121116 09:19]:
> The following changes since commit 9dc57643738f9fbe45c10cc062903d5dfda5bdd9:
> 
>   Merge branch 'fixes-timer' of github.com:jonhunter/linux into omap-for-v3.8/timer (2012-11-13 13:52:38 -0800)
> 
> are available in the git repository at:
> 
>   git://github.com/jonhunter/linux.git cleanup-timer
> 
> for you to fetch changes up to 258e84af9799b8c81cf856dcbd8e2d4cc082741d:
> 
>   ARM: OMAP2+: Fix compiler warning for 32k timer (2012-11-16 10:35:09 -0600)
> 
> ----------------------------------------------------------------
> Various OMAP timer clean-ups.
> 
> I have dropped the patch to move dmtimer.h as discussed.
> 
> I have also included the compilation warning fix for sync-32k
> reported by Kevin Hilman.

Thanks pulling into omap-for-v3.8/timer.

Regards,

Tony
