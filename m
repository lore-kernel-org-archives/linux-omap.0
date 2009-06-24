From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [ARM][OMAP] TWL4030 IRQ
Date: Wed, 24 Jun 2009 08:31:22 +0100
Message-ID: <20090624073122.GA2431@n2100.arm.linux.org.uk>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B530E7E5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46441 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbZFXHb2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 03:31:28 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B530E7E5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>

On Wed, Jun 24, 2009 at 10:37:45AM +0530, Shilimkar, Santosh wrote:
> Russell, 
> 
> After digging a bit, the proposed twl_irq change would need some major
> 
> 1. All the T2(TWL)drivers ( rtc, madc, bci, gpio, keypad, usb, mmc)needs
> 2.Above also helps to have useful entries like /proc/interrupts/rtc etc.
> 3. Register/unregister irq handlers to T2 from all the drivers

Please resend, wrapping your message sensibly.  Then I'll reply.  Thanks.
