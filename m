From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFT 2/3] ARM: OMAP3: PM: call pre/post transition per
 powerdomain
Date: Tue, 19 Jun 2012 09:51:14 -0700
Message-ID: <4FE0AE02.20506@ti.com>
References: <1335277420-29124-1-git-send-email-khilman@ti.com> <1335277420-29124-3-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:53613 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752067Ab2FSQvT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jun 2012 12:51:19 -0400
Received: by pbbrq2 with SMTP id rq2so9445346pbb.6
        for <linux-omap@vger.kernel.org>; Tue, 19 Jun 2012 09:51:14 -0700 (PDT)
In-Reply-To: <1335277420-29124-3-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet <jean.pihet@newoldbits.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On 04/24/2012 07:23 AM, Kevin Hilman wrote:
> We only need to call the pre/post transtion methods when we know the
> power state is changing.  First, split up the pre/post transition
> calls to be per-powerdomain, and then make them conditional on whether
> the power domain is actually changing states.
>
> Signed-off-by: Kevin Hilman<khilman@ti.com>

This patch introduced a regression where the transition counts for NEON 
were no longer accurate because I forgot to call the notifiers for NEON 
when calling them for MPU.

The diff below will be folded into this patch before submitting for v3.6.

Kevin

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8bd7daf..6226d10 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -306,8 +306,10 @@ void omap_sram_idle(void)
  			omap3_enable_io_chain();
  	}

-	if (mpu_next_state < PWRDM_POWER_ON)
+	if (mpu_next_state < PWRDM_POWER_ON) {
  		pwrdm_pre_transition(mpu_pwrdm);
+		pwrdm_pre_transition(neon_pwrdm);
+	}

  	/* PER */
  	if (per_next_state < PWRDM_POWER_ON) {
@@ -391,8 +393,10 @@ void omap_sram_idle(void)
  			omap3_disable_io_chain();
  	}

-	if (mpu_next_state < PWRDM_POWER_ON)
+	if (mpu_next_state < PWRDM_POWER_ON) {
  		pwrdm_post_transition(mpu_pwrdm);
+		pwrdm_post_transition(neon_pwrdm);
+	}
  }

  static void omap3_pm_idle(void)
