From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP: TWL IRQ dead code removal
Date: Wed, 27 Jun 2012 05:34:02 -0700
Message-ID: <20120627123402.GG3483@atomide.com>
References: <877guudyoa.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:31099 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755963Ab2F0MeF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jun 2012 08:34:05 -0400
Content-Disposition: inline
In-Reply-To: <877guudyoa.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>

* Kevin Hilman <khilman@ti.com> [120626 05:55]:
> Tony,
> 
> Please pull the following cleanup which removes the now unused TWL irq
> base/end.  The drivers part has been acked by Samuel.

Pulling this too into fixes-noncritical as it removes dead code.

Tony 

 
> The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:
> 
>   Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.6/cleanup/twl-irq
> 
> for you to fetch changes up to 3e7b706ca5151849e4ca91f7f3d8d6d8d8f7b667:
> 
>   mfd: twl: remove pdata->irq_base/_end, no more users (2012-06-19 15:24:34 -0700)
> 
> ----------------------------------------------------------------
> Kevin Hilman (2):
>       ARM: OMAP2+: TWL: remove usage of pdata->irq_base/_end
>       mfd: twl: remove pdata->irq_base/_end, no more users
> 
>  arch/arm/mach-omap2/board-2430sdp.c    |    3 ---
>  arch/arm/mach-omap2/board-omap3logic.c |    3 ---
>  arch/arm/mach-omap2/twl-common.c       |    9 ---------
>  include/linux/i2c/twl.h                |    1 -
>  4 files changed, 16 deletions(-)
