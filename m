From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: New randconfig build failures in OMAP
Date: Tue, 5 Jun 2012 23:02:14 +0100
Message-ID: <20120605220214.GA29782@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53142 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207Ab2FEWCS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jun 2012 18:02:18 -0400
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:47976)
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1Sc1oZ-0006KK-Rm
	for linux-omap@vger.kernel.org; Tue, 05 Jun 2012 23:01:24 +0100
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1Sc1pO-00034S-SZ
	for linux-omap@vger.kernel.org; Tue, 05 Jun 2012 23:02:14 +0100
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

I pulled Linus' tree at 7am UTC, and reran the builds after updating
the build tree with that (plus my pending devel stuff).  The resulting
randconfig spat out this:

arch/arm/mach-omap2/dsp.c: In function 'omap_dsp_reserve_sdram_memblock':
arch/arm/mach-omap2/dsp.c:58: error: implicit declaration of function 'arm_memblock_steal'

Looks to me like a missing include?

arch/arm/mach-omap2/board-rx51-peripherals.c:147: error: implicit declaration of function 'OMAP_GPIO_IRQ'
arch/arm/mach-omap2/board-rx51-peripherals.c:147: error: initializer element is not constant
arch/arm/mach-omap2/board-rx51-peripherals.c:147: error: (near initialization for 'rx51_lis3lv02d_data.irq2')
arch/arm/mach-omap2/board-rx51-peripherals.c:1033: error: initializer element is not constant
arch/arm/mach-omap2/board-rx51-peripherals.c:1033: error: (near initialization for 'rx51_peripherals_i2c_board_info_3[0].irq')

Again, a missing include?
