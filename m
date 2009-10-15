From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] OMAP clock and clockdomain fixes for 2.6.29-rc5
Date: Wed, 14 Oct 2009 17:24:24 -0700
Message-ID: <20091015002423.GF14531@atomide.com>
References: <20091014222609.5545.7736.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57127 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756809AbZJOAZN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 20:25:13 -0400
Content-Disposition: inline
In-Reply-To: <20091014222609.5545.7736.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

* Paul Walmsley <paul@pwsan.com> [091014 15:36]:
> Hello,
> 
> This series contains:
> 
> - one OMAP2 clock fix that allows N800 to boot further (there are unrelated
>   problems with both the current linux-omap head and omap-fixes branch that
>   cause booting to fail due to other reasons), and
> 
> - one OMAP2/3 clockdomain fix that can cause clockdomain transitions to be
>   missed by the clockdomain code -- this mostly affects OMAP3 OFF mode.
> 
> These patches are also available as a git branch (based on Tony's omap-fixes
> branch) from
> 
>   git://git.pwsan.com/linux-2.6 2_6_32rc4_fixes

I've pulled these on top of the fixes I posted yesterday.

Regards,

Tony
 
> 
> - Paul
> 
> ---
> 
> Kalle Jokiniemi (1):
>       OMAP: Fix race condition with autodeps
> 
> Paul Walmsley (1):
>       OMAP2xxx clock: set up clockdomain pointer in struct clk
> 
> 
>  arch/arm/mach-omap2/clock24xx.c   |    1 +
>  arch/arm/mach-omap2/clockdomain.c |   74 ++++++++++++++++++++++---------------
>  2 files changed, 45 insertions(+), 30 deletions(-)
> 
> size:
>    text	   data	    bss	    dec	    hex	filename
> 3588474	 198624	 105152	3892250	 3b641a	vmlinux.omap3beagle.orig
> 3588562	 198624	 105152	3892338	 3b6472	vmlinux.omap3beagle.patched
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
