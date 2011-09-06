From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 00/25] gpio/omap: driver cleanup and fixes
Date: Tue, 06 Sep 2011 16:25:25 -0700
Message-ID: <87bouxz21m.fsf@ti.com>
References: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:50312 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755343Ab1IFXZa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Sep 2011 19:25:30 -0400
Received: by mail-gx0-f181.google.com with SMTP id 9so645257gxk.26
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 16:25:29 -0700 (PDT)
In-Reply-To: <1314798161-19523-1-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 31 Aug 2011 19:12:16 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Hi Tarun,

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> This series is continuation of cleanup of OMAP GPIO driver and fixes.
> The cleanup include getting rid of cpu_is_* checks wherever possible,
> use of gpio_bank list instead of static array, use of unique platform
> specific value associated data member to OMAP platforms to avoid
> cpu_is_* checks. The series also include PM runtime support.*

I tested this series on top of v3.1-rc4 using a 3430/n900 platform.

During suspend the PER powerdomain does not hit the targetted power
state.  Also, in idle PER never hits retention.

As with previous versions of this series, it appears to be related to
debounce clocks being left enabled.  On my n900, I removed debounce from
all the GPIO keys pads and PER was then able to hit retention during
suspend and idle.

Please be sure to test on a platform that is using debounce, or modify
the board file for one of the platforms your testing so that at least
one of the GPIOs has debounce enabled so you are verifying the debounce
clock gating during suspend and idle.

Thanks,

Kevin



