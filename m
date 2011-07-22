From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv5 04/11] OMAP2+: hwmod: add support for PAD wakeup interrupts
Date: Fri, 22 Jul 2011 16:04:05 -0700
Message-ID: <87zkk5rk7u.fsf@ti.com>
References: <1309861677-2769-1-git-send-email-t-kristo@ti.com>
	<1309861677-2769-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:35723 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752584Ab1GVXEJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jul 2011 19:04:09 -0400
Received: by mail-pz0-f52.google.com with SMTP id 13so4469051pzd.11
        for <linux-omap@vger.kernel.org>; Fri, 22 Jul 2011 16:04:08 -0700 (PDT)
In-Reply-To: <1309861677-2769-5-git-send-email-t-kristo@ti.com> (Tero Kristo's
	message of "Tue, 5 Jul 2011 13:27:50 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> OMAP hwmod now provides a service routine to parse pending wakeup events
> and to call registered ISR whenever active wakeups are detected. This
> routine is called directly from PRCM interrupt handler.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Nice!

> ---
>  arch/arm/mach-omap2/omap_hwmod.c             |   19 +++++++++++++++++++
>  arch/arm/mach-omap2/prcm.c                   |    4 ++++
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +

Minor nit: I think this API belongs in the same place as the other
omap_hwmod_mux_* functions, which are currently in mux.[ch]

Kevin
