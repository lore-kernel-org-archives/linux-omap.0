From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH V3 8/8] OMAP: cpufreq: minor file header updates
Date: Thu, 26 May 2011 11:15:28 -0700
Message-ID: <87ei3lcoqn.fsf@ti.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com>
	<1306366733-8439-9-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:40646 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756990Ab1EZSPb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 14:15:31 -0400
Received: by mail-pv0-f178.google.com with SMTP id 7so432481pvg.9
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 11:15:31 -0700 (PDT)
In-Reply-To: <1306366733-8439-9-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Wed, 25 May 2011 16:38:53 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Minor file header updates to reflect 2011 for omap2-cpufreq code
> and remove misleading OMAP3 reference in omap1 cpufreq code.
>
> Should probably be squashed to:
> "OMAP: cpufreq: Split OMAP1 and OMAP2PLUS CPUfreq drivers."

Thanks, squashed.

Kevin

> Reported-by: Todd Poynor <toddpoynor@google.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap1/omap1-cpufreq.c     |    1 -
>  arch/arm/mach-omap2/omap2plus-cpufreq.c |    2 +-
>  2 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/omap1-cpufreq.c b/arch/arm/mach-omap1/omap1-cpufreq.c
> index 682cdc8..7c5216e 100644
> --- a/arch/arm/mach-omap1/omap1-cpufreq.c
> +++ b/arch/arm/mach-omap1/omap1-cpufreq.c
> @@ -9,7 +9,6 @@
>   *  Based on cpu-sa1110.c, Copyright (C) 2001 Russell King
>   *
>   * Copyright (C) 2007-2008 Texas Instruments, Inc.
> - * Updated to support OMAP3
>   * Rajendra Nayak <rnayak@ti.com>
>   *
>   * This program is free software; you can redistribute it and/or modify
> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> index 594100e..2482c71 100644
> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -8,7 +8,7 @@
>   *
>   *  Based on cpu-sa1110.c, Copyright (C) 2001 Russell King
>   *
> - * Copyright (C) 2007-2008 Texas Instruments, Inc.
> + * Copyright (C) 2007-20011 Texas Instruments, Inc.
>   * Updated to support OMAP3
>   * Rajendra Nayak <rnayak@ti.com>
>   *
