From: Abraham Arce <x0066660@ti.com>
Subject: Compilation: omap-for-linus omap2plus error
Date: Wed, 29 Sep 2010 22:54:11 -0500
Message-ID: <4CA409E3.8000800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50117 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122Ab0I3DyM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 23:54:12 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8U3sCcb027549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 29 Sep 2010 22:54:12 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id o8U3sBX8004037
	for <linux-omap@vger.kernel.org>; Wed, 29 Sep 2010 22:54:11 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o8U3sBep005327
	for <linux-omap@vger.kernel.org>; Wed, 29 Sep 2010 22:54:11 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi,

Is there any patch missing in omap-for-linus branch?

   CC      arch/arm/mach-omap2/pm_bus.o
arch/arm/mach-omap2/pm_bus.c: In function 'omap_pm_runtime_init':
arch/arm/mach-omap2/pm_bus.c:64: error: implicit declaration of function 
'platform_bus_get_pm_ops'
arch/arm/mach-omap2/pm_bus.c:64: warning: assignment makes pointer from 
integer without a cast
arch/arm/mach-omap2/pm_bus.c:81: error: implicit declaration of function 
'platform_bus_set_pm_ops'
make[1]: *** [arch/arm/mach-omap2/pm_bus.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

Best Regards
Abraham
