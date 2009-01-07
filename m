From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] ARM: OMAP: Fix gpio by switching to generic gpio calls
Date: Wed, 7 Jan 2009 16:18:43 +0000
Message-ID: <20090107161843.GA11471@n2100.arm.linux.org.uk>
References: <20090107111415.GF27566@atomide.com> <20090107111615.GG27566@atomide.com> <20090107111744.GH27566@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54261 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbZAGQSy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 11:18:54 -0500
Content-Disposition: inline
In-Reply-To: <20090107111744.GH27566@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, "Nikula Jarkko (NRC/Helsinki)" <jarkko.nikula@nokia.com>

On Wed, Jan 07, 2009 at 01:17:45PM +0200, Tony Lindgren wrote:
> -	set_irq_type(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), IRQ_TYPE_EDGE_RISING);
> -	if (request_irq(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), &apollon_sw_interrupt,
> +	set_irq_type(gpio_to_irq(SW_ENTER_GPIO16), IRQ_TYPE_EDGE_RISING);
> +	if (request_irq(gpio_to_irq(SW_ENTER_GPIO16), &apollon_sw_interrupt,

NAK.  I wonder how the f*** this got anywhere near the mainline kernel.
No no no no no.  set_irq_type + request_irq is utter crap and should be
rejected whenever its seen.  There's absolutely no need for it -
request_irq is sufficient.  Get rid of this set_irq_type usage from
everywhere please.
