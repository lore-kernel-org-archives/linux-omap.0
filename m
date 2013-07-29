From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: 3.11-rc1: OMAP3630 boot crash
Date: Mon, 29 Jul 2013 23:38:56 +0300
Message-ID: <20130729203856.GB30725@blackmetal.musicnaut.iki.fi>
References: <20130716165834.GH3296@blackmetal.musicnaut.iki.fi>
 <20130724225724.GC26943@blackmetal.musicnaut.iki.fi>
 <alpine.DEB.2.02.1307290809200.30864@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:37730 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015Ab3G2UjE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 16:39:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1307290809200.30864@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Mon, Jul 29, 2013 at 08:11:39AM +0000, Paul Walmsley wrote:
> On Thu, 25 Jul 2013, Aaro Koskinen wrote:
> 
> > On Tue, Jul 16, 2013 at 07:58:34PM +0300, Aaro Koskinen wrote:
> > > I get the following boot crash on N950/RM-680 (3630) with unpatched
> > > 3.11-rc1. The crash looks specific to 3630 (it happens during
> > > omap3630_init_late), also the same kernel binary works with N900/RX-51
> > > (3430). You can find the .config after the crash.
> > 
> > I put a debug print to _omap_hwmod_mux_handle_irq
> > (omap_hwmod_mux_scan_wakeups), and it seems when the crash happens the
> > pad name is always "uart3_rx_irrx.uart3_rx_irrx". I made another hack
> > and just "continue" if the pad name is this, and the crash is gone.
> > 
> > Any ideas?
> 
> Nothing comes to mind, but it's worth mentioning that this doesn't happen
> on the 37xx EVM here.  So it's probably RM-680-specific. 

Probably timing specific... I enabled CONFIG_DEBUG_FS and the crash
went away.

A.
