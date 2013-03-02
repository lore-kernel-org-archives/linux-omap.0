From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/2] gpio/omap: warn if bank is not enabled on setting
 irq type
Date: Sat, 2 Mar 2013 10:57:19 +0530
Message-ID: <51318DB7.5070601@ti.com>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com> <1362158568-1624-3-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47496 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab3CBFZw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 2 Mar 2013 00:25:52 -0500
In-Reply-To: <1362158568-1624-3-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Friday 01 March 2013 10:52 PM, Jon Hunter wrote:
> For OMAP devices, if a gpio is being used as an interrupt source but has
> not been requested by calling gpio_request(), a call to request_irq()
> may cause the kernel hang because the gpio bank may be disabled and
> hence the register access will fail. To prevent such hangs, test for
> this case and warn if this is detected.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
