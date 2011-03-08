From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/2] omap_wdt: fix interface clock handling
Date: Tue, 08 Mar 2011 09:08:11 -0800
Message-ID: <87bp1lv8uc.fsf@ti.com>
References: <1299589583-22632-1-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:36038 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754587Ab1CHRIQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 12:08:16 -0500
Received: by mail-pv0-f177.google.com with SMTP id 11so1047685pvh.8
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 09:08:14 -0800 (PST)
In-Reply-To: <1299589583-22632-1-git-send-email-kalle.jokiniemi@nokia.com>
	(Kalle Jokiniemi's message of "Tue, 8 Mar 2011 15:06:21 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, ilkka.koskinen@nokia.com, wim@iguana.be

Kalle Jokiniemi <kalle.jokiniemi@nokia.com> writes:

> The runtime PM does not offer enough granularity to control
> individual clocks separately as needed. Current pm implementation
> of omap_wdt blocks the CORE power domain from idling in
> OMAP SoC, as it keeps the interface clock of the watchdog always
> on. This causes severe power leakage in devices where 
> the omap watchdog is in active use.

The iclk remains active because it's in hardware-controlled
auto-idle mode.  

I believe if you set the WDT hwmod to software-supported idle
(OCPIF_SWSUP_IDLE), the runtime PM idle (which calls omap_device idle,
then omap_hwmod_idle) should also gate the interface clock.

> This patch set reverts the omap_wdt move to runtime_pm and
> introduces a tight control of the interface clock in the driver
> to only enable it when registers are accessed. The patch is
> based on earlier patch by Atal Shargorodsky.
>
> If anyone has good suggestions how to fix this with runtime_pm,
> feel free to propose patches. Otherwise I suggest we revert
> back to something that works.

Can you try with software-supported idle and just making the runtime PM
calls more granular?

Kevin

> Tested with RX-51 S4.0 Macroboard, linux-omap-pm/pm branch and
> MeeGo armv7l release.
>
> Kalle Jokiniemi (2):
>   Revert "OMAP: WDT: Use PM runtime APIs instead of clk FW APIs"
>   Watchdog: omap_wdt: fix interface clock handling
>
>  drivers/watchdog/omap_wdt.c |   64 +++++++++++++++++++++++++++++++++++++------
>  1 files changed, 55 insertions(+), 9 deletions(-)
