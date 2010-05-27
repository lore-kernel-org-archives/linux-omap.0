From: "Premi, Sanjeev" <premi@ti.com>
Subject: omap3 pm: dependency between opp layer and cpufreq
Date: Thu, 27 May 2010 16:55:49 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E71FDD30@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49495 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754201Ab0E0LZx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 07:25:53 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4RBPoo0026485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 06:25:53 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o4RBPolf017310
	for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 16:55:50 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

While compiling for omap3_evm_defconfig, at the head of linux-omap, I encounter
these errors:

arch/arm/mach-omap2/built-in.o: In function `sr_configure_vp':
/home/premi/linux-pm/arch/arm/mach-omap2/smartreflex.c:315: undefined reference to `omap_twl_uv_to_vsel'
/home/premi/linux-pm/arch/arm/mach-omap2/smartreflex.c:364: undefined reference to `omap_twl_uv_to_vsel'
arch/arm/mach-omap2/built-in.o: In function `sr_enable':
/home/premi/linux-pm/arch/arm/mach-omap2/smartreflex.c:609: undefined reference to `omap_twl_uv_to_vsel'
arch/arm/mach-omap2/built-in.o: In function `sr_reset_voltage':
/home/premi/linux-pm/arch/arm/mach-omap2/smartreflex.c:478: undefined reference to `omap_twl_uv_to_vsel'
/home/premi/linux-pm/arch/arm/mach-omap2/smartreflex.c:496: undefined reference to `omap_twl_uv_to_vsel'
make: *** [.tmp_vmlinux1] Error 1

Turn our that comment and code in plat-omap/Makefile don't match:

# OPP support in (OMAP3+ only at the moment)
# XXX The OPP TWL/TPS code should only be included when a TWL/TPS
# PMIC is selected.
ifdef CONFIG_CPU_FREQ
obj-$(CONFIG_ARCH_OMAP3) += opp.o opp_twl_tps.o
endif

But changing CONFIG_CPU_FREQ to CONFIG_TWL4030_POWER leads to these errors:

  CC      arch/arm/plat-omap/opp.o
arch/arm/plat-omap/opp.c:54: error: redefinition of 'opp_get_voltage'
arch/arm/plat-omap/include/plat/opp.h:240: error: previous definition of 'opp_get_voltage' was here
arch/arm/plat-omap/opp.c:63: error: redefinition of 'opp_get_freq'
arch/arm/plat-omap/include/plat/opp.h:245: error: previous definition of 'opp_get_freq' was here
arch/arm/plat-omap/opp.c:79: error: conflicting types for 'opp_find_by_opp_id'
arch/arm/plat-omap/include/plat/opp.h:296: error: previous definition of 'opp_find_by_opp_id' was here
arch/arm/plat-omap/opp.c:102: error: redefinition of 'opp_get_opp_id'
arch/arm/plat-omap/include/plat/opp.h:301: error: previous definition of 'opp_get_opp_id' was here
arch/arm/plat-omap/opp.c:107: error: conflicting types for 'opp_get_opp_count'
arch/arm/plat-omap/include/plat/opp.h:250: error: previous definition of 'opp_get_opp_count' was here
arch/arm/plat-omap/opp.c:129: error: conflicting types for 'opp_find_freq_exact'
arch/arm/plat-omap/include/plat/opp.h:256: error: previous definition of 'opp_find_freq_exact' was here
arch/arm/plat-omap/opp.c:153: error: conflicting types for 'opp_find_freq_ceil'
arch/arm/plat-omap/include/plat/opp.h:268: error: previous definition of 'opp_find_freq_ceil' was here
arch/arm/plat-omap/opp.c:182: error: conflicting types for 'opp_find_freq_floor'
arch/arm/plat-omap/include/plat/opp.h:262: error: previous definition of 'opp_find_freq_floor' was here
arch/arm/plat-omap/opp.c:223: error: conflicting types for 'opp_add'
arch/arm/plat-omap/include/plat/opp.h:280: error: previous definition of 'opp_add' was here
arch/arm/plat-omap/opp.c:291: error: conflicting types for 'opp_init_list'
arch/arm/plat-omap/include/plat/opp.h:274: error: previous definition of 'opp_init_list' was here
arch/arm/plat-omap/opp.c:335: error: redefinition of 'opp_enable'
arch/arm/plat-omap/include/plat/opp.h:285: error: previous definition of 'opp_enable' was here
arch/arm/plat-omap/opp.c:345: error: redefinition of 'opp_disable'
arch/arm/plat-omap/include/plat/opp.h:290: error: previous definition of 'opp_disable' was here
arch/arm/plat-omap/opp.c:356: error: conflicting types for 'opp_init_cpufreq_table'
arch/arm/plat-omap/include/plat/opp.h:307: error: previous definition of 'opp_init_cpufreq_table' was here
make[1]: *** [arch/arm/plat-omap/opp.o] Error 1

The contents of "plat-omap/include/plat/opp.h" seem to be based on assumption that definition of OPP is
needed only for cpufreq. But even if cpufreq is disabled, this information is required for setting the
correct voltage against 'pre-defined' ARM frequency.

Questions/ comments:

1) The linkage between OPP and Voltage are not driven by the PMIC.
   They are defined by/for the silicon itself.

2) The implementation for setting the voltage should depend upon the PMIC.

3) Was there any specific need to tie the functions "opp_get_voltage" and others to cpufreq only?

I am working on a patch that should remove some of these dependencies.
But, trying to open up a discussion as well...

Best regards,
Sanjeev
