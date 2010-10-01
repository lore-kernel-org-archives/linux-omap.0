From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/2] OMAP: PM: Fix build when CONFIG_PM_DEBUG isn't set
Date: Fri,  1 Oct 2010 14:01:20 -0700
Message-ID: <1285966880-26448-3-git-send-email-khilman@deeprootsystems.com>
References: <1285966880-26448-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56120 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756202Ab0JAVB2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 17:01:28 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so4265595iwn.19
        for <linux-omap@vger.kernel.org>; Fri, 01 Oct 2010 14:01:27 -0700 (PDT)
In-Reply-To: <1285966880-26448-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Lo=C3=AFc=20Minier?= <loic.minier@linaro.org>

=46rom: Lo=C3=AFc Minier <loic.minier@linaro.org>

Since 6cdee91257bee23a46dc869ca62469b67cba2c7e the references to
enable_off_mode and sleep_while_idle can't be resolved when CONFIG_PM_D=
EBUG
isn't set:
arch/arm/mach-omap2/built-in.o: In function `omap_uart_restore_context'=
:
arch/arm/mach-omap2/serial.c:253: undefined reference to `enable_off_mo=
de'
arch/arm/mach-omap2/built-in.o: In function `omap3_can_sleep':
arch/arm/mach-omap2/pm34xx.c:479: undefined reference to `sleep_while_i=
dle'

Simply #define these in pm.h just like omap2_pm_debug.

Signed-off-by: Lo=C3=AFc Minier <loic.minier@linaro.org>
[khilman: moved down into existing #ifdef section]
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 77770a1..0d75bfd 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -13,9 +13,6 @@
=20
 #include <plat/powerdomain.h>
=20
-extern u32 enable_off_mode;
-extern u32 sleep_while_idle;
-
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
@@ -50,10 +47,14 @@ extern struct omap_dm_timer *gptimer_wakeup;
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);
 extern void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds);
 extern int omap2_pm_debug;
+extern u32 enable_off_mode;
+extern u32 sleep_while_idle;
 #else
 #define omap2_pm_dump(mode, resume, us)		do {} while (0);
 #define omap2_pm_wakeup_on_timer(seconds, milliseconds)	do {} while (0=
);
 #define omap2_pm_debug				0
+#define enable_off_mode 0
+#define sleep_while_idle 0
 #endif
=20
 #if defined(CONFIG_CPU_IDLE)
--=20
1.7.2.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
