From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [ARM][OMAP] TWL4030 IRQ
Date: Mon, 29 Jun 2009 16:43:49 +0100
Message-ID: <20090629154349.GB9042@n2100.arm.linux.org.uk>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02B530E9C6@dbde02.ent.ti.com> <20090624075756.GA13052@n2100.arm.linux.org.uk> <20090629093004.GA2111@n2100.arm.linux.org.uk> <EAF47CD23C76F840A9E7FCE10091EFAB02B53AC23F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42416 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775AbZF2Pnx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 11:43:53 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B53AC23F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Jun 29, 2009 at 09:04:53PM +0530, Shilimkar, Santosh wrote:
> Russell,
> Just a question here.
> 
> In the enable_irq(irq) and disable_irq(irq) call tree, internally there are calls to 
> the interrupt controller chip.
> 
> In disable_irq() path:
> 	desc->chip->disable(irq);
> And in emable_irq() path:
> 	desc->chip->enable(irq);
> 
> But the in gic gic_chip, enable/disable fn are not populated.

There are defaults for these.  The enable method will call the unmask
method.  Disabling of ARM IRQs has always been lazy, and this is no
different here.

> Do we need these(disable/enable) hooks in gic_chip as well ?

No.
