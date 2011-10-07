From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [GIT PULL] ARM: OMAP3+: clock fixes for 3.2
Date: Fri, 7 Oct 2011 01:54:46 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110070154100.4611@utopia.booyaka.com>
References: <alpine.DEB.2.00.1110070141450.4611@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33219 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759428Ab1JGHyr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 03:54:47 -0400
In-Reply-To: <alpine.DEB.2.00.1110070141450.4611@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mturquette@ti.com, jon.hunter@ti.com

On Fri, 7 Oct 2011, Paul Walmsley wrote:

> The following changes since commit be73246058737beec52ae232bcab7776332a9e06:
> 
>   ARM: OMAP2+: Remove custom init_irq for remaining boards (2011-09-26 17:50:37 -0700)
> 
> are available in the git repository at:
>   git://git.pwsan.com/linux-2.6 omap_clock_fixes_3.2
> 
> Jon Hunter (3):
>       ARM: OMAP3+: dpll: use DPLLs recalc function instead of omap2_get_dpll_rate
>       ARM: OMAP4: clock: Add missing clock divider for OCP_ABE_ICLK
>       OMAP3+: Update DPLL Fint range for OMAP36xx and OMAP4xxx devices

By the way, the subject line for this patch has been updated in the git 
branch to be prefixed with "ARM: ".


- Paul
