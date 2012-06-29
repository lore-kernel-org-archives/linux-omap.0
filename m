From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/1] ARM: OMAP3: PM: don't explicitly enable the IO-chain interrupt
Date: Fri, 29 Jun 2012 07:55:02 -0500
Message-ID: <87obo2mg61.fsf@ti.com>
References: <1340933123-30401-1-git-send-email-javier@dowhile0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:60211 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751488Ab2F2Myt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 08:54:49 -0400
Received: by ggmi1 with SMTP id i1so2797468ggm.2
        for <linux-omap@vger.kernel.org>; Fri, 29 Jun 2012 05:54:47 -0700 (PDT)
In-Reply-To: <1340933123-30401-1-git-send-email-javier@dowhile0.org> (Javier
	Martinez Canillas's message of "Fri, 29 Jun 2012 03:25:23 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

+Paul

Javier Martinez Canillas <javier@dowhile0.org> writes:

> commit 99b59df0 ARM: OMAP3: PM: fix shared PRCM interrupt leave disabled at boot
>
> set the IRQ_NOAUTOEN flag to the PCRM IO-chain irq to avoid this
> interrupt until the PM core code is ready to handle the interrupts.
>
> It seems that this is not needed anymore after the OMAP PRCM I/O chain
> code re-implementation introduced on merge commit:
>
> 9a17d88 Merge tag 'omap-devel-c-for-3.6' of git://git.kernel.org/pub/scm/linux/kernel/
>
> The IRQ_NOAUTOEN flags is not set for the PRCM I/O irq anymore on the
> new implementation. This has the effect that a request_irq() for the
> PRCM I/O chain irq will auto-enable the requested IRQ and a later call
> to enable_irq() will lead to the following warning:

I noticed that warning too, but I don't think $SUBJECT patch is the
right fix.

We still need the IRQ_NOAUTOEN so that cases where PM is not enabled,
the IO chain interrupts are not enabled.

Looking closer, it looks like the merge of omap-devel-c-for-3.6 removed
the IRQ_NOAUTOEN in the merge resolution, which wasn't right.

I'll cook up a fix for this.

Kevin


