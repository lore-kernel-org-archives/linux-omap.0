From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and
	check for it on V6
Date: Wed, 23 Jun 2010 09:12:18 +0100
Message-ID: <20100623081218.GA16385@n2100.arm.linux.org.uk>
References: <20100621133749.24299.36154.stgit@baageli.muru.com> <20100621135120.24299.98499.stgit@baageli.muru.com> <20100622170020.GF4371@shareable.org> <20100623073912.GA12255@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49624 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab0FWIMb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 04:12:31 -0400
Content-Disposition: inline
In-Reply-To: <20100623073912.GA12255@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jamie Lokier <jamie@shareable.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jun 23, 2010 at 10:39:13AM +0300, Tony Lindgren wrote:
> Yeah that can be done for __kuser_get_tls if it's always writable.
> But __switch_to is trickier because of the CONFIG_MMU ifdefs there.

And impossible with XIP kernels.

> What if we have optional __switch_to and __kuser_get_tls implementations
> in the mm/proc-*.S files that get copied over the current locations
> if implemented?

Also problematical with XIP - if we go down the route of implementing
these by copying code fragments into the kernel, we need to strip out
XIP support or implement a second way.  Obviously having a second way
adds maintainence burden, and the second way will probably lose out
on updates.
