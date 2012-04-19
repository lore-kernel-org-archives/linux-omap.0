From: Paul Walmsley <paul@pwsan.com>
Subject: AM3517 boot failure
Date: Wed, 18 Apr 2012 20:07:01 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204182005260.29048@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51775 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab2DSCHD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Apr 2012 22:07:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Hi,

just wanted to mention this on the list to see if anyone else was seeing 
it.  I'm using a Compulab CM-T3517 and attempting to use nfsroot, and the 
boot hangs.  Here are the last few lines when booting with 
initcall_debug:

[    7.069885] initcall scsi_complete_async_scans+0x0/0x10c returned 0 after 29 usecs
[    7.077880] calling  gpio_keys_init+0x0/0xc @ 1
[    7.084167] initcall gpio_keys_init+0x0/0xc returned 0 after 1400 usecs
[    7.091278] calling  rtc_hctosys+0x0/0x110 @ 1
[    7.096038] /home/paul/linux/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
[    7.104217] initcall rtc_hctosys+0x0/0x110 returned -19 after 7987 usecs
[    7.111297] calling  net_secret_init+0x0/0x1c @ 1
[    7.116333] initcall net_secret_init+0x0/0x1c returned 0 after 119 usecs
[    7.123443] calling  tcp_congestion_default+0x0/0xc @ 1
[    7.128997] initcall tcp_congestion_default+0x0/0xc returned 0 after 0 usecs
[    7.136444] calling  ip_auto_config+0x0/0xf70 @ 1

Is anyone else seeing this?


- Paul
