From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 7/9] OMAP1: DMA: Implement in platform device model
Date: Tue, 14 Dec 2010 17:04:00 -0800
Message-ID: <20101215010400.GC3190@atomide.com>
References: <1291434246-30716-1-git-send-email-manjugk@ti.com>
 <1291434246-30716-8-git-send-email-manjugk@ti.com>
 <87d3p3q35h.fsf@deeprootsystems.com>
 <87aak7onvu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:43734 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757570Ab0LOBEG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 20:04:06 -0500
Content-Disposition: inline
In-Reply-To: <87aak7onvu.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Kevin Hilman <khilman@deeprootsystems.com> [101214 16:55]:
> Kevin Hilman <khilman@deeprootsystems.com> writes:
> 
> [...]
> 
> >
> > Using the patch below which fixes up the interrupt numbers to match the
> > original code, the memory-to-memory test is now working on OSK.
> 
> Tony, if you prefer just to fold this into the original, feel free to
> add
> 
> [khilman@deeprootsystems.com]: fixed IRQ numbers to match original code
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

OK thanks, will fold it in and let's merge them into linux-omap
master branch for few days for testing. Then if everything looks
good, I'll queue these for the 2.6.38 next merge window.

Regards,

Tony
