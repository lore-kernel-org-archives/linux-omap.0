From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: wait for pwrdm transition after clk_enable()
Date: Mon, 15 Dec 2008 15:37:08 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812151536470.26754@utopia.booyaka.com>
References: <1229068133-13933-1-git-send-email-tomi.valkeinen@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34665 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbYLOWhJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 17:37:09 -0500
In-Reply-To: <1229068133-13933-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org

On Fri, 12 Dec 2008, Tomi Valkeinen wrote:

> Enabling clock in a disabled power domain causes the power domain to be
> turned on. However, the power transition is not always finished when
> clk_enable() returns and this randomly crashes the kernel when an
> interrupt happens right after the clk_enable, and the kernel tries to
> read the irq status register for that domain.
> 
> Why the irq status register is inaccessible, I don't know. Also it
> doesn't seem to be related to the module being not powered up, but to
> the transition itself.
> 
> The same could perhaps happen after clk_disable also, but I have not
> witnessed that.
> 
> The problem affects at least dss, cam and sgx clocks.
> 
> This change waits for the transition to be finished before returning
> from omap2_clkdm_clk_enable().
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

- Paul
