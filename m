From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH E 08/14] OMAP clock: move rate recalc, propagation code up to plat-omap/clock.c
Date: Fri, 30 Jan 2009 08:52:49 +0000
Message-ID: <20090130085249.GB6864@n2100.arm.linux.org.uk>
References: <20090128192551.29333.82943.stgit@localhost.localdomain> <20090128192748.29333.5856.stgit@localhost.localdomain> <20090129174153.GH18233@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0901300135560.26985@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50797 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbZA3IxA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 03:53:00 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0901300135560.26985@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Fri, Jan 30, 2009 at 01:42:52AM -0700, Paul Walmsley wrote:
> I haven't looked closely at your above three patches for this, but plan to 
> do so later today.
> 
> Regarding provenance, the patches that I sent you were developed 
> independently, for clock notifier support.  Ultimately, I have no personal 
> attachment as to whose patches for this go in, if all technical aspects 
> are equal.

There's one bug that your version highlights in mine - the virtual mpu
clock in omap1 touches the DPLL and repropagates that rate.  I've
removed that repropagation, so that needs fixing.

However, this raises a question: why is the virtual mpu clock touching
some other part of the clock tree.  I wonder whether this should be
handled a different way, though the first thing that needs answering is
why we have this alias for 'arm_ck' ?
