From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 1/4] ARM: OMAP2+: Fix realtime_counter_init warning in timer.c
Date: Wed, 28 Nov 2012 16:04:57 -0600
Message-ID: <1354140300-16825-2-git-send-email-jon-hunter@ti.com>
References: <1354140300-16825-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49433 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932727Ab2K1WFK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Nov 2012 17:05:10 -0500
In-Reply-To: <1354140300-16825-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

In commit fa6d79d (ARM: OMAP: Add initialisation for the real-time
counter), the function realtime_counter_init() was added. However, if
the kernel configuration option CONFIG_SOC_OMAP5 is not selected then
the following compiler warning is observed.

  CC      arch/arm/mach-omap2/timer.o
  arch/arm/mach-omap2/timer.c:489:20: warning: =E2=80=98realtime_counte=
r_init=E2=80=99
  defined but not used [-Wunused-function]

Commit fa6d79d also introduced the kernel configuration option
CONFIG_SOC_HAS_REALTIME_COUNTER. If this option is not selected then th=
e
a stub function for realtime_counter_init() is defined.

=46or non-OMAP5 devices, there is no realtime counter and so
realtime_counter_init() function and stub function are not used for
these devices. Therefore, fix this warning by only allowing the kernel
configuration option CONFIG_SOC_HAS_REALTIME_COUNTER to be enabled for
OMAP5 devices.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Acked-by Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 813c267..500f2f6 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -26,6 +26,8 @@ config SOC_HAS_OMAP2_SDRC
=20
 config SOC_HAS_REALTIME_COUNTER
 	bool "Real time free running counter"
+	depends on SOC_OMAP5
+	default y
=20
 config ARCH_OMAP2
 	bool "TI OMAP2"
@@ -79,7 +81,6 @@ config SOC_OMAP5
 	select ARM_GIC
 	select CPU_V7
 	select HAVE_SMP
-	select SOC_HAS_REALTIME_COUNTER
 	select COMMON_CLK
=20
 comment "OMAP Core Type"
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
