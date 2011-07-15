From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/6] OMAP3+ Clock Fixes
Date: Fri, 15 Jul 2011 02:16:36 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107150215360.16606@utopia.booyaka.com>
References: <1310685857-3211-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46386 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964935Ab1GOIQh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jul 2011 04:16:37 -0400
In-Reply-To: <1310685857-3211-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi Jon

On Thu, 14 Jul 2011, Jon Hunter wrote:

> From: Jon Hunter <jon-hunter@ti.com>
> 
> Various clock fixes for OMAP3 and OMAP4 devices.
> Plus one debug patch (if anyone is interested).
> 
> Jon Hunter (4):
>   OMAP4: Add missing clock divider for OCP_ABE_ICLK
>   OMAP3+: use DPLLs recalc function instead of omap2_get_dpll_rate
>   OMAP3+: Update DPLL Fint range for OMAP36xx and OMAP4xxx devices
>   OMAP: Add debugfs node to show the summary of all clocks
> 
> Mike Turquette (2):
>   OMAP4: Clock: round_rate and recalc functions for DPLL_ABE
>   OMAP3+: use DPLL's round_rate when setting rate

Could you please repost these patches, cc'ing 
linux-arm-kernel@lists.infradead.org ?


- Paul
