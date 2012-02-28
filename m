From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: More randconfig OMAP build errors
Date: Tue, 28 Feb 2012 10:22:29 +0000
Message-ID: <20120228102229.GE18045@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56864 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964872Ab2B1KWe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 05:22:34 -0500
Received: from n2100.arm.linux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:39502)
	by caramon.arm.linux.org.uk with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <linux@arm.linux.org.uk>)
	id 1S2KCV-0000zq-CB
	for linux-omap@vger.kernel.org; Tue, 28 Feb 2012 10:22:31 +0000
Received: from linux by n2100.arm.linux.org.uk with local (Exim 4.76)
	(envelope-from <linux@n2100.arm.linux.org.uk>)
	id 1S2KCU-0008KQ-4c
	for linux-omap@vger.kernel.org; Tue, 28 Feb 2012 10:22:30 +0000
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Todays randconfig found this:

drivers/video/omap2/displays/panel-dvi.c: In function 'panel_dvi_ddc_read':
drivers/video/omap2/displays/panel-dvi.c:239: error: implicit declaration of function 'i2c_transfer'
drivers/video/omap2/displays/panel-dvi.c: In function 'panel_dvi_read_edid':
drivers/video/omap2/displays/panel-dvi.c:265: error: implicit declaration of function 'i2c_get_adapter'

caused by I2C being disabled.

There's also some warnings in arch/arm/mach-omap2/omap_l3_smx.c and
drivers/video/omap2/dss/apply.c about unused variables:

arch/arm/mach-omap2/omap_l3_smx.c: In function 'omap3_l3_block_irq':
arch/arm/mach-omap2/omap_l3_smx.c:156: warning: unused variable 'address'
arch/arm/mach-omap2/omap_l3_smx.c:155: warning: unused variable 'multi'
arch/arm/mach-omap2/omap_l3_smx.c:154: warning: unused variable 'initid'
arch/arm/mach-omap2/omap_l3_smx.c:153: warning: unused variable 'code'
arch/arm/mach-omap2/omap_l3_smx.c: At top level:
arch/arm/mach-omap2/omap_l3_smx.c:68: warning: 'omap3_l3_code_string' defined but not used
arch/arm/mach-omap2/omap_l3_smx.c:90: warning: 'omap3_l3_initiator_string' defined but not used
drivers/video/omap2/dss/apply.c:350: warning: 'wait_pending_extra_info_updates' defined but not used
