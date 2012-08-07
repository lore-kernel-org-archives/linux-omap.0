From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] Revert "ARM: OMAP3: PM: call pre/post transition per powerdomain"
Date: Tue, 07 Aug 2012 15:44:47 -0700
Message-ID: <87lihqz5i8.fsf@ti.com>
References: <1344372107-17786-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:53144 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757425Ab2HGWos (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 18:44:48 -0400
Received: by pbbrp8 with SMTP id rp8so525098pbb.1
        for <linux-omap@vger.kernel.org>; Tue, 07 Aug 2012 15:44:46 -0700 (PDT)
In-Reply-To: <1344372107-17786-1-git-send-email-khilman@ti.com> (Kevin
	Hilman's message of "Tue, 7 Aug 2012 13:41:47 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <jean.pihet@newoldbits.com>, Tero Kristo <t-kristo@ti.com>, Rajendra Nayak <rnayak@ti.com>

Kevin Hilman <khilman@ti.com> writes:

> This reverts commit 58f0829b7186150318c79515f0e0850c5e7a9c89.
>
> Converstion to per-pwrdm per/post transition calls was a bit
> premature.  Only tracking MPU, PER & CORE in the idle path means we
> lose the accounting for all the other powerdomains which may also
> transition in idle.  On OMAP3, due to autodeps, several powerdomains
> transition along with MPU (e.g. DSS, USBHOST), and the accounting for
> these was lost with this patch.
>
> This patch should be revisited when the upcoming clkdm/pwrmdm/voltdm
> use-counting seires is merged since then we can properly do accounting
> without relying on a call in the idle path.
>
> Cc: Jean Pihet <jean.pihet@newoldbits.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Reported-by: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>

After some debugging with Paul, I found that the patch being reverted
here was the cause of another regression: GPIO context not being
properly restored after off mode.  This caused the nfsroot problems in
off-mode on boards with ethernet devices with GPIO IRQ lines (Overo,
37xx EVM, ...)

Updating changelog, and will post v2 shortly.

Kevin
