From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: OMAP* Latest build failures
Date: Wed, 14 Nov 2012 09:26:43 +0000
Message-ID: <20121114092643.GG3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42000 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217Ab2KNJ0u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 04:26:50 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

OMAP* allnoconfig fails:

arch/arm/mach-omap2/built-in.o: In function `omap_dss_set_min_bus_tput':
twl-common.c:(.text+0x1e08): undefined reference to `omap_pm_set_min_bus_tput'
arch/arm/mach-omap2/built-in.o: In function `omap_hwmod_init_postsetup':
twl-common.c:(.init.text+0x8f8): undefined reference to `omap_pm_if_early_init'
arch/arm/mach-omap2/built-in.o: In function `omap_serial_init_port':
twl-common.c:(.init.text+0x1284): undefined reference to `omap_pm_get_dev_context_loss_count'
arch/arm/mach-omap2/built-in.o: In function `omap_timer_init':
twl-common.c:(.init.text+0x1544): undefined reference to `omap_pm_get_dev_context_loss_count'
arch/arm/mach-omap2/built-in.o: In function `omap2_common_pm_init':
twl-common.c:(.init.text+0x1af0): undefined reference to `omap_pm_if_init'
arch/arm/mach-omap2/built-in.o: In function `omap2_gpio_dev_init':
twl-common.c:(.init.text+0x2168): undefined reference to `omap_pm_get_dev_context_loss_count'
arch/arm/mach-omap2/built-in.o: In function `omap_display_init':
twl-common.c:(.init.text+0x25cc): undefined reference to `omap_pm_get_dev_context_loss_count'

OMAP4 randconfig fails:

arch/arm/mach-omap2/cm_common.c: In function 'cm_register':
arch/arm/mach-omap2/cm_common.c:42:11: error: 'EINVAL' undeclared (first use in this function)
arch/arm/mach-omap2/cm_common.c:45:11: error: 'EEXIST' undeclared (first use in this function)
arch/arm/mach-omap2/cm_common.c: In function 'cm_unregister':
arch/arm/mach-omap2/cm_common.c:66:11: error: 'EINVAL' undeclared (first use in this function)

You know where to find the build information and results...
