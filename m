From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/11] Add L2 cache cleaning to generic CPU suspend
Date: Thu, 1 Sep 2011 16:34:51 +0100
Message-ID: <20110901153451.GA16024@n2100.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk> <20110901153342.GB5147@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41669 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932469Ab1IAPfG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 11:35:06 -0400
Content-Disposition: inline
In-Reply-To: <20110901153342.GB5147@S2100-06.ap.freescale.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Sep 01, 2011 at 11:33:43PM +0800, Shawn Guo wrote:
> This is also the case on i.MX6Q, which L2 cache is retained during a
> suspend/resume cycle.  Currently, I have to call into the following
> before calling generic cpu_suspend() to clean/invalidate the entire
> L2 cache.
> 
> 	outer_flush_all();
> 	outer_disable();
> 
> But there is a wired thing on using generic cpu_resume().  I have to
> invalidate L1 before calling into cpu_resume() like below.
> 
> ENTRY(imx6q_cpu_resume)
>         bl      v7_invalidate_l1
>         b       cpu_resume
> ENDPROC(imx6q_cpu_resume)
> 
> ENTRY(imx6q_secondary_startup)
>         bl      v7_invalidate_l1
>         b       secondary_startup
> ENDPROC(imx6q_secondary_startup)
> 
> The v7_invalidate_l1() is the function copied from mach-tegra/headsmp.S,
> which has to be called before calling secondary_startup to boot
> secondary cores (same situation between Tegra and i.MX6Q).

Presumably that's because your L1 cache contains randomized data with
random validity (and presumably random dirtyness) at boot time - something
which unfortunately the ARM ARM permits.  I don't think we can go to the
extent of dealing with this in the generic code as it would unnecessarily
perturb those implementations which either the boot loader has already
sorted out that issue, or which don't have the issue at all.

> Before applying this patch series, I have something like below actually
> working.
> 
> 
> 	outer_flush_all();
> 	outer_disable();
> 	imx_set_cpu_jump(0, imx6q_cpu_resume);
> 	/* Zzz ... */
> 	cpu_suspend(0, imx6q_suspend_finish);
> 
> I expect with you patches applied, I can still have it work with simply
> removing those two lines outer cache codes.

That should be the case.

> But unfortunately, I'm
> running into Oops when resuming back.  And I also have Oops with
> imx_set_cpu_jump(0, cpu_resume) which means skipping the
> v7_invalidate_l1() and calling generic cpu_resume() only.

Do you have a copy of the oops?
