From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 18/18][V3] ARM: OMAP3: cpuidle - set global variables static
Date: Thu, 03 May 2012 13:26:40 -0700
Message-ID: <878vh9ko3j.fsf@ti.com>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
	<1335276339-11135-19-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59104 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753530Ab2ECU0j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 16:26:39 -0400
Received: by pbbrp16 with SMTP id rp16so2638349pbb.10
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 13:26:38 -0700 (PDT)
In-Reply-To: <1335276339-11135-19-git-send-email-daniel.lezcano@linaro.org>
	(Daniel Lezcano's message of "Tue, 24 Apr 2012 16:05:39 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> and check the powerdomain lookup is successful.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 0d28596..116a0d8 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -73,7 +73,7 @@ static struct omap3_idle_statedata omap3_idle_data[] = {
>  	},
>  };
>  
> -struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
> +static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
>  
>  static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
>  				struct clockdomain *clkdm)
> @@ -252,6 +252,9 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>  	 *        its own code.
>  	 */
>  
> +	if (!mpu_pd || !core_pd || !per_pd || !cam_pd)
> +		return -ENODEV;
> +

Why check here?  cam_pd is actually used just above this code.

Also, this is in the fast path.  This should just be checked once at
init time instead of every idle path.

For those reasons, I've dropped this part of the patch (updated patch
below.)

If desired, you can send an additional patch that adds this error
checking at init time and then refuses to register the driver if any of
the pwrdms don't exist.

Kevin


>From 7870c78d0343ab39050bec01d88cdb19245fdaa9 Mon Sep 17 00:00:00 2001
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Tue, 24 Apr 2012 16:05:39 +0200
Subject: [PATCH] ARM: OMAP3: cpuidle - set global variables static

struct powerdomain varialbes are all file local, make them static.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>
[khilman@ti.com: update changelog, drop error check in fast path]
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 0d28596..9429c65 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -73,7 +73,7 @@ static struct omap3_idle_statedata omap3_idle_data[] = {
 	},
 };
 
-struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
+static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
 
 static int _cpuidle_allow_idle(struct powerdomain *pwrdm,
 				struct clockdomain *clkdm)
-- 
1.7.9.2

