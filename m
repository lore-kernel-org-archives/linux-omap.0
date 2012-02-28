From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 0/6] gpio/omap: Cleanup and adaptation to Device Tree
Date: Mon, 27 Feb 2012 17:22:59 -0800
Message-ID: <87linnrbt8.fsf@ti.com>
References: <1330122091-28113-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:58492 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756465Ab2B1BXB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 27 Feb 2012 20:23:01 -0500
Received: by mail-pw0-f43.google.com with SMTP id ro2so6421278pbb.2
        for <linux-omap@vger.kernel.org>; Mon, 27 Feb 2012 17:23:00 -0800 (PST)
In-Reply-To: <1330122091-28113-1-git-send-email-b-cousson@ti.com> (Benoit
	Cousson's message of "Fri, 24 Feb 2012 23:21:25 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Benoit Cousson <b-cousson@ti.com> writes:

> Hi Grant,
>
> Here are a couple of GPIO cleanup + the DT adaptation patches.
> This update (compared to v1 [1]) is adding an extra fix for SPARSE_IRQ support
> and add the second cell in the binding for GPIO IRQ type that was missing
> previously whereas the driver does support it.

For the OMAP GPIO changes,

Reviewed-by: Kevin Hilman <khilman@ti.com>

However, I had some problems trying to merge this to test it.

I'm also curious how/who we should merge this.  Since it depends on
stuff that Grant is queueing (or has queued), I suppose it should go
through his tree.

> This series is based on 3.3-rc4 + for_3.4/dt_base branch to get
> the needed cleanup and fixes for OMAP.
>
> The interrupt controller support is using irq_domain_add_legacy for
> the moment and will be updated next to use irqchip irq_domain.

It appears your current dt_gpio branch is based on some older version of
your dt_irq_domain branch than the one you just submitted for a pull request.

> It requires the irq_domain generalization and refinement series
> available at:
>   git://git.secretlab.ca/git/linux-2.6 irqdomain/next
>   
> It requires as well Tarun's GPIO cleanup series available at:
>   git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev for_3.4/gpio_cleanup_fixes_v9

Rather than Tarun's branch, can you use Grant's GPIO branch, which has
the final version he pulled from my for_3.4/gpio/runtime-pm-cleanup
branch.  Tarun's branch causes some merge conflicts with what Grant has
already merged.

Kevin

> This series is available here for reference:
>   git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dt_gpio





