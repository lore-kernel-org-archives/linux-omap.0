From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/8] OMAP4: PM: TEMP: Prevent l3init from idling/force
	sleep
Date: Thu, 23 Jun 2011 16:22:49 +0100
Message-ID: <20110623152249.GG9449@n2100.arm.linux.org.uk>
References: <1307616853-28395-1-git-send-email-rnayak@ti.com> <1307616853-28395-2-git-send-email-rnayak@ti.com> <1307616853-28395-3-git-send-email-rnayak@ti.com> <1307616853-28395-4-git-send-email-rnayak@ti.com> <1307616853-28395-5-git-send-email-rnayak@ti.com> <1307616853-28395-6-git-send-email-rnayak@ti.com> <alpine.DEB.2.00.1106230819540.12954@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43649 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758206Ab1FWPXF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jun 2011 11:23:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1106230819540.12954@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>, khilman@ti.com, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org

On Thu, Jun 23, 2011 at 09:04:20AM -0600, Paul Walmsley wrote:
> Since this is basically a hack to work around limitations of the current 
> MMC driver, if we accept something like this, I think it should come with 
> a big warning message and comment.  Something like this in 
> omap44xx_clockdomains_init():
> 
> 	/*
> 	 * XXX The OMAP L3 interconnect hardware is able to enter
> 	 * hardware-supervised idle.  But because the OMAP HSMMC
> 	 * driver still hasn't been converted to use runtime PM, if
> 	 * the L3 is allowed to enter hwsup idle, the kernel will
> 	 * crash.  Once the MMC driver is fixed (which patches have
> 	 * been posted to do, with subject line "OMAP: HSMMC: cleanup
> 	 * and runtime pm") the change to the l3_init_44xx_clkdm
> 	 * flags should be dropped.  It limits the low-power state that
> 	 * the chip can enter.
> 	 */
> 	pr_warn("WARNING: OMAP4 low power states artificially limited, due 
> to unconverted HSMMC driver\n");

Do you really want to continue pissing Linus off with churn like this
rather than pressing to get problems fixed _properly_ (eg, getting the
HSMMC driver fixed) ?
