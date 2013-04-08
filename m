From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] OMAP: PM: fixes for v3.10
Date: Mon, 8 Apr 2013 10:02:54 -0700
Message-ID: <20130408170253.GL10155@atomide.com>
References: <87hajkjz89.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63921 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S935086Ab3DHRC4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 13:02:56 -0400
Content-Disposition: inline
In-Reply-To: <87hajkjz89.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

* Kevin Hilman <khilman@linaro.org> [130405 17:14]:
> Tony,
> 
> This OMAP PM fixes tag is based on your cleanup-v2 branch due to some
> dependencies in the series from Santosh you already merged.
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
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/omap-pm-v3.10/fixes/pm
> 
> for you to fetch changes up to b7806dc7cba840ea538706621486475d93a53c55:
> 
>   ARM: OMAP4+: PM: Restore CPU power state to ON with clockdomain force wakeup method (2013-04-05 14:19:25 -0700)
> 
> ----------------------------------------------------------------
> OMAP PM fixes for v3.10

Thanks pulling into omap-for-v3.10/fixes-pm.

Regards,

Tony
 
> ----------------------------------------------------------------
> Santosh Shilimkar (1):
>       ARM: OMAP4+: PM: Restore CPU power state to ON with clockdomain force wakeup method
> 
>  arch/arm/mach-omap2/cpuidle44xx.c |  1 +
>  arch/arm/mach-omap2/omap-smp.c    | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
