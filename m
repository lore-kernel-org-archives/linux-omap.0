From: Paul Walmsley <paul@pwsan.com>
Subject: Re: 3.11-rc1: OMAP3630 boot crash
Date: Mon, 29 Jul 2013 08:11:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307290809200.30864@utopia.booyaka.com>
References: <20130716165834.GH3296@blackmetal.musicnaut.iki.fi> <20130724225724.GC26943@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53512 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab3G2ILk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 04:11:40 -0400
In-Reply-To: <20130724225724.GC26943@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Thu, 25 Jul 2013, Aaro Koskinen wrote:

> On Tue, Jul 16, 2013 at 07:58:34PM +0300, Aaro Koskinen wrote:
> > I get the following boot crash on N950/RM-680 (3630) with unpatched
> > 3.11-rc1. The crash looks specific to 3630 (it happens during
> > omap3630_init_late), also the same kernel binary works with N900/RX-51
> > (3430). You can find the .config after the crash.
> 
> I put a debug print to _omap_hwmod_mux_handle_irq
> (omap_hwmod_mux_scan_wakeups), and it seems when the crash happens the
> pad name is always "uart3_rx_irrx.uart3_rx_irrx". I made another hack
> and just "continue" if the pad name is this, and the crash is gone.
> 
> Any ideas?

Nothing comes to mind, but it's worth mentioning that this doesn't happen
on the 37xx EVM here.  So it's probably RM-680-specific. 

http://www.pwsan.com/omap/testlogs/test_v3.11-rc3/20130728224046/boot/37xxevm/37xxevm_log.txt


- Paul
