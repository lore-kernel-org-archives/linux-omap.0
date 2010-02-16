From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 08/13] OMAP3/4 clock: split into per-chip family
 files
Date: Tue, 16 Feb 2010 16:48:34 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002161648070.10478@utopia.booyaka.com>
References: <20100211181236.795.56094.stgit@localhost.localdomain> <20100211181706.795.84644.stgit@localhost.localdomain> <alpine.DEB.2.00.1002151755530.28188@utopia.booyaka.com> <20100216192301.GQ21755@atomide.com>
 <20100216231152.GA22618@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33522 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933073Ab0BPXsf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 18:48:35 -0500
In-Reply-To: <20100216231152.GA22618@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Ranjith Lohithakshan <ranjithl@ti.com>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

On Tue, 16 Feb 2010, Russell King - ARM Linux wrote:

> On Tue, Feb 16, 2010 at 11:23:01AM -0800, Tony Lindgren wrote:
> > Just to comment on the naming, we should call additional cpu options
> > CONFIG_CPU_OMAP3630 etc instead of CONFIG_ARCH_OMAP to avoid confusion.
> 
> Or CONFIG_SOC_OMAP3630.  OMAP3630 is not a CPU type - it's a description
> of the whole system.  The CPU is just the processor and caches without
> peripherals.

Thanks; patch description has been updated to specify CONFIG_SOC_* 
instead.


- Paul
