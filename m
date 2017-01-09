From: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/2] dmaengine: cppi41: PM runtime fixes
Date: Mon,  9 Jan 2017 18:03:35 +0100
Message-ID: <20170109170337.6957-1-abailon@baylibre.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

I have tried to play music on usb headset on BeagleBone Black
but it doesn't work.
This series intend to fix it.

[   12.476441] usb 1-1: new full-speed USB device number 2 using musb-hdrc
[   12.896297] usb 1-1: New USB device found, idVendor=047f, idProduct=c035
[   12.903413] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   12.911144] usb 1-1: Product: Plantronics C520
[   12.915848] usb 1-1: Manufacturer: Plantronics
[   12.920639] usb 1-1: SerialNumber: D6E3CB79C4662A4BA9D79F167CF83EC1
[   13.938461] usbcore: registered new interface driver usbhid
[   13.944322] usbhid: USB HID core driver
[   14.020990] usb 1-1: Warning! Unlikely big volume range (=8192), cval->res is probably wrong.
[   14.030018] usb 1-1: [11] FU [Sidetone Playback Volume] ch = 1, val = 0/8192/1
[   14.061893] usbcore: registered new interface driver snd-usb-audio
[   18.466596] cppi41-dma-engine 47400000.dma-controller: cppi41_irq pm runtime get: -115
[   18.576263] ------------[ cut here ]------------
[   18.581247] WARNING: CPU: 0 PID: 14 at drivers/dma/cppi41.c:1154 cppi41_runtime_suspend+0x28/0x34 [cppi41]
[   18.591577] Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi usbhid snd_hwdep evdev musb_dsps musb_hdrc usbcore phy_am335x cppi41 udc_core usb_common phy_generic phy_am335x_control snd_soc_simple_card snd_soc_simple_card_utils snd_soc_davinci_mcasp snd_soc_omap snd_soc_edma snd_soc_core omap_rng snd_pcm_dmaengine rng_core snd_pcm snd_timer snd soundcore at24 rtc_omap musb_am335x omap_wdt tps65218_pwrbutton cpufreq_dt nvmem_core leds_gpio thermal_sys led_class hwmon
[   18.636684] CPU: 0 PID: 14 Comm: kworker/0:1 Not tainted 4.10.0-rc2-next-20170103-00020-g0f64df3-dirty #202
[   18.646944] Hardware name: Generic AM33XX (Flattened Device Tree)
[   18.653401] Workqueue: pm pm_runtime_work
[   18.657694] [<c010f484>] (unwind_backtrace) from [<c010b5dc>] (show_stack+0x10/0x14)
[   18.665873] [<c010b5dc>] (show_stack) from [<c04933d4>] (dump_stack+0xa0/0xd8)
[   18.673519] [<c04933d4>] (dump_stack) from [<c013692c>] (__warn+0xd4/0xfc)
[   18.680789] [<c013692c>] (__warn) from [<c0136974>] (warn_slowpath_null+0x20/0x28)
[   18.688804] [<c0136974>] (warn_slowpath_null) from [<bf279134>] (cppi41_runtime_suspend+0x28/0x34 [cppi41])
[   18.699218] [<bf279134>] (cppi41_runtime_suspend [cppi41]) from [<c0554b9c>] (pm_generic_runtime_suspend+0x2c/0x40)
[   18.710225] [<c0554b9c>] (pm_generic_runtime_suspend) from [<c0558044>] (__rpm_callback+0x44/0x1ec)
[   18.719769] [<c0558044>] (__rpm_callback) from [<c0558214>] (rpm_callback+0x28/0x88)
[   18.727941] [<c0558214>] (rpm_callback) from [<c0556c20>] (rpm_suspend+0xf0/0x638)
[   18.735931] [<c0556c20>] (rpm_suspend) from [<c05587ec>] (pm_runtime_work+0x7c/0x98)
[   18.744119] [<c05587ec>] (pm_runtime_work) from [<c0153cd8>] (process_one_work+0x1e0/0x6d8)
[   18.752936] [<c0153cd8>] (process_one_work) from [<c015436c>] (worker_thread+0x164/0x48c)
[   18.761574] [<c015436c>] (worker_thread) from [<c015a5b4>] (kthread+0xf8/0x134)
[   18.769299] [<c015a5b4>] (kthread) from [<c0107890>] (ret_from_fork+0x14/0x24)
[   18.777153] ---[ end trace fc3a8cc6a95cb86f ]---
[   28.650884] ------------[ cut here ]------------
[   28.655867] WARNING: CPU: 0 PID: 14 at drivers/dma/cppi41.c:452 push_desc_queue+0x94/0x9c [cppi41]
[   28.665304] Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi usbhid snd_hwdep evdev musb_dsps musb_hdrc usbcore phy_am335x cppi41 udc_core usb_common phy_generic phy_am335x_control snd_soc_simple_card snd_soc_simple_card_utils snd_soc_davinci_mcasp snd_soc_omap snd_soc_edma snd_soc_core omap_rng snd_pcm_dmaengine rng_core snd_pcm snd_timer snd soundcore at24 rtc_omap musb_am335x omap_wdt tps65218_pwrbutton cpufreq_dt nvmem_core leds_gpio thermal_sys led_class hwmon
[   28.710225] CPU: 0 PID: 14 Comm: kworker/0:1 Tainted: G        W       4.10.0-rc2-next-20170103-00020-g0f64df3-dirty #202
[   28.721757] Hardware name: Generic AM33XX (Flattened Device Tree)
[   28.728213] Workqueue: pm pm_runtime_work
[   28.732507] [<c010f484>] (unwind_backtrace) from [<c010b5dc>] (show_stack+0x10/0x14)
[   28.740687] [<c010b5dc>] (show_stack) from [<c04933d4>] (dump_stack+0xa0/0xd8)
[   28.748333] [<c04933d4>] (dump_stack) from [<c013692c>] (__warn+0xd4/0xfc)
[   28.755603] [<c013692c>] (__warn) from [<c0136974>] (warn_slowpath_null+0x20/0x28)
[   28.763617] [<c0136974>] (warn_slowpath_null) from [<bf278250>] (push_desc_queue+0x94/0x9c [cppi41])
[   28.773440] [<bf278250>] (push_desc_queue [cppi41]) from [<bf27857c>] (cppi41_runtime_resume+0x44/0x88 [cppi41])
[   28.784197] [<bf27857c>] (cppi41_runtime_resume [cppi41]) from [<c0554bdc>] (pm_generic_runtime_resume+0x2c/0x40)
[   28.795024] [<c0554bdc>] (pm_generic_runtime_resume) from [<c0558044>] (__rpm_callback+0x44/0x1ec)
[   28.804476] [<c0558044>] (__rpm_callback) from [<c0558214>] (rpm_callback+0x28/0x88)
[   28.812650] [<c0558214>] (rpm_callback) from [<c0557a68>] (rpm_resume+0x3d4/0x6e8)
[   28.820641] [<c0557a68>] (rpm_resume) from [<c05587d8>] (pm_runtime_work+0x68/0x98)
[   28.828738] [<c05587d8>] (pm_runtime_work) from [<c0153cd8>] (process_one_work+0x1e0/0x6d8)
[   28.837558] [<c0153cd8>] (process_one_work) from [<c015436c>] (worker_thread+0x164/0x48c)
[   28.846196] [<c015436c>] (worker_thread) from [<c015a5b4>] (kthread+0xf8/0x134)
[   28.853924] [<c015a5b4>] (kthread) from [<c0107890>] (ret_from_fork+0x14/0x24)
[   28.861537] ---[ end trace fc3a8cc6a95cb870 ]---
[   28.866456] Unable to handle kernel NULL pointer dereference at virtual address 00000104
[   28.874979] pgd = c0004000
[   28.877841] [00000104] *pgd=00000000
[   28.881647] Internal error: Oops: 817 [#1] SMP ARM
[   28.886706] Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi usbhid snd_hwdep evdev musb_dsps musb_hdrc usbcore phy_am335x cppi41 udc_core usb_common phy_generic phy_am335x_control snd_soc_simple_card snd_soc_simple_card_utils snd_soc_davinci_mcasp snd_soc_omap snd_soc_edma snd_soc_core omap_rng snd_pcm_dmaengine rng_core snd_pcm snd_timer snd soundcore at24 rtc_omap musb_am335x omap_wdt tps65218_pwrbutton cpufreq_dt nvmem_core leds_gpio thermal_sys led_class hwmon
[   28.931576] CPU: 0 PID: 14 Comm: kworker/0:1 Tainted: G        W       4.10.0-rc2-next-20170103-00020-g0f64df3-dirty #202
[   28.943107] Hardware name: Generic AM33XX (Flattened Device Tree)
[   28.949543] Workqueue: pm pm_runtime_work
[   28.953791] task: de1321c0 task.stack: de176000
[   28.958593] PC is at cppi41_runtime_resume+0x50/0x88 [cppi41]
[   28.964661] LR is at warn_slowpath_null+0x20/0x28
[   28.969632] pc : [<bf278588>]    lr : [<c0136974>]    psr: 60070093
[   28.969632] sp : de177e50  ip : 00000000  fp : dd0cf510
[   28.981717] r10: de7d2b00  r9 : a0070013  r8 : 00000100
[   28.987229] r7 : 00000200  r6 : de7d2af8  r5 : 00000078  r4 : dd008540
[   28.994109] r3 : 00000078  r2 : 00000200  r1 : 00000100  r0 : 00000000
[   29.000994] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   29.008606] Control: 10c5387d  Table: 9d488019  DAC: 00000051
[   29.014665] Process kworker/0:1 (pid: 14, stack limit = 0xde176218)
[   29.021271] Stack: (0xde177e50 to 0xde178000)
[   29.025881] 7e40:                                     dd0cf410 de196810 dd0cf4b4 c0c04900
[   29.034513] 7e60: 00000002 c0554bb0 00000000 c0554bdc de1321c0 c0558044 00000001 dd0cf4b4
[   29.043143] 7e80: de1968b4 dd0cf410 de196810 c0554bb0 c0c04900 00000002 c01874ac 00000000
[   29.051774] 7ea0: dd0cf510 c0558214 00000000 dd0cf410 de196810 c0557a68 c0558784 df946a40
[   29.060405] 7ec0: df94da00 c0cc1970 00000001 de177f28 de1321c0 dd0cf4b4 dd0cf554 df946a40
[   29.069037] 7ee0: df94da00 c0cc1970 00000001 de177f28 c0c0792c c05587d8 c0558770 de14b880
[   29.077667] 7f00: dd0cf554 c0153cd8 00000001 00000000 c0153c18 c0c0792c 4d3c9129 df946a40
[   29.086297] 7f20: 00000000 00000000 c1499dbc c0e013dc 00000000 c09e5d9c de1321c0 de14b880
[   29.094928] 7f40: df946a40 df946a74 c0c04900 c0c4dc86 00000008 de14b898 df946a40 c015436c
[   29.103559] 7f60: de1321c0 de14b580 00000000 de14b580 00000000 de158040 de14b5b8 de093e98
[   29.112190] 7f80: c0154208 de14b880 00000000 c015a5b4 de158040 c015a4bc 00000000 00000000
[   29.120819] 7fa0: 00000000 00000000 00000000 c0107890 00000000 00000000 00000000 00000000
[   29.129448] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   29.138078] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 b392d675 d669cbdc
[   29.146731] [<bf278588>] (cppi41_runtime_resume [cppi41]) from [<c0554bdc>] (pm_generic_runtime_resume+0x2c/0x40)
[   29.157555] [<c0554bdc>] (pm_generic_runtime_resume) from [<c0558044>] (__rpm_callback+0x44/0x1ec)
[   29.167006] [<c0558044>] (__rpm_callback) from [<c0558214>] (rpm_callback+0x28/0x88)
[   29.175178] [<c0558214>] (rpm_callback) from [<c0557a68>] (rpm_resume+0x3d4/0x6e8)
[   29.183168] [<c0557a68>] (rpm_resume) from [<c05587d8>] (pm_runtime_work+0x68/0x98)
[   29.191255] [<c05587d8>] (pm_runtime_work) from [<c0153cd8>] (process_one_work+0x1e0/0x6d8)
[   29.200071] [<c0153cd8>] (process_one_work) from [<c015436c>] (worker_thread+0x164/0x48c)
[   29.208703] [<c015436c>] (worker_thread) from [<c015a5b4>] (kthread+0xf8/0x134)
[   29.216422] [<c015a5b4>] (kthread) from [<c0107890>] (ret_from_fork+0x14/0x24)
[   29.224051] Code: ebffff0f e594208c e5941088 e1a03005 (e5812004) 
[   29.230492] ---[ end trace fc3a8cc6a95cb871 ]---

Note that with this series, I'm able to play music again but
I have a lot of underruns. These underruns doesn't happens when
the dma is not enabled.

Changes in v2:
 - remove the condition and use list_empty to set the variable "active"

Alexandre Bailon (2):
  dmaengine: cppi41: Fix list not empty warning on runtime suspend
  dmaengine: cppi41: Ignore EINPROGRESS for PM runtime in interrupt
    handler

 drivers/dma/cppi41.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
