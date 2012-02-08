From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 03/16] ARM: omap: fix broken twl-core dependencies and
 ifdefs
Date: Wed, 8 Feb 2012 10:38:15 -0800
Message-ID: <20120208183815.GC29796@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAVk-0006Gt-O1@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56744 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756818Ab2BHSiW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 13:38:22 -0500
Content-Disposition: inline
In-Reply-To: <E1RvAVk-0006Gt-O1@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:05]:
> In commit aeb5032b3f, a dependency on IRQ_DOMAIN was added, which causes
> regressions on previously working setups: a previously working non-DT
> kernel configuration now loses its PMIC support.  The lack of PMIC
> support in turn causes the loss of other functionality the kernel had.
> 
> This dependency was added because the driver now registers its
> interrupts with the IRQ domain code, presumably to prevent a build error.
> 
> The result is that OMAP3 oopses in the vp.c code (fixed by a previous
> commit) due to the lack of PMIC support.
> 
> However, even with IRQ_DOMAIN enabled, the driver oopses:
...
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This should be checked that it compiles on other platforms like x86.

Other than that:

Acked-by: Tony Lindgren <tony@atomide.com>
