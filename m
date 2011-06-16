From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap3: pm: Downgrade WARN for no wakeup source
Date: Thu, 16 Jun 2011 08:22:19 -0700
Message-ID: <877h8lsswk.fsf@ti.com>
References: <1308229940-27025-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:43544 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754933Ab1FPPWX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 11:22:23 -0400
Received: by mail-pv0-f180.google.com with SMTP id 21so1127412pvc.25
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 08:22:22 -0700 (PDT)
In-Reply-To: <1308229940-27025-1-git-send-email-premi@ti.com> (Sanjeev Premi's
	message of "Thu, 16 Jun 2011 18:42:20 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Sanjeev,

Sanjeev Premi <premi@ti.com> writes:

> When multiple wakeup sources are defined in a system,
> there is a small window, when more than one source
> can trigger wakeup interrupt.
>
> In the current implementation, the do-while() loop
> can handle all wakeup sources that are recorded when
> probing the status register in prcm_interrupt_handler().
>
> When the ISR executes due to next queued wakeup, it
> there is nothing to be handled and value of "c" is 0.

Thanks for tracking this one down.

However, It's still not clear to me what is happening here.

Why is the IRQ firing if there is nothing to be handled?  That suggests
to me that the IRQ status is not properly being cleared.

Kevin
