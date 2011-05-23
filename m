From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Fix generic irq chip
Date: Mon, 23 May 2011 16:01:20 +0100
Message-ID: <20110523150120.GA15153@n2100.arm.linux.org.uk>
References: <20110520220510.GC30675@n2100.arm.linux.org.uk> <87lixx34ue.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50507 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802Ab1EWPBw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 May 2011 11:01:52 -0400
Content-Disposition: inline
In-Reply-To: <87lixx34ue.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Lennert Buytenhek <kernel@wantstofly.org>, Nicolas Pitre <nico@fluxnic.net>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org

On Mon, May 23, 2011 at 06:48:41AM -0700, Kevin Hilman wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > As a result of c42321c (genirq: Make generic irq chip depend on
> > CONFIG_GENERIC_IRQ_CHIP), we now need those platforms using this in
> > my tree to select this symbol.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > --
> > Please send acks ASAP.  Thanks to Mark for pointing this out with a patch
> > for Samsung.
> 
> Acked-by: Kevin Hilman <khilman@ti.com>

Thanks, but does that cover Davinci or OMAP?
