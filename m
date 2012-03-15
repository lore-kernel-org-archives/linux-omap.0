From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: Lost fixes?
Date: Thu, 15 Mar 2012 11:44:50 +0100
Message-ID: <20120315104450.GA20705@sortiz-mobl>
References: <20120315102845.GB16389@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27960 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287Ab2COKhz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Mar 2012 06:37:55 -0400
Content-Disposition: inline
In-Reply-To: <20120315102845.GB16389@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: cpufreq@vger.kernel.org, Dave Jones <davej@redhat.com>, Grant Likely <grant.likely@secretlab.ca>, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>

On Thu, Mar 15, 2012 at 10:28:45AM +0000, Russell King - ARM Linux wrote:
> These fixes are a collection from other people which resolve various
> issues found with the new kautobuilder.  They're now a month old, and
> as far as I can see, have not been merged into Linus' tree.
> 
> What's the status of them, and when are they going to be merged?
For the drivers/mfd/da9052-spi.c part: A patch from Axel Lin has been living
in my for-next branch for a while now. It's a section mismatch warning fix, so
not something I consider worth sending to Linus after the merge window is
closed. So it's queued for the next one.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
