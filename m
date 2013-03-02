From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] gpio/omap: warn if bank is not enabled on setting irq type
Date: Sat, 02 Mar 2013 19:40:07 +0000
Message-ID: <20130302194007.2307C3E1165@localhost>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com> <1362158568-1624-3-git-send-email-jon-hunter@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:56628 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217Ab3CCMHu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 3 Mar 2013 07:07:50 -0500
Received: by mail-pa0-f41.google.com with SMTP id fb11so2658160pad.28
        for <linux-omap@vger.kernel.org>; Sun, 03 Mar 2013 04:07:50 -0800 (PST)
In-Reply-To: <1362158568-1624-3-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, Jon Hunter <jon-hunter@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Fri, 1 Mar 2013 11:22:48 -0600, Jon Hunter <jon-hunter@ti.com> wrote:
> For OMAP devices, if a gpio is being used as an interrupt source but has
> not been requested by calling gpio_request(), a call to request_irq()
> may cause the kernel hang because the gpio bank may be disabled and
> hence the register access will fail. To prevent such hangs, test for
> this case and warn if this is detected.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Applied, thanks.

g.

