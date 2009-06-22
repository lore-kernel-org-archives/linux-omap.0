From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4 0/2] watchdog:OMAP3:Add support for IVA2, SECURE WDTs
Date: Mon, 22 Jun 2009 15:35:20 -0700
Message-ID: <877hz328yf.fsf@deeprootsystems.com>
References: <1245265882-784-1-git-send-email-ubh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f182.google.com ([209.85.222.182]:42722 "EHLO
	mail-pz0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbZFVWfT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 18:35:19 -0400
Received: by pzk12 with SMTP id 12so139865pzk.33
        for <linux-omap@vger.kernel.org>; Mon, 22 Jun 2009 15:35:22 -0700 (PDT)
In-Reply-To: <1245265882-784-1-git-send-email-ubh@ti.com> (Ulrik Bech Hald's message of "Wed\, 17 Jun 2009 14\:11\:20 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ulrik Bech Hald <ubh@ti.com>
Cc: linux-omap@vger.kernel.org

Ulrik Bech Hald <ubh@ti.com> writes:

> This patch series enables support for IVA2 and SECURE
> WDTs, available on omap34xx.
> The WDTs will be accessible (when present on device) through:
> MPU:	/dev/watchdog
> SECURE:	/dev/watchdog_secure
> IVA2:	/dev/watchdog_iva2
>
> Tested on Zoom1 OMAP3 platform

You're also changing common code that affects OMAP2.  Ideally you
should boot test on omap2, but minimum requirement is at least a
compile test.

KEvin

> Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
> --- 
> This patch set has a dependency on:
> runtime: [PATCH 1/1] watchdog: OMAP fixes: enable clock in probe, trigger timer reload
>
>  arch/arm/mach-omap1/clock.c     |    6 +-
>  arch/arm/mach-omap2/clock24xx.c |    4 -
>  arch/arm/mach-omap2/clock34xx.c |   12 ++---
>  arch/arm/plat-omap/devices.c    |   91 ++++++++++++++++++++++++++++++++--------
>  drivers/watchdog/omap_wdt.c     |   34 +++++++++++---
>  5 files changed, 112 insertions(+), 35 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
