From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH V3 8/8] OMAP: cpufreq: minor file header updates
Date: Wed, 25 May 2011 17:18:18 -0700
Message-ID: <8739k2jovp.fsf@ti.com>
References: <1306366733-8439-1-git-send-email-nm@ti.com>
	<1306366733-8439-9-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:34717 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753256Ab1EZASV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 20:18:21 -0400
Received: by pvg11 with SMTP id 11so97792pvg.13
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 17:18:20 -0700 (PDT)
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
>
> Reported-by: Todd Poynor <toddpoynor@google.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

[...]

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

Wow, you're really wanting to have copyright coverage well into the
future !  ;)

Kevin
