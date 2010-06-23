From: Jamie Lokier <jamie@shareable.org>
Subject: Re: [PATCH 1/2] arm: Replace CONFIG_HAS_TLS_REG with HWCAP_TLS and check for it on V6
Date: Wed, 23 Jun 2010 14:28:14 +0100
Message-ID: <20100623132814.GB7058@shareable.org>
References: <20100621133749.24299.36154.stgit@baageli.muru.com> <20100621135120.24299.98499.stgit@baageli.muru.com> <20100622170020.GF4371@shareable.org> <20100623073912.GA12255@atomide.com> <20100623081218.GA16385@n2100.arm.linux.org.uk> <20100623092843.GC12255@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:37871 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab0FWN2R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 09:28:17 -0400
Content-Disposition: inline
In-Reply-To: <20100623092843.GC12255@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Tony Lindgren wrote:
> > Also problematical with XIP - if we go down the route of implementing
> > these by copying code fragments into the kernel, we need to strip out
> > XIP support or implement a second way.  Obviously having a second way
> > adds maintainence burden, and the second way will probably lose out
> > on updates.
> 
> How about if we implement the default XIP-safe unoptimized functions,
> with minimal iffdeffery and then allow optional override for non-XIP
> kernels from mm/proc-*.S files?

That might be a plan for some things like cache maintenance - skip a
function call when not needed, call direct instead of indirect, but
for XIP that status quo must remain.

-- Jamie
