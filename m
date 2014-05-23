From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
Date: Fri, 23 May 2014 11:32:29 -0700
Message-ID: <20140523183228.GH2321@atomide.com>
References: <20140516212942.GK12881@atomide.com>
 <537A3544.1050307@linaro.org>
 <20140519172338.GJ4849@atomide.com>
 <537A408F.7070301@ti.com>
 <20140519175157.GK4849@atomide.com>
 <537A4827.30604@linaro.org>
 <20140519193622.GA11945@atomide.com>
 <537A5F5B.6050403@linaro.org>
 <537A7522.30007@math.uni-bielefeld.de>
 <20140523144425.GB2321@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32431 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbaEWSci (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 May 2014 14:32:38 -0400
Content-Disposition: inline
In-Reply-To: <20140523144425.GB2321@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Alex Shi <alex.shi@linaro.org>, khilman@linaro.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

* Tony Lindgren <tony@atomide.com> [140523 07:45]:
> * Tobias Jakobi <tjakobi@math.uni-bielefeld.de> [140519 14:19]:
> > 
> > But even if I don't connect via WiFi at all, just boot and let me system
> > run with serial console connected, after some time I get a kernel 'WARNING':
> > http://www.math.uni-bielefeld.de/~tjakobi/archive/dmesg.1.log
> 
> BTW, care to update the bugzilla page with the second warning
> in this log?
> 
> That's the WARNING: CPU: 1 PID: 0 at kernel/timer.c:1147 that's
> at 238 seconds.

Also, with Santosh's fix applied, can you also try disabling one
or more of the idle states for cpuidle and see if that helps?

Something like this patch below. If that helps with the WARNING
above you're getting it narrows down the problem down quite a bit.

Regards,

Tony

--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -44,11 +44,13 @@ static struct idle_statedata omap4_idle_data[] = {
 		.mpu_state = PWRDM_POWER_RET,
 		.mpu_logic_state = PWRDM_POWER_RET,
 	},
+#if 0
 	{
 		.cpu_state = PWRDM_POWER_OFF,
 		.mpu_state = PWRDM_POWER_RET,
 		.mpu_logic_state = PWRDM_POWER_OFF,
 	},
+#endif
 };
 
 static struct powerdomain *mpu_pd, *cpu_pd[MAX_CPUS];
