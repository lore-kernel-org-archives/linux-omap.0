From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 5/9] ARM: OMAP2+: Remove hardcoded twl4030 gpio_base,
 irq_base and irq_end
Date: Sat, 1 Sep 2012 01:16:26 +0200
Message-ID: <CACRpkdZdvK+fB8rJFU6sLALjVx1SMBRH9pvg8shkmuzbZGt8xg@mail.gmail.com>
References: <20120831004828.28732.902.stgit@muffinssi.local>
	<20120831005230.28732.1131.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35532 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755162Ab2HaXQ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Aug 2012 19:16:27 -0400
Received: by wicr5 with SMTP id r5so2191643wic.1
        for <linux-omap@vger.kernel.org>; Fri, 31 Aug 2012 16:16:26 -0700 (PDT)
In-Reply-To: <20120831005230.28732.1131.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

On Fri, Aug 31, 2012 at 2:52 AM, Tony Lindgren <tony@atomide.com> wrote:

> We can't use hardcoded interrupts for SPARSE_IRQ, and can replace
> the hardcoded gpio_base with twl_gpiochip.base after it's been
> allocated.
>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Oh, cool.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
