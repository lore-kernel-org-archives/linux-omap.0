From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 3/4] ARM: AM335x: Fix warning in timer.c
Date: Wed, 28 Nov 2012 16:04:59 -0600
Message-ID: <1354140300-16825-4-git-send-email-jon-hunter@ti.com>
References: <1354140300-16825-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49440 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932727Ab2K1WFO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Nov 2012 17:05:14 -0500
In-Reply-To: <1354140300-16825-1-git-send-email-jon-hunter@ti.com>
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

=46ix this by adding the "__maybe_unused" compiler directive to the
omap2_sync32k_clocksource_init() function to indicate that this functio=
n
may be used for certain configurations.

Cc: Igor Grinberg <grinberg@compulab.co.il>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 3bbb244..79df809 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -392,7 +392,7 @@ static struct of_device_id omap_counter_match[] __i=
nitdata =3D {
 };
=20
 /* Setup free-running counter for clocksource */
-static int __init omap2_sync32k_clocksource_init(void)
+static int __init __maybe_unused omap2_sync32k_clocksource_init(void)
 {
 	int ret;
 	struct device_node *np =3D NULL;
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
