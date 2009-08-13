From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: 3430SDP: Build break in pm-2.6.29 branch
Date: Thu, 13 Aug 2009 11:10:22 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0306050762@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43446 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbZHMFkl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Aug 2009 01:40:41 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7D5eaCO018691
	for <linux-omap@vger.kernel.org>; Thu, 13 Aug 2009 00:40:42 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n7D5eZEg015372
	for <linux-omap@vger.kernel.org>; Thu, 13 Aug 2009 11:10:35 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

With the omap_3430sdp_pm_defconfig, I get the following build break

  CC      arch/arm/mach-omap2/pm34xx.o
arch/arm/mach-omap2/pm34xx.c: In function 'prcm_interrupt_handler':
arch/arm/mach-omap2/pm34xx.c:286: error: 'OMAP3_PRM_IRQSTATUS_MPU_OFFSET' undeclared (first use in this function)
arch/arm/mach-omap2/pm34xx.c:286: error: (Each undeclared identifier is reported only once
arch/arm/mach-omap2/pm34xx.c:286: error: for each function it appears in.)
make[1]: *** [arch/arm/mach-omap2/pm34xx.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

- Anand
