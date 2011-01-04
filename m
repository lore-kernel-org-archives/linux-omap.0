From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2/3] perf: add OMAP support for the new power events
Date: Tue, 4 Jan 2011 11:42:03 +0100
Message-ID: <20110104104203.GB2447@elte.hu>
References: <1294136263-24020-1-git-send-email-j-pihet@ti.com>
 <1294136263-24020-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:47543 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779Ab1ADKmQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Jan 2011 05:42:16 -0500
Content-Disposition: inline
In-Reply-To: <1294136263-24020-3-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-kernel@vger.kernel.org, trenn@suse.de, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-perf-users@vger.kernel.org, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>


* jean.pihet@newoldbits.com <jean.pihet@newoldbits.com> wrote:

> From: Jean Pihet <j-pihet@ti.com>
> 
> The patch adds the new power management trace points for
> the OMAP architecture.
> 
> The trace points are for:
> - default idle handler. Since the cpuidle framework is
>   instrumented in the generic way there is no need to
>   add trace points in the OMAP specific cpuidle handler;
> - cpufreq (DVFS),
> - clocks changes (enable, disable, set_rate),
> - change of power domains next power states.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c      |    7 +++++++
>  arch/arm/mach-omap2/powerdomain.c |    3 +++
>  arch/arm/plat-omap/clock.c        |   13 ++++++++++---
>  3 files changed, 20 insertions(+), 3 deletions(-)

I suspect the gents and mailing lists listed by:

  scripts/get_maintainer.pl -f arch/arm/plat-omap/clock.c
  scripts/get_maintainer.pl -f arch/arm/mach-omap2/pm34xx.c

Would want to be Cc:-ed as well. That will also get the right Acked-by's. (if you 
want these commits to go upstream via the perf tree)

Thanks,

	Ingo
