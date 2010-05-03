From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP2/3/4: DMA: reset controller during init
Date: Mon, 03 May 2010 09:03:18 -0700
Message-ID: <87zl0h6khl.fsf@deeprootsystems.com>
References: <1272891357-27400-1-git-send-email-ext-mika.1.westerberg@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52283 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933012Ab0ECQDW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 12:03:22 -0400
Received: by pwj9 with SMTP id 9so1267976pwj.19
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 09:03:20 -0700 (PDT)
In-Reply-To: <1272891357-27400-1-git-send-email-ext-mika.1.westerberg@nokia.com> (Mika Westerberg's message of "Mon\,  3 May 2010 15\:55\:57 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:

> If we are softbooting another kernel using kexec, DMA controller state is not
> known when we are performing omap_init_dma(). It is possible that some DMA
> channels are already active. For example after kexec we get:
>
> <4>IRQ 0020 for non-allocated DMAchannel 5
> <4>IRQ 0020 for non-allocated DMAchannel 5
> <4>IRQ 0020 for non-allocated DMAchannel 5
> <4>IRQ 0020 for non-allocated DMAchannel 5
> <4>IRQ 0020 for non-allocated DMAchannel 5
>
> To prevent any weird things happening, we perform soft reset for the controller
> and disable all per channel interrupts.
>
> Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>

This is a good fix, but we get reset of DMA (and all other blocks) for
free when switching to hwmod.  Here's a good reason to convert DMA
to hwmod.

Kevin
