From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP2+: Fix build for dra7xx without omap4 and 5
Date: Fri, 15 Nov 2013 08:31:07 -0800
Message-ID: <20131115163107.GZ10317@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43205 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751416Ab3KOQbM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Nov 2013 11:31:12 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Otherwise we can get errors like:

arch/arm/mach-omap2/prm44xx.c:274: error: redefinition of =E2=80=98omap=
44xx_prm_reconfigure_io_chain=E2=80=99
arch/arm/mach-omap2/built-in.o: In function `default_finish_suspend':
arch/arm/mach-omap2/omap-mpuss-lowpower.c:95: undefined reference to `o=
map_do_wfi'

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -40,7 +40,7 @@ omap-4-5-common				=3D  omap4-common.o omap-wakeupgen=
=2Eo
 obj-$(CONFIG_ARCH_OMAP4)		+=3D $(omap-4-5-common) $(smp-y) sleep44xx.o
 obj-$(CONFIG_SOC_OMAP5)			+=3D $(omap-4-5-common) $(smp-y) sleep44xx.o
 obj-$(CONFIG_SOC_AM43XX)		+=3D $(omap-4-5-common)
-obj-$(CONFIG_SOC_DRA7XX)		+=3D $(omap-4-5-common) $(smp-y)
+obj-$(CONFIG_SOC_DRA7XX)		+=3D $(omap-4-5-common) $(smp-y) sleep44xx.o
=20
 plus_sec :=3D $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_omap-headsmp.o			:=3D-Wa,-march=3Darmv7-a$(plus_sec)
--- a/arch/arm/mach-omap2/prm44xx_54xx.h
+++ b/arch/arm/mach-omap2/prm44xx_54xx.h
@@ -42,7 +42,8 @@ extern u32 omap4_prm_vcvp_read(u8 offset);
 extern void omap4_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
=20
-#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
+	defined(CONFIG_SOC_DRA7XX)
 void omap44xx_prm_reconfigure_io_chain(void);
 #else
 static inline void omap44xx_prm_reconfigure_io_chain(void)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
