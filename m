From: "Premi, Sanjeev" <premi@ti.com>
Subject: Multiple errors while compiling from master
Date: Mon, 15 Mar 2010 20:04:12 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E623BAC0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48015 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932644Ab0COOeQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 10:34:16 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2FEYCfc014538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 15 Mar 2010 09:34:14 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2FEYBc5000557
	for <linux-omap@vger.kernel.org>; Mon, 15 Mar 2010 20:04:12 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

While trying to build kernel from master, I encounter many errors (pasted below).

I believe the reason is missing headers - plat/resource.h and smartreflex.h
...but I couldn't find them in the tree.

premi # ls -l arch/arm/plat-omap/include/plat/res*
ls: No match.
premi # ls -l arch/arm/mach-omap2/smart*
ls: No match.
premi #

I am at commit: a842b5f9ce70e1b738eabb4d719860070180ed1c

Best regards,
Sanjeev


arch/arm/mach-omap2/pm34xx.c:43:27: error: plat/resource.h: No such file or directory
arch/arm/mach-omap2/pm34xx.c:51:25: error: smartreflex.h: No such file or directory
arch/arm/mach-omap2/pm34xx.c:98: error: variable 'prm_setup' has initializer but incomplete type
arch/arm/mach-omap2/pm34xx.c:99: error: unknown field 'clksetup' specified in initializer
arch/arm/mach-omap2/pm34xx.c:99: warning: excess elements in struct initializer
arch/arm/mach-omap2/pm34xx.c:99: warning: (near initialization for 'prm_setup')
arch/arm/mach-omap2/pm34xx.c:100: error: unknown field 'voltsetup_time1' specified in initializer
arch/arm/mach-omap2/pm34xx.c:100: warning: excess elements in struct initializer
arch/arm/mach-omap2/pm34xx.c:100: warning: (near initialization for 'prm_setup')
arch/arm/mach-omap2/pm34xx.c:101: error: unknown field 'voltsetup_time2' specified in initializer
arch/arm/mach-omap2/pm34xx.c:101: warning: excess elements in struct initializer
arch/arm/mach-omap2/pm34xx.c:101: warning: (near initialization for 'prm_setup')
arch/arm/mach-omap2/pm34xx.c:102: error: unknown field 'voltoffset' specified in initializer
arch/arm/mach-omap2/pm34xx.c:102: warning: excess elements in struct initializer
arch/arm/mach-omap2/pm34xx.c:102: warning: (near initialization for 'prm_setup')
arch/arm/mach-omap2/pm34xx.c:103: error: unknown field 'voltsetup2' specified in initializer
arch/arm/mach-omap2/pm34xx.c:103: warning: excess elements in struct initializer
arch/arm/mach-omap2/pm34xx.c:103: warning: (near initialization for 'prm_setup')
arch/arm/mach-omap2/pm34xx.c:104: error: unknown field 'vdd0_on' specified in initializer
arch/arm/mach-omap2/pm34xx.c:104: warning: excess elements in struct initializer
arch/arm/mach-omap2/pm34xx.c:104: warning: (near initialization for 'prm_setup')
arch/arm/mach-omap2/pm34xx.c:105: error: unknown field 'vdd0_onlp' specified in initializer
arch/arm/mach-omap2/pm34xx.c:105: warning: excess elements in struct initializer
arch/arm/mach-omap2/pm34xx.c:105: warning: (near initialization for 'prm_setup')
arch/arm/mach-omap2/pm34xx.c:106: error: unknown field 'vdd0_ret' specified in initializer
arch/arm/mach-omap2/pm34xx.c:106: warning: excess elements in struct initializer
arch/arm/mach-omap2/pm34xx.c:106: warning: (near initialization for 'prm_setup')
arch/arm/mach-omap2/pm34xx.c:107: error: unknown field 'vdd0_off' specified in initializer
arch/arm/mach-omap2/pm34xx.c:107: warning: excess elements in struct initializer
arch/arm/mach-omap2/pm34xx.c:107: warning: (near initialization for 'prm_setup')
arch/arm/mach-omap2/pm34xx.c:108: error: unknown field 'vdd1_on' specified in initializer
arch/arm/mach-omap2/pm34xx.c:108: warning: excess elements in struct initializer
arch/arm/mach-omap2/pm34xx.c:108: warning: (near initialization for 'prm_setup')
arch/arm/mach-omap2/pm34xx.c:109: error: unknown field 'vdd1_onlp' specified in initializer
arch/arm/mach-omap2/pm34xx.c:109: warning: excess elements in struct initializer
arch/arm/mach-omap2/pm34xx.c:109: warning: (near initialization for 'prm_setup')
arch/arm/mach-omap2/pm34xx.c:110: error: unknown field 'vdd1_ret' specified in initializer
arch/arm/mach-omap2/pm34xx.c:110: warning: excess elements in struct initializer
arch/arm/mach-omap2/pm34xx.c:110: warning: (near initialization for 'prm_setup')
arch/arm/mach-omap2/pm34xx.c:111: error: unknown field 'vdd1_off' specified in initializer
arch/arm/mach-omap2/pm34xx.c:111: warning: excess elements in struct initializer
arch/arm/mach-omap2/pm34xx.c:111: warning: (near initialization for 'prm_setup')
arch/arm/mach-omap2/pm34xx.c: In function 'omap_sram_idle':
arch/arm/mach-omap2/pm34xx.c:411: error: implicit declaration of function 'omap2_gpio_prepare_for_idle'
arch/arm/mach-omap2/pm34xx.c:431: error: implicit declaration of function 'disable_smartreflex'
arch/arm/mach-omap2/pm34xx.c:431: error: 'SR1' undeclared (first use in this function)
arch/arm/mach-omap2/pm34xx.c:431: error: (Each undeclared identifier is reported only once
arch/arm/mach-omap2/pm34xx.c:431: error: for each function it appears in.)
arch/arm/mach-omap2/pm34xx.c:433: error: 'SR2' undeclared (first use in this function)
arch/arm/mach-omap2/pm34xx.c:508: error: implicit declaration of function 'usb_musb_disable_autoidle'
arch/arm/mach-omap2/pm34xx.c:532: error: implicit declaration of function 'enable_smartreflex'
arch/arm/mach-omap2/pm34xx.c:546: error: implicit declaration of function 'omap3_gpio_restore_pad_context'
arch/arm/mach-omap2/pm34xx.c:551: error: implicit declaration of function 'omap2_gpio_resume_after_idle'
arch/arm/mach-omap2/pm34xx.c: In function 'omap3_pm_init_vc':
arch/arm/mach-omap2/pm34xx.c:1083: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1083: error: dereferencing pointer to incomplete type
arch/arm/mach-omap2/pm34xx.c:1084: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1084: error: dereferencing pointer to incomplete type
arch/arm/mach-omap2/pm34xx.c:1085: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1085: error: dereferencing pointer to incomplete type
arch/arm/mach-omap2/pm34xx.c:1086: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1086: error: dereferencing pointer to incomplete type
arch/arm/mach-omap2/pm34xx.c:1087: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1087: error: dereferencing pointer to incomplete type
arch/arm/mach-omap2/pm34xx.c:1088: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1088: error: dereferencing pointer to incomplete type
arch/arm/mach-omap2/pm34xx.c:1089: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1089: error: dereferencing pointer to incomplete type
arch/arm/mach-omap2/pm34xx.c:1090: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1090: error: dereferencing pointer to incomplete type
arch/arm/mach-omap2/pm34xx.c:1091: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1091: error: dereferencing pointer to incomplete type
arch/arm/mach-omap2/pm34xx.c:1092: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1092: error: dereferencing pointer to incomplete type
arch/arm/mach-omap2/pm34xx.c:1093: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1093: error: dereferencing pointer to incomplete type
arch/arm/mach-omap2/pm34xx.c:1094: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1094: error: dereferencing pointer to incomplete type
arch/arm/mach-omap2/pm34xx.c:1095: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1095: error: dereferencing pointer to incomplete type
arch/arm/mach-omap2/pm34xx.c: In function 'configure_vc':
arch/arm/mach-omap2/pm34xx.c:1246: error: 'R_SRI2C_SLAVE_ADDR' undeclared (first use in this function)
arch/arm/mach-omap2/pm34xx.c:1246: error: 'OMAP3430_SMPS_SA1_SHIFT' undeclared (first use in this function)
arch/arm/mach-omap2/pm34xx.c:1247: error: 'OMAP3430_SMPS_SA0_SHIFT' undeclared (first use in this function)
arch/arm/mach-omap2/pm34xx.c:1249: error: 'R_VDD2_SR_CONTROL' undeclared (first use in this function)
arch/arm/mach-omap2/pm34xx.c:1250: error: 'R_VDD1_SR_CONTROL' undeclared (first use in this function)
arch/arm/mach-omap2/pm34xx.c:1253: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1254: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1255: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1256: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1259: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1260: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1261: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1262: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1273: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1275: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1277: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1281: error: invalid use of undefined type 'struct prm_setup_vc'
arch/arm/mach-omap2/pm34xx.c:1283: error: invalid use of undefined type 'struct prm_setup_vc'
make[1]: *** [arch/arm/mach-omap2/pm34xx.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2