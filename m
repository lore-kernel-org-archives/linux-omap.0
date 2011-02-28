From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Way operation
	can cause data corruption
Date: Mon, 28 Feb 2011 10:13:51 +0000
Message-ID: <20110228101351.GA30781@n2100.arm.linux.org.uk>
References: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com> <1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com> <20110227120021.GA15314@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59555 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab1B1KOR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Feb 2011 05:14:17 -0500
Content-Disposition: inline
In-Reply-To: <20110227120021.GA15314@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: tony@atomide.com, catalin.marinas@arm.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Feb 27, 2011 at 12:00:21PM +0000, Russell King - ARM Linux wrote:
> > +#else
> > +/* Optimised out for non-errata case */
> > +static inline void debug_writel(unsigned long val)
> > +{
> >  }
> 
> #define l2x0_set_debug	NULL
> 
> > +#endif

I notice you got rid of the inline function.  Have you tried building this
without the errata enabled?
