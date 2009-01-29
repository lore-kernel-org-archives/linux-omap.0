From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH C 08/13] OMAP3 clock: put DPLL into bypass if bypass rate = clk->rate, not hardware rate
Date: Thu, 29 Jan 2009 10:35:06 +0000
Message-ID: <20090129103506.GC12627@n2100.arm.linux.org.uk>
References: <20090128190724.12092.22239.stgit@localhost.localdomain> <20090128190829.12092.86115.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56451 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbZA2KfU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 05:35:20 -0500
Content-Disposition: inline
In-Reply-To: <20090128190829.12092.86115.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <tero.kristo@nokia.com>

On Wed, Jan 28, 2009 at 12:08:32PM -0700, Paul Walmsley wrote:
> When a non-CORE DPLL is enabled via omap3_noncore_dpll_enable(), use
> the user's desired rate in clk->rate to determine whether to put the
> DPLL into bypass or lock mode, rather than reading the DPLL's current
> idle state from its hardware registers.
> 
> This fixes a bug observed when leaving retention. Non-CORE DPLLs were
> not being relocked when downstream clocks re-enabled; rather, the DPLL
> entered bypass mode.
> 
> Problem reported by Tero Kristo <tero.kristo@nokia.com>.
> 
> linux-omap source commit is 8b1f0bd44fe490ec631230c8c040753a2bda8caa.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Cc: Tero Kristo <tero.kristo@nokia.com>

Patch 6 did it this way.  Patch 7 changed it to use omap2_get_dpll_rate()
and this patch changes it back.  What's the point of submitting all this
detail?  It's just pure noise.  Collapse these three patches into one
please.
