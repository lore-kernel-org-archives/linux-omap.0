From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/5] omap2plus: Trivial build break fixes
Date: Tue, 04 Jan 2011 16:37:47 -0800
Message-ID: <8762u4423o.fsf@ti.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:37230 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750957Ab1AEAhv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 19:37:51 -0500
Received: by yib17 with SMTP id 17so4430337yib.35
        for <linux-omap@vger.kernel.org>; Tue, 04 Jan 2011 16:37:50 -0800 (PST)
In-Reply-To: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Tue, 4 Jan 2011 23:56:11 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> These are trivial build fixes which I found while doing some 
> testing 'omap-for-linus' branch.
>
> The series is generated against the linux-omap 'omap-for-linus' branch
> and boot tested on OMAP4430 SDP and OMAP3630 ZOOM.

Minor nit in your git-send-email config.  

Can you add the following to your ~/.gitconfig, or update to newer git
where this is now the default:

[sendemail]
	chainreplyto = false

This will make all patches a reply to PATCH 0 instead of to the previous
patch.

Thanks,

Kevin

>
>
> The following changes since commit dc69d1af9e8d9cbbabff88bb35a6782187a22229:
>   Ben Gamari (1):
>         omap2: Make OMAP2PLUS select OMAP_DM_TIMER
>
>
> Santosh Shilimkar (5):
>       omap2plus: clockdomain: Trivial fix for build break because of clktrctrl_mask
>       omap2plus: prm: Trvial build break fix for undefined reference to 'omap2_prm_read_mod_reg'
>       omap2plus: voltage: Trivial warning fix 'no return statement'
>       omap2plus: voltage: Trivial linking fix 'undefined reference'
>       omap2plus: voltage: Trivial linking fix for 'EINVAL' undeclared
>
>  arch/arm/mach-omap2/Makefile              |    2 +-
>  arch/arm/mach-omap2/clockdomain.h         |    2 +-
>  arch/arm/mach-omap2/prm2xxx_3xxx.h        |   45 ++++++++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/voltage.h |   17 ++++++++--
>  4 files changed, 59 insertions(+), 7 deletions(-)
