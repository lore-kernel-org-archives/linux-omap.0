From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/5] omap: Add support for CONFIG_AUTO_ZRELADDR for
 DEBUG_LL
Date: Fri, 4 Feb 2011 10:36:02 -0800
Message-ID: <20110204183602.GW3322@atomide.com>
References: <20110204012317.26410.55157.stgit@baageli.muru.com>
 <20110204012709.26410.78100.stgit@baageli.muru.com>
 <alpine.LFD.2.00.1102032205140.12104@xanadu.home>
 <20110204171526.GA8821@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59097 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab1BDSgd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 13:36:33 -0500
Content-Disposition: inline
In-Reply-To: <20110204171526.GA8821@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@fluxnic.net>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110204 09:14]:
> 
> The other point to make is that for every machine in OMAP1, the
> serial port is located at 0xffXXXXXX virtual, 0xfeXXXXXX physical.
> For OMAP2, that's 0xfaXXXXXX virtual and 0x48XXXXXX physical.
>
> So it's pointless storing both the virtual and physical addresses
> as we can compute one from the other with a single instruction.
> That gets rid of some of the complexity found in the debugging code.

OK. The zoom boards have external 8250 on the GPMC bus.

Tony
