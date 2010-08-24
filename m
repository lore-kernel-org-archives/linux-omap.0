From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-SR][PATCH 1/2 v2] omap3: sr: fix memory leak and simplify the code
Date: Tue, 24 Aug 2010 14:25:01 -0700
Message-ID: <87vd6zn1oy.fsf@deeprootsystems.com>
References: <1278687874-26123-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:58410 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755435Ab0HXVZF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 17:25:05 -0400
Received: by pvg2 with SMTP id 2so2799658pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 24 Aug 2010 14:25:04 -0700 (PDT)
In-Reply-To: <1278687874-26123-1-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Fri, 9 Jul 2010 10:04:34 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Thara Gopinath <thara@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>, Peter p2 De Schrijver <peter.de-schrijver@nokia.com>

Nishanth Menon <nm@ti.com> writes:

> From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
>
> This patch fixes the following problem indicated by kmemleak:
>
> kmemleak: unreferenced object 0xdf93c280 (size 64):
> kmemleak:   backtrace:
> kmemleak:     [<c00df6d4>] create_object+0x104/0x200
> kmemleak:     [<c00d7638>] kmem_cache_alloc+0xe4/0xf4
> kmemleak:     [<c000fc38>] omap_devinit_smartreflex+0x44/0x244
> kmemleak:     [<c003a33c>] do_one_initcall+0x5c/0x1b8
> kmemleak:     [<c00083fc>] kernel_init+0x94/0x110
> kmemleak:     [<c003ba04>] kernel_thread_exit+0x0/0x8
>
> The reason is that 'omap_devinit_smartreflex()' allocates 'sr_data',
> then passes it to 'omap_device_build()', which 'kmemdup()'s it and
> uses the copy. But 'omap_devinit_smartreflex()' never frees 'sr_data'.
>
> This patch make 'sr_data' to be a stack variable, which eliminates
> the memory leak and simplifies the code a bit.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Thara Gopinath <thara@ti.com>,
> Cc: Peter p2 De Schrijver <peter.de-schrijver@nokia.com>
> Cc: Nishanth Menon <nm@ti.com>
>
> Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
> Acked-by: Nishanth Menon <nm@ti.com>
> ---
> Changes from V1:
> 	rebased to latest pm-sr branch
> 	default of sr_data set to 0 to make it equivalent to kzalloc
>
> NOTE: this probably should be squashed when being send upstream along with
> rest of SR series

Thara, you appear to have fixed this problem differently in your latest
series.  Looks like you just ensured kfree() was always done, correct?

In the future, it would be helpful if you would reply to these proposed
fixes on the list so we know if they are incorporated or handled
differently.

Thanks,

Kevin
