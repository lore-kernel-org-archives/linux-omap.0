From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Fix generic irq chip
Date: Sat, 21 May 2011 00:11:01 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1105210007440.3078@ionos>
References: <20110520220510.GC30675@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44011 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228Ab1ETWLM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 May 2011 18:11:12 -0400
In-Reply-To: <20110520220510.GC30675@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>, Lennert Buytenhek <kernel@wantstofly.org>, Nicolas Pitre <nico@fluxnic.net>, linux-arm-kernel@lists.infradead.org, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org

On Fri, 20 May 2011, Russell King - ARM Linux wrote:

> As a result of c42321c (genirq: Make generic irq chip depend on
> CONFIG_GENERIC_IRQ_CHIP), we now need those platforms using this in
> my tree to select this symbol.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> --
> Please send acks ASAP.  Thanks to Mark for pointing this out with a patch
> for Samsung.

Acked-by: Thomas Gleixner <tglx@linutronix.de>

Sorry for the confusion, that patch should have hit the arm kernel
list two weeks ago, but for whatever reason it did not.

Thanks,

	tglx
