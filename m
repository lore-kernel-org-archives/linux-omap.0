From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: wait for pwrdm transition after clk_enable()
Date: Mon, 15 Dec 2008 14:47:18 -0800
Message-ID: <20081215224717.GB19551@atomide.com>
References: <1229068133-13933-1-git-send-email-tomi.valkeinen@nokia.com> <alpine.DEB.2.00.0812151536470.26754@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58006 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbYLOWrU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 17:47:20 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0812151536470.26754@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [081215 14:37]:
> On Fri, 12 Dec 2008, Tomi Valkeinen wrote:
> 
> > Enabling clock in a disabled power domain causes the power domain to be
> > turned on. However, the power transition is not always finished when
> > clk_enable() returns and this randomly crashes the kernel when an
> > interrupt happens right after the clk_enable, and the kernel tries to
> > read the irq status register for that domain.
> > 
> > Why the irq status register is inaccessible, I don't know. Also it
> > doesn't seem to be related to the module being not powered up, but to
> > the transition itself.
> > 
> > The same could perhaps happen after clk_disable also, but I have not
> > witnessed that.
> > 
> > The problem affects at least dss, cam and sgx clocks.
> > 
> > This change waits for the transition to be finished before returning
> > from omap2_clkdm_clk_enable().
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

Pushing to l-o tree, and adding to omap-fixes queue for upstream.

Tony
