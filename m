From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] Omap header cleanup for upcoming 2.6.32 merge
	window
Date: Thu, 6 Aug 2009 14:11:06 +0300
Message-ID: <20090806111105.GE2358@atomide.com>
References: <20090806100614.2569.8531.stgit@localhost> <20090806110103.GB22623@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60997 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578AbZHFLLS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 07:11:18 -0400
Content-Disposition: inline
In-Reply-To: <20090806110103.GB22623@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090806 14:01]:
> On Thu, Aug 06, 2009 at 01:08:56PM +0300, Tony Lindgren wrote:
> > Here are few patches for the upcoming merge window to remove unnecessary
> > ifdeffery in the header files.
> 
> I'm not sure what the plans are wrt OMAP1 vs the later OMAPs, but
> given that OMAP1 lives in a separate mach directory, I think it
> would make sense for the OMAP1 parts of the headers to be moved
> out to arch/arm/mach-omap1/include/mach, leaving the other parts
> in arch/arm/mach-omap2/include/mach.

Yees.

After this series is applied we can move the remaining omap1 specific
defines in hardware.h into omap1.h.
 
> Common stuff can be in arch/arm/plat-omap/include/plat/ and which
> should only really cover the code in arch/arm/plat-omap/

Sounds good.

Tony
