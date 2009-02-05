From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: MMC: recover from transfer failures - Resend
Date: Thu, 5 Feb 2009 13:32:03 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0902051323090.8131@utopia.booyaka.com>
References: <20081207213617.10456.43951.stgit@localhost> <200902020946.16508.jpihet@mvista.com> <20090202190503.GT7215@atomide.com> <200902031505.58697.jpihet@mvista.com> <20090205121045.4022c319.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58334 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbZBEUcG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2009 15:32:06 -0500
In-Reply-To: <20090205121045.4022c319.akpm@linux-foundation.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jean Pihet <jpihet@mvista.com>, tony@atomide.com, ext-adrian.hunter@nokia.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, jarkko.lavinen@nokia.com, drzeus-mmc@drzeus.cx, linux-kernel@vger.kernel.org

On Thu, 5 Feb 2009, Andrew Morton wrote:

> On Tue, 3 Feb 2009 15:05:58 +0100
> Jean Pihet <jpihet@mvista.com> wrote:
> 
> > +	while (OMAP_HSMMC_READ(host->base,
> > + 			SYSCTL) & SRD)
> > + 		;
> 
> Is a __raw_readl() sufficient to prevent the cpu from burning up here,
> or should we add cpu_relax()?

The __raw_readl() should be sufficient.  The MMC controller is located on 
the L4 CORE interconnect, so the round trip latency for the read from MMC 
is at least 90 ns, while the CPU cycle time is only about 1 to 2 ns.

> An infinite loop which assumes the hardware is perfect is always a
> worry.  But I see the driver already does that, so we're no worse off..


- Paul

