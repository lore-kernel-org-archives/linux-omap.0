From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH] Consolidate SRAM support
Date: Fri, 15 Apr 2011 17:20:45 +0100
Message-ID: <20110415162045.GG4423@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk> <4DA84AAB.60601@gmail.com> <20110415160339.GF4423@n2100.arm.linux.org.uk> <56132A77AB93C141BF06E6B96CA6CFEA1F88D9@039-SN1MPN1-004.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43551 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab1DOQVa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Apr 2011 12:21:30 -0400
Content-Disposition: inline
In-Reply-To: <56132A77AB93C141BF06E6B96CA6CFEA1F88D9@039-SN1MPN1-004.039d.mgd.msft.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nguyen Dinh-R00091 <R00091@freescale.com>
Cc: Rob Herring <robherring2@gmail.com>, Kevin Hilman <khilman@ti.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Apr 15, 2011 at 04:18:23PM +0000, Nguyen Dinh-R00091 wrote:
> >Hmm, that's nice - except for one issue.  According to my grep of
> >arch/arm/ and drivers/, nothing uses iram_alloc().  So, does anything in
> >the MX stuff use iram_alloc.c, or is it dead code left over from a
> >previous experiment?
> 
> This function will be used for suspend code in the mx5x series. I just
> got done submitting a series of patches to Sascha for a simple suspend
> that does not need running code out of IRAM yet. The next set of suspend
> patches will be using these iram functions.

Okay, so does iram_alloc() need to return a dma_addr_t or a phys_addr_t ?
Are you dealing with physical addresses for it or DMA addresses?
