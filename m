From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: Re: [PATCH 0/3] PM: Misc latency fixes
Date: Thu, 29 Oct 2009 12:15:56 +0200
Message-ID: <1256811356.31764.72.camel@ubuntu>
References: <> <1256125881-12441-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:33234 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752935AbZJ2KPn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Oct 2009 06:15:43 -0400
In-Reply-To: <1256125881-12441-1-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kevin,

On Wed, 2009-10-21 at 14:51 +0300, Kalle Jokiniemi wrote:
> Hello,
> Here are some fruits from digging out the latency sources
> of our idle loop. The main latency source was powerdomain
> state counter updating at beginning and end of the idle
> loop. Also PER previous state reading strangely seemed to
> cause some latency with significance. Could not find any
> TRM or errata comment to why this is, though.
> 
> The I2C mpu wakeup latency constraint patch has been updated
> to calculate latencies at boot from clkrate and fifo size.
> This was included in this set, since it benefits from the
> reduced latency of the other patches.
> 
> Patches tested on linux-omap/pm and rx-51.
> 
> Kalle Jokiniemi (3):
>       OMAP3: Only update pm-counters when needed
>       PM: Skip PER previous state register read

How about those latency optimization patches? Are you are you going to
take them in? I'd like to know if there is something to fix in those, so
I can finish it this week. Starting next week I'll be moving to other
responsibilities and might not be able to do additional changes for the
patches.

>       OMAP: I2C: Add mpu wake up latency constraint in i2c

This i2c patch can be pushed separately, in case you're waiting for that
thread to finish.

- Kalle

> 
>  arch/arm/mach-omap2/pm-debug.c |   51 ++++++++++++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/pm.h       |    2 +
>  arch/arm/mach-omap2/pm34xx.c   |   31 ++++++++++++++--------
>  arch/arm/plat-omap/i2c.c       |   54 +++++++++++++++++++++++++++++++---------
>  drivers/i2c/busses/i2c-omap.c  |   25 +++++++++++++++---
>  include/linux/i2c-omap.h       |    9 ++++++
>  6 files changed, 143 insertions(+), 29 deletions(-)
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

