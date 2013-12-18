From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv10 01/41] clk: add support for platform specific clock
 I/O wrapper functions
Date: Wed, 18 Dec 2013 03:33:53 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312180332380.14039@utopia.booyaka.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com> <1385453182-24421-2-git-send-email-t-kristo@ti.com> <alpine.DEB.2.02.1312171212170.14039@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60695 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391Ab3LRDdy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Dec 2013 22:33:54 -0500
In-Reply-To: <alpine.DEB.2.02.1312171212170.14039@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Tue, 17 Dec 2013, Paul Walmsley wrote:

> On Tue, 26 Nov 2013, Tero Kristo wrote:
> 
> > Current clock wrappers assume simple and direct mapped hardware register
> > access. Improve this support by adding functionality for registering
> > platform specific clock I/O wrappers, which can be used to support
> > various features needed like endianess conversions, indexed regmap support,
> > etc. Default I/O wrapper provided also which uses the existing direct
> > I/O mapped behavior.
> 
> I think it makes more sense to define per-SoC register read and write 
> functions,

Sorry, this should have read "per-IP block register read and write 
functions".

> for the same reason that I think it makes more sense to define clock 
> data as part of the IP blocks that contain the clocks' registers.  The 
> register read and write functions should be implemented by the drivers 
> for the IP blocks that the clocks are contained in.  That way the 
> register read and write functions can take whatever steps are necessary 
> to ensure that the IP block registers are accessible before performing 
> the read/write; can implement non-MMIO register accesses if needed; and 
> can operate on register offsets, rather than absolute addresses.
> 
> Something like the following draft implementation.  Also needed would be a 
> way for clock providers that rely on the common clock providers (e.g., 
> divider, mux, etc.) to pass in the struct clk_ll_ops pointer.  I guess the 
> simplest way to implement this would be to add another set of registration 
> functions - e.g., clk_register_divider_ipb() or clk_register_divider2() or 
> something similar.  These functions would be similar to 
> clk_register_divider(), but would take a pointer to a struct clk_ll_ops 
> and pass that along to the CCF core.


- Paul
