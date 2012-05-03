From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 17/18][V3] ARM: OMAP3/4: consolidate cpuidle Makefile
Date: Thu, 03 May 2012 13:34:14 -0700
Message-ID: <87wr4tj96h.fsf@ti.com>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
	<1335276339-11135-18-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:36880 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753205Ab2ECUeM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 16:34:12 -0400
Received: by dakp5 with SMTP id p5so2675972dak.14
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 13:34:11 -0700 (PDT)
In-Reply-To: <1335276339-11135-18-git-send-email-daniel.lezcano@linaro.org>
	(Daniel Lezcano's message of "Tue, 24 Apr 2012 16:05:38 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> Define a CPU_IDLE section in the makefile, declare the functions in
> the header files conforming to the kernel coding rules and remove the
> 'define's in the C files.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Jean Pihet <j-pihet@ti.com>

This patch breaks compilation for the !CONFIG_PM case:

   arch/arm/mach-omap2/built-in.o: In function `__omap3_enter_idle':
   /work/kernel/omap/pm/arch/arm/mach-omap2/cpuidle34xx.c:121: undefined reference to `omap_sram_idle'

Since you moved this stuff out of a CONFIG_PM conditional part of the
Makefile, it broke because pm34xx.c is still compiled conditionally on
CONFIG_PM.

When changing Makefile/Kconfig dependencies like this, please
be sure to at least compile test with the various options
enabled/disabled.

For now, I've dropped this patch from the series.  Feel free to
update/retest/resend since the idea is fine.

Kevin

