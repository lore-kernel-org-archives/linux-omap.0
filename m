From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 00/13] gpio/omap: Some more driver cleanup and fixes
Date: Mon, 12 Mar 2012 11:54:32 -0700
Message-ID: <878vj5y7iv.fsf@ti.com>
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:45499 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756430Ab2CLSyd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Mar 2012 14:54:33 -0400
Received: by iage36 with SMTP id e36so9357260iag.11
        for <linux-omap@vger.kernel.org>; Mon, 12 Mar 2012 11:54:24 -0700 (PDT)
In-Reply-To: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 7 Mar 2012 16:45:50 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> The cleanup is mostly getting rid of redundant fields in struct gpio_bank{}
> as we already have them as part of bank->context now. Also, remove un-used
> variable from gpio_irq_handler.
>
> The fixes include correction of _set_gpio_irqenable() implementation,
> missing wakeup_en register update in set_gpio_wakeup(), type mismatch
> of gpio trigger parameter in set_gpio_trigger(), incorrect dataout
> register update in set_gpio_dataout_() and few corrections in context
> save logic.
>
> It is baselined on top of Kevin's following series:
> gpio/omap: cleanup and runtime PM conversion for v3.4
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.4/gpio/runtime-pm-cleanup
>
> Series is available here for reference:
> git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_further_cleanup_fixes

This branch doesn't exist.

Kevin

