From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
Date: Fri, 11 Feb 2011 21:07:33 +0000
Message-ID: <20110211210733.GC31529@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk> <0557426516de482c1769a50fa0b5f17a@mail.gmail.com> <20110208164747.GD6188@n2100.arm.linux.org.uk> <AANLkTimGa-Y6ddHknGe9Gar7+mWPuA_T2+6VL6ecfgxD@mail.gmail.com> <20110210130430.GB3652@n2100.arm.linux.org.uk> <1297343555.9306.9.camel@e102109-lin.cambridge.arm.com> <alpine.LFD.2.00.1102111543010.14920@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47310 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758107Ab1BKVHw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 16:07:52 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1102111543010.14920@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Feb 11, 2011 at 03:45:51PM -0500, Nicolas Pitre wrote:
> The patch below is making the code more straight forward regardless of 
> any swp emulation issues.

I don't know where you get that idea from.  What it does is make a kernel
built with a standard set of options have differing behaviour on v7 and
pre-v7 architectures.

On v7 architectures, the vectors page and user pages all become read only
to SVC mode.  On pre-v7 architectures on the same kernel, they are read-
write to SVC mode.

What we have now is that these pages are only read-only when CPU domains
are turned off - for everything.  So we know that if CPU domains are
enabled, it's read/write, otherwise it's read only.  That's more
straight forward than what this patch creates IMHO.
