From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v7 00/26] gpio/omap: driver cleanup and fixes
Date: Thu, 22 Sep 2011 16:57:27 -0700
Message-ID: <87mxdwm8pk.fsf@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:46089 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753654Ab1IVX5d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Sep 2011 19:57:33 -0400
Received: by mail-gw0-f50.google.com with SMTP id 19so2333653gwj.9
        for <linux-omap@vger.kernel.org>; Thu, 22 Sep 2011 16:57:32 -0700 (PDT)
In-Reply-To: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 13 Sep 2011 18:32:33 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, charu@ti.com

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> This series is continuation of cleanup of OMAP GPIO driver and fixes.
> The cleanup include getting rid of cpu_is_* checks wherever possible,
> use of gpio_bank list instead of static array, use of unique platform
> specific value associated data member to OMAP platforms to avoid
> cpu_is_* checks. The series also include PM runtime support.*

PER is still not hitting retention for me on 34xx/n900 when GPIOs have
debounce enabled.  Disabling debounce in the board file makes it work.

[...]

> - Add dbclk aliases for all GPIO modules. Without this, GPIO modules were not
>   getting the correct clock handle to enable/disable debounec clock.

This isn't right.  hwmod should already be adding aliases for the
optional clocks.

After debugging this myself a bit, here's what I think may be going on.
This may not be the only problem but here's at least one of them.

First, debounce clocks are disabled in the runtime_suspend callback.

When a GPIO is freed and it's the last one in the bank, bank->mod_usage
goes to zero.

After that, pm_runtime_put_sync() is called, which will trigger the
driver's ->runtime_suspend callback.  The ->runtime_suspend() callback
checks bank->mod_usage as well, and if zero, doesn't do anything
(notably, it doesn't disable debounce clocks.)

Kevin
