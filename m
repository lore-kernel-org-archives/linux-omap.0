From: "Premi, Sanjeev" <premi@ti.com>
Subject: Failures with rc9
Date: Fri, 10 Oct 2008 15:31:48 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301B020C2CF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57082 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYJJKB7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 06:01:59 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9AA1qP8028573
	for <linux-omap@vger.kernel.org>; Fri, 10 Oct 2008 05:01:58 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id m9AA1obH023958
	for <linux-omap@vger.kernel.org>; Fri, 10 Oct 2008 15:31:51 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

Hi all,

Noticed build failures with v2.6.27-rc9-5073-g5b99e69, when building for omap3_evm.

arch/arm/mach-omap2/built-in.o: In function `hsmmc_card_detect':
/home/self/linux-omap/arch/arm/mach-omap2/hsmmc.c:50: undefined reference to `twl4030_get_gpio_datain'
arch/arm/mach-omap2/built-in.o: In function `hsmmc_cleanup':
/home/self/linux-omap/arch/arm/mach-omap2/hsmmc.c:82: undefined reference to `twl4030_free_gpio'
arch/arm/mach-omap2/built-in.o: In function `hsmmc_late_init':
/home/self/linux-omap/arch/arm/mach-omap2/hsmmc.c:63: undefined reference to `twl4030_request_gpio'
/home/self/linux-omap/arch/arm/mach-omap2/hsmmc.c:67: undefined reference to `twl4030_set_gpio_debounce'
make: *** [.tmp_vmlinux1] Error 1

Best regards,
Sanjeev
