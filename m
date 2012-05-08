From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP3/4: consolidate cpuidle Makefile
Date: Tue, 08 May 2012 13:44:56 -0700
Message-ID: <87wr4mmmgn.fsf@ti.com>
References: <1336151921-9485-1-git-send-email-daniel.lezcano@linaro.org>
	<1336151921-9485-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:50338 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753681Ab2EHUom (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 16:44:42 -0400
Received: by pbbrq2 with SMTP id rq2so8844782pbb.34
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 13:44:40 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> Define a CPU_IDLE section in the makefile, declare the functions in
> the header files conforming to the kernel coding rules and remove the
> 'define's in the C files.
>
> CONFIG_PM is enabled when CPU_IDLE is enabled because the cpuidle drivers
> use some functions from the pm subsystem.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Jean Pihet <j-pihet@ti.com>

The changelog doesn't really answer "why" this change is needed.  IOW, I
don't understand from the changelog exactly what problem this patch is
trying to solve.

AFAICT, it's just shuffling around the dependencies, and changes the
omap*_idle_init() calls into inline nops instead of function call nops.

Kevin
