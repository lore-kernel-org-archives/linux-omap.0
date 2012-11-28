From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 3/3] ARM: AM335x: Fix warning in timer.c
Date: Tue, 27 Nov 2012 20:15:15 -0600
Message-ID: <1354068915-3378-4-git-send-email-jon-hunter@ti.com>
References: <1354068915-3378-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33138 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191Ab2K1CPl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Nov 2012 21:15:41 -0500
In-Reply-To: <1354068915-3378-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>, Igor Grinberg <grinberg@compulab.co.il>

When compiling the kernel with configuration options ...

 # CONFIG_ARCH_OMAP2 is not set
 # CONFIG_ARCH_OMAP3 is not set
 # CONFIG_ARCH_OMAP4 is not set
 # CONFIG_SOC_OMAP5 is not set
 CONFIG_SOC_AM33XX=3Dy

 ... the following build warning is seen.

  CC      arch/arm/mach-omap2/timer.o
  arch/arm/mach-omap2/timer.c:395:19: warning: =E2=80=98omap2_sync32k_c=
locksource_init=E2=80=99
  	defined but not used [-Wunused-function]

This issue was introduced by commit 6f80b3b (ARM: OMAP2+: timer: remove
CONFIG_OMAP_32K_TIMER) where the omap2_sync32k_clocksource_init() is no
longer referenced by the timer initialisation function for the AM335x
device as it has no 32k-sync timer.

=46ix this by only including the omap2_sync32k_clocksource_init() funct=
ion
if either OMAP2, OMAP3, OMAP4 or OMAP5 devices are enabled.

Cc: Igor Grinberg <grinberg@compulab.co.il>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index eb96712..085c7e7 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -386,6 +386,8 @@ static u32 notrace dmtimer_read_sched_clock(void)
 	return 0;
 }
=20
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+	defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
 static struct of_device_id omap_counter_match[] __initdata =3D {
 	{ .compatible =3D "ti,omap-counter32k", },
 	{ }
@@ -451,6 +453,7 @@ static int __init omap2_sync32k_clocksource_init(vo=
id)
=20
 	return ret;
 }
+#endif
=20
 static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 						const char *fck_source)
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
