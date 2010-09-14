From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/3] omap: pm: Move the common code to allow re-use
Date: Tue, 14 Sep 2010 10:53:47 -0700
Message-ID: <87bp80p5xw.fsf@deeprootsystems.com>
References: <1284472548-32151-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35269 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab0INRx7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 13:53:59 -0400
Received: by yxp4 with SMTP id 4so2443236yxp.19
        for <linux-omap@vger.kernel.org>; Tue, 14 Sep 2010 10:53:58 -0700 (PDT)
In-Reply-To: <1284472548-32151-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Tue, 14 Sep 2010 19:25:45 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, b-cousson@ti.com, Thara Gopinath <thara@ti.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> This is small series moves some common pm code out of pm34xx.c so
> that omap4 can re-use this and not duplicate it.
>
> It's boot tested on OMAP3/4 with omap3_defconfig and also simple
> test with millisecond debugfs entry and suspend/resume.
>

Hi Santosh,

This series looks good.

Can you rebase it on my pm-next branch please?  There's already a patch
from Thara queued up in my pm-next queue that does most (all?) of what
your patch 1 does.

Thanks,

Kevin

> The following changes since commit 49553c2ef88749dd502687f4eb9c258bb10a4f44:
>   Linus Torvalds (1):
>         Linux 2.6.36-rc4
>
> Santosh Shilimkar (3):
>       omap: pm-debug: Move common debug code to pm-debug.c
>       omap: pm-debug: Enable wakeup_timer_milliseconds debugfs entry
>       omap: pm: Move set_pwrdm_state routine to common pm.c
>
>  arch/arm/mach-omap2/pm-debug.c |   26 ++++++++++++++
>  arch/arm/mach-omap2/pm.c       |   50 ++++++++++++++++++++++++++
>  arch/arm/mach-omap2/pm.h       |    8 +++--
>  arch/arm/mach-omap2/pm34xx.c   |   76 ++-------------------------------------
>  4 files changed, 85 insertions(+), 75 deletions(-)
