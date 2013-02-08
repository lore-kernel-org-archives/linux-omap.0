From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Build error: OMAP randconfig / mvebu
Date: Fri, 8 Feb 2013 10:08:13 +0000
Message-ID: <20130208100813.GN17833@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:38006 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760052Ab3BHKNX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 05:13:23 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, arm@kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>

Last night's OMAP4430SDP randconfig build failed with:

arch/arm/mach-mvebu/built-in.o: In function `armada_xp_smp_init_cpus':
hotplug.c:(.init.text+0x70): undefined reference to `coherency_get_cpu_count'
hotplug.c:(.init.text+0xb4): undefined reference to `armada_mpic_send_doorbell'
arch/arm/mach-mvebu/built-in.o: In function `armada_xp_smp_prepare_cpus':
hotplug.c:(.init.text+0x254): undefined reference to `set_cpu_coherent'
arch/arm/mach-mvebu/built-in.o: In function `armada_xp_boot_secondary':
hotplug.c:(.cpuinit.text+0x10): undefined reference to `armada_xp_boot_cpu'
arch/arm/mach-mvebu/built-in.o: In function `armada_xp_secondary_init':
hotplug.c:(.cpuinit.text+0x2c): undefined reference to `armada_xp_mpic_smp_cpu_init'
arch/arm/mach-mvebu/built-in.o: In function `armada_xp_secondary_startup':
hotplug.c:(.cpuinit.text+0x40): undefined reference to `ll_set_cpu_coherent'

This seems to be because we ended up with CONFIG_ARCH_MVEBU=y but without
CONFIG_MACH_ARMADA_370_XP being set - and because of OMAP, we have SMP
and hotplug CPU enabled.

Usual configs/logs available via the website.

