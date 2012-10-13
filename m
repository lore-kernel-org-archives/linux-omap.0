From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix twd_local_timer_register regression
Date: Sat, 13 Oct 2012 18:19:06 +0530
Message-ID: <50796342.2060907@ti.com>
References: <20121012165149.GE30339@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34288 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390Ab2JMMtU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 13 Oct 2012 08:49:20 -0400
In-Reply-To: <20121012165149.GE30339@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>

On Friday 12 October 2012 10:21 PM, Tony Lindgren wrote:
> Commit 7d7e1eba (ARM: OMAP2+: Prepare for irqs.h removal)
> changed the interrupts to allow enabling sparse IRQ, but
> accidentally added the omap3 INTC base to the local IRQ.
> This causes the following:
>
> twd: can't register interrupt 45 (-22)
> twd_local_timer_register failed -22
>
> The right fix is to not add any base, as it is a local
> timer. For the OMAP44XX_IRQ_LOCALWDT we had defined earlier
> there are no users, so no need to fix that.
>
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

