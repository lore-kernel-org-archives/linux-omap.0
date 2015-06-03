From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
Date: Wed, 03 Jun 2015 22:55:27 +0200
Message-ID: <2466648.WjMxjIpAUG@wuerfel>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:63869 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753977AbbFCU4M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2015 16:56:12 -0400
In-Reply-To: <1433363565-17725-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Wednesday 03 June 2015 15:32:45 Felipe Balbi wrote:
> 
> Hi Tony and Russell,
> 
> AM43xx, even though it's a single processor A9, it still has TWD and global
> timer. I was doing some profiling with RT v4.0 and latency is 3.5x lower just
> by switching from gptimer to twd/global.
> 
> The only problem is that currently, is_smp() check prevents me from using twd
> with AM43xx (that's why it's commented below, for testing purposes).
> 
> In the hopes that we can start a, hopefully, small thread around the subject,
> I'm sending this HACK which I used to get TWD and global timer enabled so I
> could measure latencies with cyclictest.
> 
> Is it so that TWD shouldn't be available on UP integrations of ARM's Cortex-A
> processors ?
> 
> 

I wondered about this recently when looking at something unrelated
and noticed that the check had been introduced as part of
904464b91eca8 ("ARM: 7655/1: smp_twd: make twd_local_timer_of_register()
no-op for nosmp").

I suspect this was just the wrong fix at the time, and that the
real culprit is either alloc_percpu() or request_percpu_irq()
getting called too early on a machine without SMP support.

Possibly the problem is already resolved independently, if you
didn't run into it.

	Arnd
