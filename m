From: Venu Byravarasu <vbyravarasu@nvidia.com>
Subject: RE: [balbi-usb:master 18/19] drivers/usb/musb/musb_core.c:357:21:
 error: 'struct usb_phy' has no member named 'state'
Date: Thu, 6 Sep 2012 10:10:53 +0530
Message-ID: <D958900912E20642BCBC71664EFECE3E6DDE7753BE@BGMAIL02.nvidia.com>
References: <20120906021054.GA15892@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:17086 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab2IFEk6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 00:40:58 -0400
In-Reply-To: <20120906021054.GA15892@localhost>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

Sorry for the inconvenience caused.
Will push a patch to fix this ASAP.

Thanks,
Venu


> -----Original Message-----
> From: Fengguang Wu [mailto:fengguang.wu@intel.com]
> Sent: Thursday, September 06, 2012 7:41 AM
> To: Venu Byravarasu
> Cc: kernel-janitors@vger.kernel.org; Felipe Balbi; linux-
> omap@vger.kernel.org; linux-usb@vger.kernel.org
> Subject: [balbi-usb:master 18/19] drivers/usb/musb/musb_core.c:357:21:
> error: 'struct usb_phy' has no member named 'state'
> 
> Hi Venu,
> 
> FYI, kernel build failed on
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git master
> head:   8de3474a41642da9dfb38208844007a48f87abce
> commit: de4217d90fed1b1714a270ceb5d092f7314e8bda [18/19] usb: otg:
> Move phy interface to separate file.
> config: x86_64-allmodconfig (attached as .config)
> 
> All related error/warning messages:
> 
> drivers/usb/musb/musb_core.c: In function 'musb_otg_timer_func':
> drivers/usb/musb/musb_core.c:357:21: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_core.c:361:14: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_core.c:366:3: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/musb_core.c:369:14: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_core.c:372:3: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/musb_core.c: In function 'musb_hnp_stop':
> drivers/usb/musb/musb_core.c:388:2: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/musb_core.c:390:21: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_core.c:393:3: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/musb_core.c:399:14: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_core.c:407:3: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/musb_core.c: In function 'musb_stage0_irq':
> drivers/usb/musb/musb_core.c:446:3: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/musb_core.c:451:23: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_core.c:474:16: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_core.c:479:16: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_core.c:484:5: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/musb_core.c:489:23: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_core.c:492:16: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_core.c:513:5: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/musb_core.c:530:3: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/musb_core.c:542:14: error: 'struct usb_phy' has no
> member named 'state'
> --
> drivers/usb/musb/musb_gadget.c: In function 'musb_gadget_wakeup':
> drivers/usb/musb/musb_gadget.c:1630:21: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_gadget.c:1670:3: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_gadget.c: In function 'musb_gadget_start':
> drivers/usb/musb/musb_gadget.c:1952:13: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_gadget.c: In function 'musb_gadget_stop':
> drivers/usb/musb/musb_gadget.c:2063:13: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_gadget.c: In function 'musb_g_resume':
> drivers/usb/musb/musb_gadget.c:2096:21: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_gadget.c:2109:3: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_gadget.c: In function 'musb_g_suspend':
> drivers/usb/musb/musb_gadget.c:2122:21: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_gadget.c:2125:15: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_gadget.c:2139:3: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_gadget.c: In function 'musb_g_disconnect':
> drivers/usb/musb/musb_gadget.c:2171:21: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_gadget.c:2173:3: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_gadget.c:2175:14: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_gadget.c:2179:14: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_gadget.c:2186:14: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_gadget.c: In function 'musb_g_reset':
> drivers/usb/musb/musb_gadget.c:2242:14: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_gadget.c:2245:14: error: 'struct usb_phy' has no
> member named 'state'
> --
> drivers/usb/musb/musb_virthub.c: In function 'musb_port_suspend':
> drivers/usb/musb/musb_virthub.c:81:22: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_virthub.c:83:15: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_virthub.c:93:15: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_virthub.c:99:4: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_virthub.c: In function 'musb_port_reset':
> drivers/usb/musb/musb_virthub.c:120:17: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_virthub.c: In function 'musb_root_disconnect':
> drivers/usb/musb/musb_virthub.c:191:21: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_virthub.c:195:15: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_virthub.c:201:14: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_virthub.c:205:14: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_virthub.c:208:3: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_virthub.c: In function 'musb_hub_control':
> drivers/usb/musb/musb_virthub.c:345:15: error: 'struct usb_phy' has no
> member named 'state'
> --
> drivers/usb/musb/musb_host.c: In function 'musb_bus_suspend':
> drivers/usb/musb/musb_host.c:2290:21: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_host.c:2300:15: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/musb/musb_host.c:2307:3: error: 'struct usb_phy' has no
> member named 'state'
> --
> drivers/usb/musb/tusb6010.c: In function 'musb_do_idle':
> drivers/usb/musb/tusb6010.c:419:21: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c:424:4: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c: In function 'tusb_musb_try_idle':
> drivers/usb/musb/tusb6010.c:479:19: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c:480:3: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c:497:2: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c: In function 'tusb_musb_set_vbus':
> drivers/usb/musb/tusb6010.c:529:14: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c:542:23: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c:545:16: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c:548:16: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c:551:16: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c:559:15: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c:573:2: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c: In function 'tusb_otg_ints':
> drivers/usb/musb/tusb6010.c:686:20: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c:688:17: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c:693:4: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c:699:4: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c:702:23: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c:748:3: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c:751:22: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/musb/tusb6010.c:763:16: error: 'struct usb_phy' has no member
> named 'state'
> --
> drivers/usb/otg/gpio_vbus.c: In function 'gpio_vbus_work':
> drivers/usb/otg/gpio_vbus.c:119:17: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/otg/gpio_vbus.c:141:17: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/otg/gpio_vbus.c: In function 'gpio_vbus_set_peripheral':
> drivers/usb/otg/gpio_vbus.c:194:11: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/otg/gpio_vbus.c: In function 'gpio_vbus_set_power':
> drivers/usb/otg/gpio_vbus.c:216:9: error: 'struct usb_phy' has no member
> named 'state'
> drivers/usb/otg/gpio_vbus.c: In function 'gpio_vbus_probe':
> drivers/usb/otg/gpio_vbus.c:266:16: error: 'struct usb_phy' has no member
> named 'state'
> --
> drivers/usb/otg/nop-usb-xceiv.c: In function 'nop_set_peripheral':
> drivers/usb/otg/nop-usb-xceiv.c:78:10: error: 'struct usb_phy' has no
> member named 'state'
> drivers/usb/otg/nop-usb-xceiv.c: In function 'nop_usb_xceiv_probe':
> drivers/usb/otg/nop-usb-xceiv.c:120:10: error: 'struct usb_phy' has no
> member named 'state'
> 
> ---
> 0-DAY kernel build testing backend         Open Source Technology Centre
> Fengguang Wu <wfg@linux.intel.com>                     Intel Corporation
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
