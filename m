From: Tony Lindgren <tony@atomide.com>
Subject: Re: State of LDP3430 platform
Date: Fri, 14 Jan 2011 16:03:02 -0800
Message-ID: <20110115000301.GT4957@atomide.com>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk>
 <20101206181913.GH8345@atomide.com>
 <alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com>
 <20101207083720.GB18336@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com>
 <alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31179 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab1AOADQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 19:03:16 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

* Paul Walmsley <paul@pwsan.com> [101207 19:30]:
> On Tue, 7 Dec 2010, Paul Walmsley wrote:
> 
> Regarding the watchdog problem, unfortunately, I can't reproduce on the 
> BeagleBoard with v2.6.37-rc5 with either omap2plus_defconfig or 
> omap2plus_defconfig without CONFIG_WATCHDOG.  If you send along your 
> .config, one of us can try to reproduce the problem with it.  Do the 
> 2.6.38 hwmod and wdt patchsets fix the problem for .38, at least?

I've been seeing this on my omap4 panda. While debugging it, I left
u-boot console only running for a few minutes to see if that stays up.
It did.. And after doing that somehow now my panda boots all the way
and stays up. Weird.

Tony
