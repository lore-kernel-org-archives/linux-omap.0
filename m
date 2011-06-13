From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH/RFC 0/4] OMAP: PM debug: remove register dump, misc cleanups
Date: Mon, 13 Jun 2011 17:58:05 +0530
Message-ID: <4DF60255.1070409@ti.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:42351 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752280Ab1FMM2N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jun 2011 08:28:13 -0400
Received: by mail-yi0-f48.google.com with SMTP id 24so1609074yic.35
        for <linux-omap@vger.kernel.org>; Mon, 13 Jun 2011 05:28:11 -0700 (PDT)
In-Reply-To: <1306450971-27732-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, p-titiano@ti.com

On 5/27/2011 4:32 AM, Kevin Hilman wrote:
> Inspired by Jean's work to move PM code to modules, I decided it's
> time to remove a bunch of ugly and difficult to maintain code from PM
> debug.
>
> The main chunk here is removing the register dump features for
> OMAP2/OMAP3 which are awful to read, and impossible to scale for
> OMAP4+.  Also, there are now some userspace /dev/mem-based tools (like
> omapconf) that can handle this type of thing much better, and with a
> much better interface and display.
>
> Series applies to v2.6.39.
>
I have tested this series on V3.0-rc2 as part of OMAP4 PM
series. I think it's ready for merge.

Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

> Kevin Hilman (4):
>    OMAP3: PM debug: remove sleep_while_idle feature
>    OMAP2: PM debug: remove register dumping
>    OMAP3: PM debug: remove register dumping
>    OMAP2: PM debug: move wakeup timer into clockevent code
>
>   arch/arm/mach-omap2/pm-debug.c            |  362 -----------------------------
>   arch/arm/mach-omap2/pm.h                  |    9 -
>   arch/arm/mach-omap2/pm24xx.c              |    6 +-
>   arch/arm/mach-omap2/pm34xx.c              |    6 -
>   arch/arm/mach-omap2/timer-gp.c            |   33 +++-
>   arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
>   6 files changed, 32 insertions(+), 385 deletions(-)
>

