From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] OMAP3 clock: skip reserved FREQSEL settings
Date: Fri, 21 Nov 2008 14:27:35 -0800
Message-ID: <20081121222734.GH4927@atomide.com>
References: <20081112183754.31228.73844.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61973 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbYKUW1g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2008 17:27:36 -0500
Content-Disposition: inline
In-Reply-To: <20081112183754.31228.73844.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Peter de Schrijver <peter.de-schrijver@nokia.com>

* Paul Walmsley <paul@pwsan.com> [081112 10:53]:
> Hello,
> 
> this series fixes a bug in the OMAP3 DPLL rate rounding code that will
> attempt to program the DPLL to use an internal clock frequency that
> does not exist in the FREQSEL table in 34xx TRM 4.7.6.2.  This mostly
> seems to generate warnings, but can potentially hang the system.
> 
> As part of this process, improve the DPLL rate rounding algorithm to
> start from a low divider (N) and count up; this should result in fewer
> passes through the loop.
> 
> Tested on 3430SDP ES2 and a custom ES3 board.  Thanks to Peter de Schrijver
> <peter.de-schrijver@nokia.com> for help with these patches.

Pushing this series today to l-o.

Tony

> 
> 
> - Paul
> 
> ---
> 
>    text    data     bss     dec     hex filename
> 3574155  189440  108880 3872475  3b16db vmlinux.3430sdp.orig
> 3574251  189440  108880 3872571  3b173b vmlinux.3430sdp
> 
>  arch/arm/mach-omap2/clock.c             |  118 ++++++++++++++++++++++++-------
>  arch/arm/mach-omap2/clock24xx.h         |    1 
>  arch/arm/mach-omap2/clock34xx.h         |    5 +
>  arch/arm/plat-omap/include/mach/clock.h |    1 
>  4 files changed, 99 insertions(+), 26 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
