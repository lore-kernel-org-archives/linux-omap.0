From: "Premi, Sanjeev" <premi@ti.com>
Subject: Errors when building for omap4 only
Date: Thu, 6 Jan 2011 18:18:27 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302482019D4@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43423 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab1AFMsd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 07:48:33 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p06CmTJU020739
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 6 Jan 2011 06:48:31 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p06CmS5t007055
	for <linux-omap@vger.kernel.org>; Thu, 6 Jan 2011 18:18:28 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap Mailing List <linux-omap@vger.kernel.org>

Hi all,
 
I was trying to build OMAP4 only kernel from the linux-omap master.
Came across few failures caused by exclusion of OMAP3/3 specific code via #ifdef.

My repo is at:
	commit fa3b4e23ec20cfc944db7cc2b30b0d82c20e4472
	Author: Tony Lindgren <tony@atomide.com>
	Date:   Thu Dec 30 12:47:00 2010 -0800

	    cbus: Fix retu_rtc_do_reset

Sharing my observations here, before I send formal patch(es).
 
1) Starting with omap2plus_defconfig, removed the OMAP2 and OMAP3
   from the build leads to these errors during compilation:
 
  CC      arch/arm/mach-omap2/clockdomain.o
arch/arm/mach-omap2/clockdomain.c: In function '_enable_hwsup':
arch/arm/mach-omap2/clockdomain.c:251: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c:254: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c: In function '_disable_hwsup':
arch/arm/mach-omap2/clockdomain.c:277: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c:280: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c: In function 'omap2_clkdm_sleep':
arch/arm/mach-omap2/clockdomain.c:744: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c: In function 'omap2_clkdm_wakeup':
arch/arm/mach-omap2/clockdomain.c:789: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c: In function 'omap2_clkdm_clk_enable':
arch/arm/mach-omap2/clockdomain.c:922: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c:926: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c: In function 'omap2_clkdm_clk_disable':
arch/arm/mach-omap2/clockdomain.c:994: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
arch/arm/mach-omap2/clockdomain.c:998: error: 'struct clockdomain' has no member named 'clktrctrl_mask'
make[1]: *** [arch/arm/mach-omap2/clockdomain.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

This patch fixes these errors:
 
diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
index de3faa2..9b459c2 100644
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -103,9 +103,7 @@ struct clockdomain {
                const char *name;
                struct powerdomain *ptr;
        } pwrdm;
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
        const u16 clktrctrl_mask;
-#endif
        const u8 flags;
        const u8 dep_bit;
        const u8 prcm_partition;

2) With this patch compilation moves ahead, but fails at linker stage with these errors:
  LD      .tmp_vmlinux1
arch/arm/mach-omap2/built-in.o: In function `pm_dbg_regset_store':
/db/psp_git/users/a0756819/linux-omap-2.6/arch/arm/mach-omap2/pm-debug.c:335: undefined reference to `omap2_prm_read_mod_reg'
arch/arm/mach-omap2/built-in.o: In function `omap2_pm_dump':
/db/psp_git/users/a0756819/linux-omap-2.6/arch/arm/mach-omap2/pm-debug.c:121: undefined reference to `omap2_prm_read_mod_reg'
/db/psp_git/users/a0756819/linux-omap-2.6/arch/arm/mach-omap2/pm-debug.c:123: undefined reference to `omap2_prm_read_mod_reg'
/db/psp_git/users/a0756819/linux-omap-2.6/arch/arm/mach-omap2/pm-debug.c:124: undefined reference to `omap2_prm_read_mod_reg'
/db/psp_git/users/a0756819/linux-omap-2.6/arch/arm/mach-omap2/pm-debug.c:125: undefined reference to `omap2_prm_read_mod_reg'
arch/arm/mach-omap2/built-in.o: In function `omap_prcm_arch_reset':
/db/psp_git/users/a0756819/linux-omap-2.6/arch/arm/mach-omap2/prcm.c:106: undefined reference to `omap2_prm_set_mod_reg_bits'
/db/psp_git/users/a0756819/linux-omap-2.6/arch/arm/mach-omap2/prcm.c:108: undefined reference to `omap2_prm_read_mod_reg'
arch/arm/mach-omap2/built-in.o: In function `omap_prcm_get_reset_sources':
/db/psp_git/users/a0756819/linux-omap-2.6/arch/arm/mach-omap2/prcm.c:53: undefined reference to `omap2_prm_read_mod_reg'
arch/arm/mach-omap2/built-in.o: In function `clkdm_clear_all_wkdeps':
/db/psp_git/users/a0756819/linux-omap-2.6/arch/arm/mach-omap2/clockdomain.c:545: undefined reference to `omap2_prm_clear_mod_reg_bits'
arch/arm/mach-omap2/built-in.o: In function `clkdm_del_wkdep':
/db/psp_git/users/a0756819/linux-omap-2.6/arch/arm/mach-omap2/clockdomain.c:475: undefined reference to `omap2_prm_clear_mod_reg_bits'
arch/arm/mach-omap2/built-in.o: In function `clkdm_read_wkdep':
/db/psp_git/users/a0756819/linux-omap-2.6/arch/arm/mach-omap2/clockdomain.c:511: undefined reference to `omap2_prm_read_mod_bits_shift'
arch/arm/mach-omap2/built-in.o: In function `clkdm_add_wkdep':
/db/psp_git/users/a0756819/linux-omap-2.6/arch/arm/mach-omap2/clockdomain.c:440: undefined reference to `omap2_prm_set_mod_reg_bits'
make: *** [.tmp_vmlinux1] Error 1

This patch is required to fix these errors:
 
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4ab82f6..ea8ff80 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -82,7 +82,7 @@ obj-$(CONFIG_ARCH_OMAP3)              += prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
 # XXX The presence of cm2xxx_3xxx.o on the line below is temporary and
 # will be removed once the OMAP4 part of the codebase is converted to
 # use OMAP4-specific PRCM functions.
-obj-$(CONFIG_ARCH_OMAP4)               += prcm.o cm2xxx_3xxx.o cminst44xx.o \
+obj-$(CONFIG_ARCH_OMAP4)               += prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o cminst44xx.o \
                                           cm44xx.o prcm_mpu44xx.o \
                                           prminst44xx.o
 
I will be collating these changes in a single patch and posting soon.
OR Should they be separate?

Best regards,
Sanjeev

