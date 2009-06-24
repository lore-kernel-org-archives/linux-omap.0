From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [ARM][OMAP] TWL4030 IRQ
Date: Wed, 24 Jun 2009 08:57:56 +0100
Message-ID: <20090624075756.GA13052@n2100.arm.linux.org.uk>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B530E9C6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54255 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbZFXH6E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Jun 2009 03:58:04 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B530E9C6@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Jun 24, 2009 at 01:16:52PM +0530, Shilimkar, Santosh wrote:
> After digging a bit, the proposed twl_irq change would need some major 
> changes.
> 
> 1. All the T2(TWL)drivers ( rtc, madc, bci, gpio, keypad, usb, mmc)needs
> modification.Currently twl_irq fw implements kind of "twl4030_irq_chip" 
> which allows all the T2 drivers to get virtual interrupt numbers and can
> make use of standard "request_irq" linux api.

You can still use virtual interrupt numbers.  All you're changing is
_how_ you're handling the interrupts internally.

I'll see about creating a patch tomorrow.
