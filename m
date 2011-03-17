From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 0/2] [pm-wip/cpufreq] OMAP: CPUfreq cleanup and SMP support
Date: Thu, 17 Mar 2011 14:50:40 -0700
Message-ID: <871v25v2kv.fsf@ti.com>
References: <1300102729-17276-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:37334 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755540Ab1CQVuo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 17:50:44 -0400
Received: by mail-yw0-f54.google.com with SMTP id 9so1602803ywf.41
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 14:50:44 -0700 (PDT)
In-Reply-To: <1300102729-17276-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Mon, 14 Mar 2011 17:08:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> This series is an attempt to clean-up OMAP CPUfreq driver.
> 	- The OMAP1 and OMAP2PLUS cpufreq support is split to avoid
> 	  any #ifdefery
> 	- The omap2plus_cupfreq support is updated to work on
> 	  SMP_ON_UP builds
> 	- SMP support is added which can be used on OMAP4
>
> The series is generated against Kevin's latest cpufreq branch.

Thanks, adding to pm-wip/cpufreq branch.

Kevin

> The following changes since commit 444a22eb04ae07aef45cd4d0154f6f2bbe76daa9:
>   Kevin Hilman (1):
>         cpufreq: fixup after new OPP layer merged
>
> Santosh Shilimkar (2):
>   OMAP: cpufreq: Split OMAP1 and OMAP2PLUS CPUfreq drivers.
>   OMAP2PLUS: cpufreq: Add SMP support to cater OMAP4430
>
>  arch/arm/mach-omap1/Makefile                       |    3 +
>  .../cpu-omap.c => mach-omap1/omap1-cpufreq.c}      |   68 +++------
>  arch/arm/mach-omap2/Makefile                       |    3 +
>  .../cpu-omap.c => mach-omap2/omap2plus-cpufreq.c}  |  156 +++++++++++++-------
>  arch/arm/plat-omap/Makefile                        |    1 -
>  5 files changed, 128 insertions(+), 103 deletions(-)
>  copy arch/arm/{plat-omap/cpu-omap.c => mach-omap1/omap1-cpufreq.c} (75%)
>  rename arch/arm/{plat-omap/cpu-omap.c => mach-omap2/omap2plus-cpufreq.c} (55%)
