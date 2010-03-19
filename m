From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: mainline kernel - GPIO warning at bootup
Date: Fri, 19 Mar 2010 12:21:23 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03220FB89C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49439 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab0CSGvZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 02:51:25 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2J6pLJN014011
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 19 Mar 2010 01:51:24 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2J6pKeL017911
	for <linux-omap@vger.kernel.org>; Fri, 19 Mar 2010 12:21:21 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi all,

I get the following warning at bootup. This is on mainline kernel
(omap3_defconfig) on a 3430 SDP.

I thought we'd seen this earlier, not sure if there is a fix.

I can provide the full booup log if needed. Any pointers would also
be okay - I can look at a fix if no one else already has.

Regards,
Anand


[   72.990051] ------------[ cut here ]------------
[   72.994720] WARNING: at drivers/gpio/gpiolib.c:1238 gpio_free+0x114/0x13c()
[   73.001739] Modules linked in:
[   73.004852] [<c0044320>] (unwind_backtrace+0x0/0xec) from [<c00725d0>] (warn_slowpath_common+0x48/0x60)
[   73.014343] [<c00725d0>] (warn_slowpath_common+0x48/0x60) from [<c01fd33c>] (gpio_free+0x114/0x13c)
[   73.023468] [<c01fd33c>] (gpio_free+0x114/0x13c) from [<c0420914>] (ads7846_probe+0x87c/0xae0)
[   73.032135] [<c0420914>] (ads7846_probe+0x87c/0xae0) from [<c0278838>] (spi_drv_probe+0x18/0x1c)
[   73.041015] [<c0278838>] (spi_drv_probe+0x18/0x1c) from [<c023a4dc>] (driver_probe_device+0xc0/0x178)
[   73.050292] [<c023a4dc>] (driver_probe_device+0xc0/0x178) from [<c023a5f4>] (__driver_attach+0x60/0x84)
[   73.059753] [<c023a5f4>] (__driver_attach+0x60/0x84) from [<c0239d48>] (bus_for_each_dev+0x44/0x74)
[   73.068878] [<c0239d48>] (bus_for_each_dev+0x44/0x74) from [<c02396b0>] (bus_add_driver+0x9c/0x21c)
[   73.078002] [<c02396b0>] (bus_add_driver+0x9c/0x21c) from [<c023a8ec>] (driver_register+0xa8/0x130)
[   73.087097] [<c023a8ec>] (driver_register+0xa8/0x130) from [<c003e34c>] (do_one_initcall+0x5c/0x1b8)
[   73.096313] [<c003e34c>] (do_one_initcall+0x5c/0x1b8) from [<c0008578>] (kernel_init+0x90/0x144)
[   73.105163] [<c0008578>] (kernel_init+0x90/0x144) from [<c003f970>] (kernel_thread_exit+0x0/0x8)
[   73.114013] ---[ end trace 1b75b31a2719ed1d ]---
