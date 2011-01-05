From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/1] arm: omap: gpio: define .disable callback for gpio
	irq chip
Date: Wed, 5 Jan 2011 20:29:39 +0000
Message-ID: <20110105202939.GC8717@n2100.arm.linux.org.uk>
References: <1294250283-18182-1-git-send-email-eduardo.valentin@nokia.com> <20110105181918.GB8717@n2100.arm.linux.org.uk> <20110105192425.GA24729@besouro.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37524 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab1AEU3w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jan 2011 15:29:52 -0500
Content-Disposition: inline
In-Reply-To: <20110105192425.GA24729@besouro.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Wed, Jan 05, 2011 at 09:24:25PM +0200, Eduardo Valentin wrote:
> > The way this works is that although it isn't disabled at that point,
> > if it never triggers, then everything remains happy.  However, if it
> > does trigger, the genirq code will then mask the interrupt and won't
> > call the handler.
> 
> Right.. I didn't see from this point. I will check how that gets unmasked.
> But even so, if I understood correctly what you described, it would still
> open a time window which the system would see at least 1 interrupt during
> the time it was not suppose to. And that can wakeup a system which  is in
> deep sleep mode, either via dynamic idle or static suspend.
> 
> It is unlikely, I know. But it can still happen. And can be avoided.

Maybe a system going into deep sleep mode should update the masked state
of the interrupts to reflect the lazy-disable state?
