From: Tony Lindgren <tony@atomide.com>
Subject: Re: The old omapfb support
Date: Tue, 19 Apr 2011 15:30:36 +0300
Message-ID: <20110419123036.GF15620@atomide.com>
References: <1303215626.32281.70.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64468 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373Ab1DSMam (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 08:30:42 -0400
Content-Disposition: inline
In-Reply-To: <1303215626.32281.70.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: lo-ml <linux-omap@vger.kernel.org>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [110419 15:17]:
> Hi Tony, All,
> 
> Due to the recent SRAM discussion I started removing SRAM support from
> the new omapdss and omapfb driver, which was quite a simple task. Then I
> realized that the old omapfb driver also contains SRAM code, removing of
> which which wasn't such a simple task. I think I got that solved, but it
> needs still cleaning up.

OK
 
> But this again reminded me of the mess of having two display drivers,
> the old omapfb and the new DSS2. Many of the OMAP2 boards using the old
> driver should be quite easy to port to DSS2, with the exception of N800.
> DSS2 doesn't support OMAP1, so there's not much that can be done with
> those boards currently.
> 
> What is the status of OMAP1 support in general? Is having a working
> framebuffer for OMAP1 boards something we need? 

There are people actively using omap1 boards with the framebuffer, so
let's not mess with that except to remove the SRAM support.
 
> Will there be a single kernel config containing OMAP1 and OMAP2+ support
> in the future? This will cause problems, as the old and new display
> drivers cannot coexist currently.

This will not happen any time soon (if ever) because of issues supporting
anything below ARMv6 together with ARMv6 and 7 in the same kernel binary.
 
> I have never worked with an OMAP1 board, and I don't own one, and thus I
> don't have any experience on OMAP1 display HW. This will make any work I
> do on OMAP1 omapfb slightly difficult, but if there's clear need for
> OMAP1 fb, then I think the only way to go is to convert the old omapfb
> driver to an OMAP1 framebuffer driver.

Yeh we can just make old omapfb depends on ARCH_OMAP1.
 
> But whatever is decided on OMAP1 fb, I'll start converting the OMAP2
> drivers to the new DSS2.

OK great.

Tony
