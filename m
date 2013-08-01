From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [FAILURE] omap4430-sdp allnoconfig
Date: Thu, 1 Aug 2013 11:59:56 -0700
Message-ID: <20130801185956.GK8868@codeaurora.org>
References: <20130801175214.GA23053@n2100.arm.linux.org.uk>
 <51FAA4C6.10203@ti.com>
 <20130801182707.GB23053@n2100.arm.linux.org.uk>
 <51FAA985.3000809@ti.com>
 <51FAAA31.6020903@codeaurora.org>
 <51FAAAFD.6000706@codeaurora.org>
 <51FAAD73.3030103@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:40223 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563Ab3HAS77 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Aug 2013 14:59:59 -0400
Content-Disposition: inline
In-Reply-To: <51FAAD73.3030103@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, arm@kernel.org

On 08/01, Santosh Shilimkar wrote:
> This one looks fine for me. Can you send above in
> a proper patch ? Let me know if you want me to
> send it.
> 

Here's a proper patch. Olof, can you please apply this on top of
the merge (and maybe you can fix the merge again to handle the
HAVE_CAN problem I mentioned earlier).

---8<---
Subject: [PATCH] ARM: OMAP2+: Fix fallout from localtimer divorce and SMP=n

A recent patch ef3160c (ARM: OMAP2+: Divorce from local timer
API, 2013-03-04) broke the omap build when SMP=n because the TWD
functions are only compiled on SMP=y builds. Stub out the TWD
calls when the TWD isn't built in to to keep everything building.

arch/arm/mach-omap2/built-in.o: In function
`omap4_local_timer_init':
dss-common.c:(.init.text+0x1d90): undefined reference to
`twd_local_timer_register'

Reported-by: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-omap2/timer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 3b7caba..00dc53e 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -600,6 +600,7 @@ static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
+#ifdef CONFIG_HAVE_ARM_TWD
 static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, OMAP44XX_LOCAL_TWD_BASE, 29);
 void __init omap4_local_timer_init(void)
 {
@@ -618,6 +619,12 @@ void __init omap4_local_timer_init(void)
 			pr_err("twd_local_timer_register failed %d\n", err);
 	}
 }
+#else
+void __init omap4_local_timer_init(void)
+{
+	omap4_sync32k_timer_init();
+}
+#endif /* CONFIG_HAVE_ARM_TWD */
 #endif /* CONFIG_ARCH_OMAP4 */
 
 #ifdef CONFIG_SOC_OMAP5
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
