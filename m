From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 2/3] ARM: OMAP4: Fix build error and warning in timer.c
Date: Tue, 27 Nov 2012 20:15:14 -0600
Message-ID: <1354068915-3378-3-git-send-email-jon-hunter@ti.com>
References: <1354068915-3378-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41407 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961Ab2K1CPk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Nov 2012 21:15:40 -0500
In-Reply-To: <1354068915-3378-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>, Igor Grinberg <grinberg@compulab.co.il>

When compiling the kernel with configuration option CONFIG_ARCH_OMAP4
enabled and CONFIG_LOCAL_TIMERS disabled, the following build error and
warning is seen.

  CC      arch/arm/mach-omap2/timer.o
  arch/arm/mach-omap2/timer.c: In function =E2=80=98omap4_local_timer_i=
nit=E2=80=99:
  arch/arm/mach-omap2/timer.c:630:2: error: implicit declaration of
  	function =E2=80=98omap4_sync32_timer_init=E2=80=99
	[-Werror=3Dimplicit-function-declaration]
  arch/arm/mach-omap2/timer.c: At top level:
  arch/arm/mach-omap2/timer.c:607:1: warning: =E2=80=98omap4_sync32k_ti=
mer_init=E2=80=99
  	defined but not used [-Wunused-function]
  cc1: some warnings being treated as errors
  make[1]: *** [arch/arm/mach-omap2/timer.o] Error 1

This issue was introduced by commit 6f80b3b (ARM: OMAP2+: timer: remove
CONFIG_OMAP_32K_TIMER) where the "k" is missing from the "sync32k" in
the function name "omap4_sync32_timer_init". Therefore, correct this
typo to resolve the above error and warning.

Cc: Igor Grinberg <grinberg@compulab.co.il>

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index a9f99e3..eb96712 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -627,7 +627,7 @@ static void __init omap4_local_timer_init(void)
 #else /* CONFIG_LOCAL_TIMERS */
 static inline void omap4_local_timer_init(void)
 {
-	omap4_sync32_timer_init();
+	omap4_sync32k_timer_init();
 }
 #endif /* CONFIG_LOCAL_TIMERS */
 OMAP_SYS_TIMER(4, local);
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
