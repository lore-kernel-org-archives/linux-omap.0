From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/4] arm: omap: prm: fix compile error
Date: Thu, 13 Jan 2011 13:41:07 +0200
Message-ID: <1294918868-16263-4-git-send-email-balbi@ti.com>
References: <1294918868-16263-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:34247 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932891Ab1AMLl3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Jan 2011 06:41:29 -0500
Received: by mail-yi0-f47.google.com with SMTP id 16so793978yie.20
        for <linux-omap@vger.kernel.org>; Thu, 13 Jan 2011 03:41:29 -0800 (PST)
In-Reply-To: <1294918868-16263-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

when building OMAP4-only kernel, the following
comnpile errors appear:

arch/arm/mach-omap2/built-in.o: In function `pm_dbg_regset_store':
/home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/pm-debug.c:335:
undefined reference to `omap2_prm_read_mod_reg'
arch/arm/mach-omap2/built-in.o: In function `omap2_pm_dump':
/home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/pm-debug.c:121:
undefined reference to `omap2_prm_read_mod_reg'
/home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/pm-debug.c:123:
undefined reference to `omap2_prm_read_mod_reg'
/home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/pm-debug.c:124:
undefined reference to `omap2_prm_read_mod_reg'
/home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/pm-debug.c:125:
undefined reference to `omap2_prm_read_mod_reg'
arch/arm/mach-omap2/built-in.o:/home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/prcm.c:53:
more undefined references to `omap2_prm_read_mod_reg' follow
arch/arm/mach-omap2/built-in.o: In function `omap_prcm_arch_reset':
/home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/prcm.c:106:
undefined reference to `omap2_prm_set_mod_reg_bits'
/home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/prcm.c:108:
undefined reference to `omap2_prm_read_mod_reg'
arch/arm/mach-omap2/built-in.o: In function `clkdm_add_wkdep':
/home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/clockdomain.c:440:
undefined reference to `omap2_prm_set_mod_reg_bits'
arch/arm/mach-omap2/built-in.o: In function `clkdm_del_wkdep':
/home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/clockdomain.c:475:
undefined reference to `omap2_prm_clear_mod_reg_bits'
arch/arm/mach-omap2/built-in.o: In function `clkdm_read_wkdep':
/home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/clockdomain.c:511:
undefined reference to `omap2_prm_read_mod_bits_shift'
arch/arm/mach-omap2/built-in.o: In function `clkdm_clear_all_wkdeps':
/home/balbi/workspace/linux-2.6/arch/arm/mach-omap2/clockdomain.c:545:
undefined reference to `omap2_prm_clear_mod_reg_bits'
make: *** [.tmp_vmlinux1] Error 1

fix them.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/prm2xxx_3xxx.h |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 53d44f6..3a50d22 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -229,6 +229,7 @@
 
 #ifndef __ASSEMBLER__
 
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 /* Power/reset management domain register get/set */
 extern u32 omap2_prm_read_mod_reg(s16 module, u16 idx);
 extern void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx);
@@ -241,6 +242,26 @@ extern u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
 extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
 extern int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
 extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift);
+#else
+static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
+{  return 0;  }
+static inline void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
+{  }
+static inline u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
+{  return 0;  }
+static inline u32 omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{  return 0;  }
+static inline u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{  return 0;  }
+static inline u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
+{  return 0;  }
+static inline int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift)
+{  return 0;  }
+static inline int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift)
+{  return 0;  }
+static inline int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift)
+{  return 0;  }
+#endif
 
 #endif
 
-- 
1.7.3.4.598.g85356

