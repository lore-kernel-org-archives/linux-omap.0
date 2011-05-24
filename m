From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP PM cleanups for 2.6.40
Date: Tue, 24 May 2011 11:55:03 +0300
Message-ID: <20110524085502.GF30799@atomide.com>
References: <87liy15r8b.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:61562 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754857Ab1EXIzF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 May 2011 04:55:05 -0400
Content-Disposition: inline
In-Reply-To: <87liy15r8b.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110520 18:21]:
> Tony,
> 
> Please pull the following OMAP PM related cleanups for 2.6.40.

Pulled into for-next for this merge window.
 
>  arch/arm/mach-omap2/board-3430sdp.c |   19 --
>  arch/arm/mach-omap2/board-rx51.c    |   18 +-
>  arch/arm/mach-omap2/cpuidle34xx.c   |  436 ++++++++++++-----------------------
>  arch/arm/mach-omap2/pm.h            |   17 +-
>  arch/arm/mach-omap2/pm34xx.c        |   14 --
>  5 files changed, 166 insertions(+), 338 deletions(-)

Nice, more negative diffstat :)

Regards,

Tony
