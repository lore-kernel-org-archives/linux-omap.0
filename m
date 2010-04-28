From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: PM: Fix compilation error observed when cpufreq is disabled
Date: Wed, 28 Apr 2010 14:30:48 -0700
Message-ID: <87bpd3cliv.fsf@deeprootsystems.com>
References: <1268995606-32018-1-git-send-email-ranjithl@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f182.google.com ([209.85.223.182]:60480 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000Ab0D1Vax (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 17:30:53 -0400
Received: by iwn12 with SMTP id 12so4538922iwn.15
        for <linux-omap@vger.kernel.org>; Wed, 28 Apr 2010 14:30:52 -0700 (PDT)
In-Reply-To: <1268995606-32018-1-git-send-email-ranjithl@ti.com> (Ranjith Lohithakshan's message of "Fri\, 19 Mar 2010 16\:16\:46 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: linux-omap@vger.kernel.org

Ranjith Lohithakshan <ranjithl@ti.com> writes:

> Currently on PM branch, compilation fails when cpufreq is disabled
>
> arch/arm/mach-omap2/clock3xxx_data.c: In function 'omap3xxx_clk_init':
> arch/arm/mach-omap2/clock3xxx_data.c:3563: error: 'struct clk_functions'
> has no member named 'clk_init_cpufreq_table'
> arch/arm/mach-omap2/clock3xxx_data.c:3564: error:
> 'omap3_clk_init_cpufreq_table' undeclared (first use
> in this function)
> arch/arm/mach-omap2/clock3xxx_data.c:3564: error: (Each undeclared
> identifier is reported only once
> arch/arm/mach-omap2/clock3xxx_data.c:3564: error: for each function it
> appears in.)
> make[1]: *** [arch/arm/mach-omap2/clock3xxx_data.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2
>
> This patch fixes the issue by avoiding runtime init of
> clk_init_cpufreq_table in omap3xxx_clk_init and instead doing it when
> omap2_clk_functions are defined.
>
> Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>

Do you still have this problem?  I'm unable to reproduce on current PM branch.

Kevin
