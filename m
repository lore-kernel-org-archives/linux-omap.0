From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv7] OMAP3: Serial: Improved sleep logic
Date: Mon, 15 Mar 2010 11:49:51 -0700
Message-ID: <87d3z5zagg.fsf@deeprootsystems.com>
References: <1268408332-15579-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54892 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932739Ab0COSty (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 14:49:54 -0400
Received: by pwi1 with SMTP id 1so2169488pwi.19
        for <linux-omap@vger.kernel.org>; Mon, 15 Mar 2010 11:49:54 -0700 (PDT)
In-Reply-To: <1268408332-15579-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 12 Mar 2010 17\:38\:52 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> This patch contains following improvements:
> - Only RX interrupt will now kick the sleep prevent timer
> - TX fifo status is checked before disabling clocks, this will prevent
>   on-going transmission to be cut
> - Smartidle is now enabled/disabled only while switching clocks, as having
>   smartidle enabled while RX/TX prevents any wakeups from being received
>   from UART module
> - Added workqueue for wakeup checks, as jiffy timer access within the
>   idle loop results into skewed timers as jiffy timers are stopped
> - Added garbage_timer for ignoring the first character received during
>   the first tick after clock enable, this prevents garbage characters to be
>   received in low sleep states
> - omap_uart_enable_irqs() changed to use enable_irq / disable_irq instead
>   of request / free. Using request/free changes the behavior after first
>   suspend due to reversed interrupt handler ordering
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---

Normally, it's nice to see a summary of the changes since the previous
version here, but interdiff told me what I needed to know.

Queuing this in pm-fixes.

Thanks,

Kevin
