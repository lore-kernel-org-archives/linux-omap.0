From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/1] arm: omap: gpio: define .disable callback for gpio
	irq chip
Date: Wed, 5 Jan 2011 18:19:18 +0000
Message-ID: <20110105181918.GB8717@n2100.arm.linux.org.uk>
References: <1294250283-18182-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56818 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab1AESTb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 13:19:31 -0500
Content-Disposition: inline
In-Reply-To: <1294250283-18182-1-git-send-email-eduardo.valentin@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Wed, Jan 05, 2011 at 07:58:03PM +0200, Eduardo Valentin wrote:
> Currently, if one calls disable_irq(gpio_irq), the irq
> won't get disabled.
> 
> This is happening because the omap gpio code defines only
> a .mask callback. And the default_disable function is just
> a stub. The result is that, when someone calls disable_irq
> for an irq in a gpio line, it will be kept enabled.
> 
> This patch solves this issue by setting the .disable
> callback to point to the same .mask callback.

Amd this is a problem because?

The way this works is that although it isn't disabled at that point,
if it never triggers, then everything remains happy.  However, if it
does trigger, the genirq code will then mask the interrupt and won't
call the handler.
