From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: Fix realtime_counter_init warning in
 timer.c
Date: Wed, 28 Nov 2012 11:39:56 +0530
Message-ID: <50B5AAB4.9010103@ti.com>
References: <1354068915-3378-1-git-send-email-jon-hunter@ti.com> <1354068915-3378-2-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------030004070506060507000305"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50654 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751110Ab2K1GJi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 01:09:38 -0500
In-Reply-To: <1354068915-3378-2-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

--------------030004070506060507000305
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On Wednesday 28 November 2012 07:45 AM, Jon Hunter wrote:
> In commit fa6d79d (ARM: OMAP: Add initialisation for the real-time
> counter), the function realtime_counter_init() was added. However, if
> the kernel configuration option CONFIG_SOC_OMAP5 is not selected then
> the following compiler warning is observed.
>
>    CC      arch/arm/mach-omap2/timer.o
>    arch/arm/mach-omap2/timer.c:489:20: warning: ‘realtime_counter_init’
>    defined but not used [-Wunused-function]
>
> Commit fa6d79d also introduced the kernel configuration option
> CONFIG_SOC_HAS_REALTIME_COUNTER. If this option is not selected then the
> a stub function for realtime_counter_init() is defined.
>
> The option CONFIG_SOC_HAS_REALTIME_COUNTER and stub function are not
> really needed because ...
>
> 1. For non-OMAP5 devices, there is no realtime counter and so
>     realtime_counter_init() function is not used.
> 2. For OMAP5 devices, CONFIG_SOC_HAS_REALTIME_COUNTER is always selected
>     and cannot be disabled, so the stub function for realtime_counter_init()
>     is never used.
>
> Fix this warning by removing the kernel configuration option
> CONFIG_SOC_HAS_REALTIME_COUNTER and stub function, and only include
> the function realtime_counter_init() if CONFIG_SOC_OMAP5 is selected.
>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
The #ifdef was avoided because the real-time counter can be used on 
other future SOCs. And the those SOCs just select
SOC_HAS_REALTIME_COUNTER. And that stub was added because OMAP5 can
work without real-time counter configuration enabled using 32K counter.
But since we are any way have that SOC_HAS_REALTIME_COUNTER always
set for SOC which wants to use it, we can actually remove the stub
and hence avoid the warning. Let me know if below patch is ok
with you ? attached the same for mailer issues

 From e000aa13e47e29fbe3473bfd0277cb057c3160cc Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Wed, 28 Nov 2012 11:28:57 +0530
Subject: [PATCH] ARM: OMAP2+: Fix realtime_counter_init warning in timer.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In commit fa6d79d (ARM: OMAP: Add initialisation for the real-time
counter), the function realtime_counter_init() was added. However, if
the kernel configuration option CONFIG_SOC_OMAP5 is not selected then
the following compiler warning is observed.

     CC      arch/arm/mach-omap2/timer.o
     arch/arm/mach-omap2/timer.c:489:20: warning: ‘realtime_counter_init’
     defined but not used [-Wunused-function]

It is because of the stub init function which was added for the cases
where realtime_counter_init() is called with 
!CONFIG_SOC_HAS_REALTIME_COUNTER.
This is actually not necessary since the SOC which need this feature
will explicitly select the configuration.

So just drop the unused stub to avoid the build warning.

Patch is made after seeing Jon's patch which was wrapping the
real-time counter code under needed SOC #ifdef

Cc: Jon Hunter <jon-hunter@ti.com>

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
  arch/arm/mach-omap2/timer.c |    3 ---
  1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 69e4663..79d8e6b 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -428,9 +428,6 @@ static void __init realtime_counter_init(void)

  	iounmap(base);
  }
-#else
-static inline void __init realtime_counter_init(void)
-{}
  #endif

  #define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src,			\
-- 
1.7.9.5









--------------030004070506060507000305
Content-Type: text/x-patch;
	name="0001-ARM-OMAP2-Fix-realtime_counter_init-warning-in-timer.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename*0="0001-ARM-OMAP2-Fix-realtime_counter_init-warning-in-timer.pa";
	filename*1="tch"

>From e000aa13e47e29fbe3473bfd0277cb057c3160cc Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Wed, 28 Nov 2012 11:28:57 +0530
Subject: [PATCH] ARM: OMAP2+: Fix realtime_counter_init warning in timer.c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In commit fa6d79d (ARM: OMAP: Add initialisation for the real-time
counter), the function realtime_counter_init() was added. However, if
the kernel configuration option CONFIG_SOC_OMAP5 is not selected then
the following compiler warning is observed.

    CC      arch/arm/mach-omap2/timer.o
    arch/arm/mach-omap2/timer.c:489:20: warning: ‘realtime_counter_init’
    defined but not used [-Wunused-function]

It is because of the stub init function which was added for the cases
where realtime_counter_init() is called with !CONFIG_SOC_HAS_REALTIME_COUNTER.
This is actually not necessary since the SOC which need this feature
will explicitly select the configuration.

So just drop the unused stub to avoid the build warning.

Patch is made after seeing Jon's patch which was wrapping the
real-time counter code under needed SOC #ifdef

Cc: Jon Hunter <jon-hunter@ti.com>

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 69e4663..79d8e6b 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -428,9 +428,6 @@ static void __init realtime_counter_init(void)
 
 	iounmap(base);
 }
-#else
-static inline void __init realtime_counter_init(void)
-{}
 #endif
 
 #define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src,			\
-- 
1.7.9.5


--------------030004070506060507000305--
