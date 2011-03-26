From: Ben Gamari <bgamari@gmail.com>
Subject: Initialization of musb on board-omap2beagle fails in platform_driver_probe
Date: Sat, 26 Mar 2011 19:42:34 -0400
Message-ID: <87hbap5tzp.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58003 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab1CZXmh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Mar 2011 19:42:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, Beagle Board <beagleboard@googlegroups.com>, linux-omap <linux-omap@vger.kernel.org>

Today I've had a very frustrating time trying to bring up a BeagleBoard
(arch/arm/mach-omap2/board-omap2beagle.c) with the 2.6.38
kernel. Unfortunately musb has been giving me great difficulties,

 # modprobe g_ether
[   25.276855] usb_gadget_probe_driver 1815: usb_gadget_probe_driver, no dev??
modprobe: Failed to load module g_ether: No such device.

After a great deal of printking, I've determined that the error is
coming from platform_driver_probe (platform.c:499). The code in question
appears to be a check ensuring that any devices being probe were first
registered. When the musb-hdrc module is probed, this check seems to
fail with code = 1 and list_empty(&drv->driver.p->klist_devices.k_list)
= 1.

What exactly is this check supposed to accomplish? Why would it fail
during musb initialization? The relevant call path is,

  kernel_init -> do_one_initcall -> musb_init -> platform_driver_probe
  
Both musb_init and platform_driver_probe return with -19. As far as I
can tell, the board's init_machine successfully calls usb_musb_init
from omap3_beagle_init, so the device should be registered well before
arriving in musb_init.

Any ideas would be greatly appreciated. Cheers,

 - Ben


