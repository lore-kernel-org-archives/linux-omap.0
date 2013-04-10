From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP PM cleanups for v3.10
Date: Wed, 10 Apr 2013 11:14:52 -0700
Message-ID: <20130410181452.GG10155@atomide.com>
References: <87ehej1ena.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41149 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761894Ab3DJSO5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Apr 2013 14:14:57 -0400
Content-Disposition: inline
In-Reply-To: <87ehej1ena.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi,

Added Olof to cc, I suggest Olof pull this directly as we're starting
to run out of time.

Regards,

Tony

* Kevin Hilman <khilman@linaro.org> [130409 16:18]:
> Tony,
> 
> Here's the final set of OMAP PM cleanups for v3.10.  This is a small set
> of cleanups from Santosh to consolidate and prepare for OMAP5 PM additions.
> 
> It's based on your cleanup-v2 branch.
> 
> Kevin
> 
> 
> The following changes since commit c309f7f46167e85d1aae2fd31f23e7d2b5cdfbe0:
> 
>   Merge branch 'for_3.10/omap_generic_cleanup_v2' of git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux into omap-for-v3.10/cleanup-v2 (2013-03-28 14:45:31 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/omap-pm-v3.10/cleanup/pm
> 
> for you to fetch changes up to 705814b5ea6ff69d4da8ad581c3da5d26d1eae83:
> 
>   ARM: OMAP4+: PM: Consolidate OMAP4 PM code to re-use it for OMAP5 (2013-04-09 10:53:06 -0700)
> 
> ----------------------------------------------------------------
> OMAP PM cleanups for v3.10
> 
> ----------------------------------------------------------------
> Santosh Shilimkar (4):
>       ARM: OMAP4: PM: Avoid expensive cpu_suspend() path for all CPU power states except off
>       ARM: OMAP4+: PM: Consolidate MPU subsystem PM code for re-use
>       ARM: OMAP4+: Make secondary_startup function name more consistent
>       ARM: OMAP4+: PM: Consolidate OMAP4 PM code to re-use it for OMAP5
> 
>  arch/arm/mach-omap2/common.h              |  4 +-
>  arch/arm/mach-omap2/omap-headsmp.S        |  8 ++--
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c | 69 +++++++++++++++++++++++++------
>  arch/arm/mach-omap2/omap-smp.c            |  6 +--
>  arch/arm/mach-omap2/pm44xx.c              | 58 +++++++++++++++++++++-----
>  5 files changed, 113 insertions(+), 32 deletions(-)
