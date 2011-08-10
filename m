From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: tidspbridge issue with omap_dm_timer_free
Date: Wed, 10 Aug 2011 21:42:10 +0300
Message-ID: <CAMP44s17O-g83Fte05=AmqBP24jqgLxiBHmO6+3fbtJjWV8Ufw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59702 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab1HJSmL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Aug 2011 14:42:11 -0400
Received: by bke11 with SMTP id 11so474038bke.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Aug 2011 11:42:10 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>

Hi,

I am trying to use a more recent version of the tidspbridge code in
the Nokia N9, but I'm stuck with this warning that is caused by using
the dm timer framework.

[   30.883636] BUG: sleeping function called from invalid context at
kernel/mutex.c:287
[   30.885925] in_atomic(): 1, irqs_disabled(): 0, pid: 305, name: mboxd/0
[   30.892517] 3 locks held by mboxd/0/305:
[   30.896392]  #0:  (mboxd){+.+...}, at: [<b0081778>] worker_thread+0x154/0x2bc
[   30.903533]  #1:  (&mq->work){+.+...}, at: [<b0081778>]
worker_thread+0x154/0x2bc
[   30.911041]  #2:  (pwr_lock){+.....}, at: [<af12f870>]
handle_hibernation_from_dsp+0x1c/0x158 [bridgedriver]
[   30.920959] [<b003f75c>] (unwind_backtrace+0x0/0xd4) from
[<b03a3ac4>] (mutex_lock_nested+0x30/0x32c)
[   30.930175] [<b03a3ac4>] (mutex_lock_nested+0x30/0x32c) from
[<b00568f8>] (clk_set_parent+0x34/0xf8)
[   30.939361] [<b00568f8>] (clk_set_parent+0x34/0xf8) from
[<b005e2e0>] (omap_dm_timer_set_source+0x34/0x58)
[   30.949035] [<b005e2e0>] (omap_dm_timer_set_source+0x34/0x58) from
[<b005e424>] (omap_dm_timer_reset+0x78/0xd0)
[   30.959136] [<b005e424>] (omap_dm_timer_reset+0x78/0xd0) from
[<b005e490>] (omap_dm_timer_free+0x14/0x48)
[   30.968780] [<b005e490>] (omap_dm_timer_free+0x14/0x48) from
[<af1309d4>] (dsp_clk_disable+0x98/0x15c [bridgedriver])
[   30.979492] [<af1309d4>] (dsp_clk_disable+0x98/0x15c
[bridgedriver]) from [<af130abc>] (dsp_clock_disable_all+0x24/0x34
[bridgedriver])
[   30.991668] [<af130abc>] (dsp_clock_disable_all+0x24/0x34
[bridgedriver]) from [<af12f914>]
(handle_hibernation_from_dsp+0xc0/0x158 [bridgedriver])
[   31.004913] [<af12f914>] (handle_hibernation_from_dsp+0xc0/0x158
[bridgedriver]) from [<af12c2bc>] (io_mbox_msg+0x8c/0x100
[bridgedriver])
[   31.017364] [<af12c2bc>] (io_mbox_msg+0x8c/0x100 [bridgedriver])
from [<af07043c>] (mbox_rx_work+0x3c/0xa0 [mailbox])
[   31.027954] [<af07043c>] (mbox_rx_work+0x3c/0xa0 [mailbox]) from
[<b00817e4>] (worker_thread+0x1c0/0x2bc)
[   31.037536] [<b00817e4>] (worker_thread+0x1c0/0x2bc) from
[<b008513c>] (kthread+0x7c/0x84)
[   31.045806] [<b008513c>] (kthread+0x7c/0x84) from [<b003b9d4>]
(kernel_thread_exit+0x0/0x8)
[   31.054290] ------------[ cut here ]------------
[   31.058837] WARNING: at kernel/mutex.c:214 mutex_lock_nested+0xb0/0x32c()
[   31.065643] Modules linked in: ramzswap dm_crypt omaplfb
bridgedriver(C) dm_mod omap_aes mtdswap g_file_storage cmt_speech
ssi_protocol hsi_char phonet pvrsrvkm omap_ssi mailbox_mach mailbox
lis3lv02d_i2c radio_wl1273 ak8974 lis3lv02d bcm4751_gps leds_lp5523
bhsfh rtc_twl4030 twl5031_aci twl4030_keypad twl4030_pwrbutton
hid_twl4030_vibra hci_h4p cmt
[   31.096649] [<b003f75c>] (unwind_backtrace+0x0/0xd4) from
[<b00709d4>] (warn_slowpath_common+0x48/0x60)
[   31.106079] [<b00709d4>] (warn_slowpath_common+0x48/0x60) from
[<b03a3b44>] (mutex_lock_nested+0xb0/0x32c)
[   31.115753] [<b03a3b44>] (mutex_lock_nested+0xb0/0x32c) from
[<b00568f8>] (clk_set_parent+0x34/0xf8)
[   31.124908] [<b00568f8>] (clk_set_parent+0x34/0xf8) from
[<b005e2e0>] (omap_dm_timer_set_source+0x34/0x58)
[   31.134613] [<b005e2e0>] (omap_dm_timer_set_source+0x34/0x58) from
[<b005e424>] (omap_dm_timer_reset+0x78/0xd0)
[   31.144714] [<b005e424>] (omap_dm_timer_reset+0x78/0xd0) from
[<b005e490>] (omap_dm_timer_free+0x14/0x48)
[   31.154357] [<b005e490>] (omap_dm_timer_free+0x14/0x48) from
[<af1309d4>] (dsp_clk_disable+0x98/0x15c [bridgedriver])
[   31.165039] [<af1309d4>] (dsp_clk_disable+0x98/0x15c
[bridgedriver]) from [<af130abc>] (dsp_clock_disable_all+0x24/0x34
[bridgedriver])
[   31.177215] [<af130abc>] (dsp_clock_disable_all+0x24/0x34
[bridgedriver]) from [<af12f914>]
(handle_hibernation_from_dsp+0xc0/0x158 [bridgedriver])
[   31.190490] [<af12f914>] (handle_hibernation_from_dsp+0xc0/0x158
[bridgedriver]) from [<af12c2bc>] (io_mbox_msg+0x8c/0x100
[bridgedriver])
[   31.202911] [<af12c2bc>] (io_mbox_msg+0x8c/0x100 [bridgedriver])
from [<af07043c>] (mbox_rx_work+0x3c/0xa0 [mailbox])
[   31.213531] [<af07043c>] (mbox_rx_work+0x3c/0xa0 [mailbox]) from
[<b00817e4>] (worker_thread+0x1c0/0x2bc)
[   31.223114] [<b00817e4>] (worker_thread+0x1c0/0x2bc) from
[<b008513c>] (kthread+0x7c/0x84)
[   31.231414] [<b008513c>] (kthread+0x7c/0x84) from [<b003b9d4>]
(kernel_thread_exit+0x0/0x8)
[   31.239746] ---[ end trace e14f2f8770932c43 ]---

>From what I can see this could be triggered in upstream by enabling PM
and debug mutex stuff right after loading the baseimage.

Any ideas?

-- 
Felipe Contreras
