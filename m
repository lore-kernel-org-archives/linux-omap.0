From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: fix CONFIG_CPU_IDLE dependency on
 CONFIG_PM
Date: Fri, 29 Jun 2012 06:04:08 -0700
Message-ID: <20120629130407.GF4202@atomide.com>
References: <1340901914-771-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40386 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038Ab2F2NEL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jun 2012 09:04:11 -0400
Content-Disposition: inline
In-Reply-To: <1340901914-771-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Daniel Lezcano <daniel.lezcano@linaro.org>

* Kevin Hilman <khilman@ti.com> [120628 09:49]:
> commit 164e0cbf60 (ARM: OMAP3/4: consolidate cpuidle Makefile) added
> an OMAP-specific dependency from CPU_IDLE to CONFIG_PM.  This causes
> some randconfig warnings when CONFIG_PM has unmet dependencies:
> 
> warning: (ARCH_OMAP3 && ARCH_OMAP4) selects PM which has unmet direct dependencies (PM_SLEEP || PM_RUNTIME)
> warning: (ARCH_OMAP3 && ARCH_OMAP4) selects PM which has unmet direct dependencies (PM_SLEEP || PM_RUNTIME)
> warning: (ARCH_OMAP3 && ARCH_OMAP4) selects PM which has unmet direct dependencies (PM_SLEEP || PM_RUNTIME)
> 
> Fix this by making the dependency on CONFIG_PM_RUNTIME (which in turn
> will enable CONFIG_PM.)
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Tony, this fixes the randconfig problems you mentioned.  It applies on
> top of your testing-board branch, where the commit that introduced this
> problem is applied.

Thanks applying into fixes-non-critical. The warning is there already in
fixes-non-critical, testing-board was just based on that.

Tony
