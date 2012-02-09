From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] gpio: omap: be more aggressive with pm_runtime
Date: Wed, 08 Feb 2012 16:01:42 -0800
Message-ID: <877gzwyivt.fsf@ti.com>
References: <1328707614-20146-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:36577 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757706Ab2BIABp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 19:01:45 -0500
Received: by mail-pw0-f41.google.com with SMTP id wz17so1259653pbc.14
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 16:01:44 -0800 (PST)
In-Reply-To: <1328707614-20146-1-git-send-email-balbi@ti.com> (Felipe Balbi's
	message of "Wed, 8 Feb 2012 15:26:54 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, grant.likely@secretlab.ca, linus.walleij@stericsson.com, tarun.kanti@ti.com

Felipe Balbi <balbi@ti.com> writes:

> try to keep gpio block suspended as much as possible.
>
> Tested with pandaboard and a sysfs exported gpio.
>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---

Looks like you need a few more get/puts around other places where
registers are accessed.  It currently causes a boot crash on OMAP3 in
_set_gpio_triggering().

Did you test GPIO wakeups?  both IO ring wakeups and GPIO module-level
wakeups?

Kevin
