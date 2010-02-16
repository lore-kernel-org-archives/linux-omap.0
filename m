From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 08/13] OMAP3/4 clock: split into per-chip family
	files
Date: Tue, 16 Feb 2010 23:11:52 +0000
Message-ID: <20100216231152.GA22618@n2100.arm.linux.org.uk>
References: <20100211181236.795.56094.stgit@localhost.localdomain> <20100211181706.795.84644.stgit@localhost.localdomain> <alpine.DEB.2.00.1002151755530.28188@utopia.booyaka.com> <20100216192301.GQ21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45374 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933114Ab0BPXMH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 18:12:07 -0500
Content-Disposition: inline
In-Reply-To: <20100216192301.GQ21755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Ranjith Lohithakshan <ranjithl@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On Tue, Feb 16, 2010 at 11:23:01AM -0800, Tony Lindgren wrote:
> Just to comment on the naming, we should call additional cpu options
> CONFIG_CPU_OMAP3630 etc instead of CONFIG_ARCH_OMAP to avoid confusion.

Or CONFIG_SOC_OMAP3630.  OMAP3630 is not a CPU type - it's a description
of the whole system.  The CPU is just the processor and caches without
peripherals.
