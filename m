From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP: PM: cpuidle cleanups for v3.10
Date: Mon, 8 Apr 2013 10:03:12 -0700
Message-ID: <20130408170312.GM10155@atomide.com>
References: <874nfkjz3l.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46294 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935207Ab3DHRDP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 13:03:15 -0400
Content-Disposition: inline
In-Reply-To: <874nfkjz3l.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Kevin Hilman <khilman@linaro.org> [130405 17:17]:
> Tony,
> 
> Please pull the following changes for OMAP CPUidle for v3.10.
> 
> Kevin
> 
> 
> The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:
> 
>   Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/omap-pm-v3.10/cleanup/cpuidle
> 
> for you to fetch changes up to 2507386b7c01e3b0f6967d12c72467bf3f66c77e:
> 
>   ARM: OMAP4+: CPUidle: Consolidate idle driver for OMAP5 support (2013-04-05 13:37:33 -0700)
> 
> ----------------------------------------------------------------
> OMAP3/4 CPUidle cleanups for v3.10

Thanks pulling into omap-for-v3.10/cleanup-pm.

Regards,

Tony
 
> ----------------------------------------------------------------
> Daniel Lezcano (1):
>       ARM: omap3: cpuidle: enable time keeping
> 
> Santosh Shilimkar (5):
>       ARM: OMAP4: CPUidle: Avoid double idle driver registration
>       ARM: OMAP: CPUidle: Unregister drivere on device registration failure
>       ARM: OMAP4: CPUidle: Make C-state description field more precise
>       ARM: OMAP4+: CPUidle: Deprecate use of omap4_mpuss_read_prev_context_state()
>       ARM: OMAP4+: CPUidle: Consolidate idle driver for OMAP5 support
> 
>  arch/arm/mach-omap2/common.h              |  5 ----
>  arch/arm/mach-omap2/cpuidle34xx.c         | 11 +++++--
>  arch/arm/mach-omap2/cpuidle44xx.c         | 48 +++++++++++++++++--------------
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c | 14 ---------
>  4 files changed, 35 insertions(+), 43 deletions(-)
