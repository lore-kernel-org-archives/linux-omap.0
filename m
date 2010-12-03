From: Paul Walmsley <paul@pwsan.com>
Subject: RE: Unbalanced IRQ wake disable during resume from static suspend
Date: Fri, 3 Dec 2010 03:23:09 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012030315510.17078@utopia.booyaka.com>
References: <alpine.DEB.2.00.1012020057550.2515@utopia.booyaka.com> <alpine.DEB.2.00.1012020112540.2515@utopia.booyaka.com> <1c6ea016b8c01ee8b470e95fdcae4ee0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41364 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441Ab0LCKXK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Dec 2010 05:23:10 -0500
In-Reply-To: <1c6ea016b8c01ee8b470e95fdcae4ee0@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Govindraj <govindraj.ti@gmail.com>, khilman@deeprootsystems.com

Hello Santosh

On Thu, 2 Dec 2010, Santosh Shilimkar wrote:

> Just a wild guess here but is this because the 'set_wake' is
> not setup and then fw might be returning some error whenever
> driver invoke this API as part of enable_irq_wake() callback
> 
> If that being the case, below patch might might help. Can
> somebody try this out ?

This patch might remove the warnings, but I doubt that it solves the root 
cause.  In any case, it doesn't seem correct to unconditionally return 0 
(success) from an omap_irq_wake() function, given that the OMAP INTC has 
no functionality in this regard.

The real problem appears to be in drivers/serial/serial_core.c.  
uart_suspend_port() doesn't check the return value of enable_irq_wake().  
Seems to me that it needs to save that return value somewhere and not 
bother calling disable_irq_wake() in uart_resume_port() if 
enable_irq_wake() returned an error.

That's the patch that I'd suggest that you guys put together and send to 
the Linux serial people.


- Paul
