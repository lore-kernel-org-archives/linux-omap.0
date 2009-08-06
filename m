From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/3] Omap header cleanup for upcoming 2.6.32 merge
	window
Date: Thu, 6 Aug 2009 12:01:03 +0100
Message-ID: <20090806110103.GB22623@n2100.arm.linux.org.uk>
References: <20090806100614.2569.8531.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35576 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbZHFLBn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Aug 2009 07:01:43 -0400
Content-Disposition: inline
In-Reply-To: <20090806100614.2569.8531.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Thu, Aug 06, 2009 at 01:08:56PM +0300, Tony Lindgren wrote:
> Here are few patches for the upcoming merge window to remove unnecessary
> ifdeffery in the header files.

I'm not sure what the plans are wrt OMAP1 vs the later OMAPs, but
given that OMAP1 lives in a separate mach directory, I think it
would make sense for the OMAP1 parts of the headers to be moved
out to arch/arm/mach-omap1/include/mach, leaving the other parts
in arch/arm/mach-omap2/include/mach.

Common stuff can be in arch/arm/plat-omap/include/plat/ and which
should only really cover the code in arch/arm/plat-omap/
