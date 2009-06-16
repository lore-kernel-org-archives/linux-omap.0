From: "Premi, Sanjeev" <premi@ti.com>
Subject: Build failure for OMAP3EVM
Date: Tue, 16 Jun 2009 17:04:52 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301D810C1ED@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43166 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526AbZFPLeb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 07:34:31 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5GBYSjD013145
	for <linux-omap@vger.kernel.org>; Tue, 16 Jun 2009 06:34:33 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n5GBYRuu013032
	for <linux-omap@vger.kernel.org>; Tue, 16 Jun 2009 17:04:27 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tony,

While trying to build kernel at current head (532bdcb); I came across this error.

  CC      arch/arm/mach-omap2/board-omap3evm.o
arch/arm/mach-omap2/board-omap3evm.c: In function 'omap3_evm_init':
arch/arm/mach-omap2/board-omap3evm.c:313: error: implicit declaration of function 'omap3evm_flash_init'
make[1]: *** [arch/arm/mach-omap2/board-omap3evm.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

It appears that omap3evm_flash_init() from board-omap3evm-flash.c did not find its way into the board-omap3evm.c as it did for overo and beagle.

Would you be able to bring it in? OR do you prefer a separate patch for same?

Best regards,
Sanjeev
