From: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2] dmaengine: cppi41: Fix oops in cppi41_runtime_resume
Date: Fri, 13 Jan 2017 12:36:35 -0600
Message-ID: <d6fddff7-3d00-1de1-ebbf-ee2a949a6284@ti.com>
References: <20170113180132.9188-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170113180132.9188-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org



On 01/13/2017 12:01 PM, Tony Lindgren wrote:
> Commit fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
> together with recent MUSB changes allowed USB and DMA on BeagleBone to idle
> when no cable is connected. But looks like few corner case issues still
> remain.
> 
> Looks like just by re-plugging USB cable about ten or so times on BeagleBone
> when configured in USB peripheral mode we can get warnings and eventually
> trigger an oops in cppi41 DMA:
> 
> WARNING: CPU: 0 PID: 14 at drivers/dma/cppi41.c:1154 cppi41_runtime_suspend+
> x28/0x38 [cppi41]
> ...
> 
> WARNING: CPU: 0 PID: 14 at drivers/dma/cppi41.c:452
> push_desc_queue+0x94/0x9c [cppi41]
> ...
> 
> Unable to handle kernel NULL pointer dereference at virtual
> address 00000104
> pgd = c0004000
> [00000104] *pgd=00000000
> Internal error: Oops: 805 [#1] SMP ARM
> ...
> [<bf0d92cc>] (cppi41_runtime_resume [cppi41]) from [<c0589838>]
> (__rpm_callback+0xc0/0x214)
> [<c0589838>] (__rpm_callback) from [<c05899ac>] (rpm_callback+0x20/0x80)
> [<c05899ac>] (rpm_callback) from [<c0589460>] (rpm_resume+0x504/0x78c)
> [<c0589460>] (rpm_resume) from [<c058a1a0>] (pm_runtime_work+0x60/0xa8)
> [<c058a1a0>] (pm_runtime_work) from [<c0156120>] (process_one_work+0x2b4/0x808)
> 
> This is because of a race with runtime PM and cppi41_dma_issue_pending()
> as reported by Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> in earlier
> set of patches. Based on mailing list discussions we however came to the
> conclusion that a different fix from Alexandre's fix is needed in order
> to guarantee that DMA is really active when we try to use it.
> 
> To fix the issue, we need to add a driver specific flag as we otherwise
> can have -EINPROGRESS state set by runtime PM and can't rely on
> pm_runtime_active() to tell us when we can use the DMA.
> 
> And we need to make sure the DMA transfers get triggered in the queued
> order. So let's always queue the transfers, then flush the queue
> from both cppi41_dma_issue_pending() and cppi41_runtime_resume()
> as suggested by Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> in an
> earlier example patch.
> 
> For reference, this is also documented in Documentation/power/runtime_pm.txt
> in the example at the end of the file as pointed out by Grygorii Strashko
> <grygorii.strashko-l0cyMroinI0@public.gmane.org>.
> 
> Based on earlier patches from Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> and Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> modified based on
> testing and what was discussed on the mailing lists.
> 
> Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
> Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
> Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> Cc: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Cc: Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Cc: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
> Reported-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
> 
> Alexandre & Grygorii, can you guys please review and test?

I've just tested it on BBB. And it triggers warning from IRQ

root@am335x-evm:~# [  242.280546] ------------[ cut here ]------------
[  242.285532] WARNING: CPU: 0 PID: 0 at drivers/dma/cppi41.c:330 cppi41_irq+0x228/0x260 [cppi41]
[  242.335164] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.10.0-rc3-00560-g51afc29 #133
[  242.344601] Hardware name: Generic AM33XX (Flattened Device Tree)
[  242.351084] [<c011013c>] (unwind_backtrace) from [<c010c300>] (show_stack+0x10/0x14)
[  242.359269] [<c010c300>] (show_stack) from [<c04a0278>] (dump_stack+0xac/0xe0)
[  242.366919] [<c04a0278>] (dump_stack) from [<c013700c>] (__warn+0xd8/0x104)
[  242.374282] [<c013700c>] (__warn) from [<c01370e4>] (warn_slowpath_null+0x20/0x28)
[  242.382299] [<c01370e4>] (warn_slowpath_null) from [<bf1d0384>] (cppi41_irq+0x228/0x260 [cppi41])
[  242.391714] [<bf1d0384>] (cppi41_irq [cppi41]) from [<c01a6888>] (__handle_irq_event_percpu+0x48/0x3b4)
[  242.401727] [<c01a6888>] (__handle_irq_event_percpu) from [<c01a6c10>] (handle_irq_event_percpu+0x1c/0x58)
[  242.412017] [<c01a6c10>] (handle_irq_event_percpu) from [<c01a6c84>] (handle_irq_event+0x38/0x5c)
[  242.421477] [<c01a6c84>] (handle_irq_event) from [<c01aa004>] (handle_level_irq+0xc0/0x154)
[  242.430378] [<c01aa004>] (handle_level_irq) from [<c01a5b9c>] (generic_handle_irq+0x20/0x34)
[  242.439378] [<c01a5b9c>] (generic_handle_irq) from [<c01a60f0>] (__handle_domain_irq+0x64/0xe0)
[  242.448660] [<c01a60f0>] (__handle_domain_irq) from [<c07f92f0>] (__irq_svc+0x70/0x98)
[  242.457117] [<c07f92f0>] (__irq_svc) from [<c010836c>] (arch_cpu_idle+0x20/0x3c)
[  242.464935] [<c010836c>] (arch_cpu_idle) from [<c018bf7c>] (do_idle+0x164/0x218)
[  242.472748] [<c018bf7c>] (do_idle) from [<c018c39c>] (cpu_startup_entry+0x18/0x1c)
[  242.480758] [<c018c39c>] (cpu_startup_entry) from [<c0b00c30>] (start_kernel+0x344/0x3bc)
[  242.489376] ---[ end trace 12c5b6488c1e8c75 ]---
[  242.496525] usb 1-1.3: USB disconnect, device number 4

test sequence:
- plug usb hub + cd card reader
- plug usb stick in hub
  37  mount /dev/sdb /media
   38  ls /media/
   39  rm /media/data 
   40  time dd if=/dev/zero of=/media/data bs=128k count=100
   41  umount /media
- unplug USB stick - > Warning

^ The same sequence without Hub -- > no warnings

When I plug-unplug USB stick from Hub I can reproduce it pretty often :(
but it can be different issue :(

Patch by itself looks good


root@am335x-evm:~# [  590.948093] usb 1-1: new high-speed USB device number 6 using musb-hdrc
[  591.119731] usb 1-1: New USB device found, idVendor=058f, idProduct=6254
[  591.126841] usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[  591.134565] usb 1-1: Product: USB2.0Hub
[  591.146776] hub 1-1:1.0: USB hub found
[  591.151375] hub 1-1:1.0: 4 ports detected
[  591.487947] usb 1-1.4: new high-speed USB device number 7 using musb-hdrc
[  591.631141] usb 1-1.4: New USB device found, idVendor=058f, idProduct=6366
[  591.638474] usb 1-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  591.646140] usb 1-1.4: Product: Mass Storage Device
[  591.651336] usb 1-1.4: Manufacturer: Generic
[  591.655817] usb 1-1.4: SerialNumber: 058F0O1111B1
[  591.665677] usb-storage 1-1.4:1.0: USB Mass Storage device detected
[  591.679987] scsi host0: usb-storage 1-1.4:1.0
[  592.731385] scsi 0:0:0:0: Direct-Access     Multi    Flash Reader     1.00 PQ: 0 ANSI: 0
[  592.769590] sd 0:0:0:0: [sda] Attached SCSI removable disk
[  593.948402] ------------[ cut here ]------------
[  593.953396] WARNING: CPU: 0 PID: 0 at drivers/dma/cppi41.c:330 cppi41_irq+0x228/0x260 [cppi41]
[  593.962470] Modules linked in: usb_storage evdev musb_dsps musb_hdrc udc_core cppi41 phy_am335x usbcore phy_generic usb_common phy_am335x_control snd_soc_simple_card snd_soc_simple_card_utils snd_soc_davinci_mcasp tps65218_pn
[  594.003038] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.10.0-rc3-00560-g51afc29 #133
[  594.012473] Hardware name: Generic AM33XX (Flattened Device Tree)
[  594.018958] [<c011013c>] (unwind_backtrace) from [<c010c300>] (show_stack+0x10/0x14)
[  594.027143] [<c010c300>] (show_stack) from [<c04a0278>] (dump_stack+0xac/0xe0)
[  594.034793] [<c04a0278>] (dump_stack) from [<c013700c>] (__warn+0xd8/0x104)
[  594.042158] [<c013700c>] (__warn) from [<c01370e4>] (warn_slowpath_null+0x20/0x28)
[  594.050174] [<c01370e4>] (warn_slowpath_null) from [<bf1d0384>] (cppi41_irq+0x228/0x260 [cppi41])
[  594.059590] [<bf1d0384>] (cppi41_irq [cppi41]) from [<c01a6888>] (__handle_irq_event_percpu+0x48/0x3b4)
[  594.069602] [<c01a6888>] (__handle_irq_event_percpu) from [<c01a6c10>] (handle_irq_event_percpu+0x1c/0x58)
[  594.079892] [<c01a6c10>] (handle_irq_event_percpu) from [<c01a6c84>] (handle_irq_event+0x38/0x5c)
[  594.089344] [<c01a6c84>] (handle_irq_event) from [<c01aa004>] (handle_level_irq+0xc0/0x154)
[  594.098245] [<c01aa004>] (handle_level_irq) from [<c01a5b9c>] (generic_handle_irq+0x20/0x34)
[  594.107243] [<c01a5b9c>] (generic_handle_irq) from [<c01a60f0>] (__handle_domain_irq+0x64/0xe0)
[  594.116525] [<c01a60f0>] (__handle_domain_irq) from [<c07f92f0>] (__irq_svc+0x70/0x98)
[  594.124980] [<c07f92f0>] (__irq_svc) from [<c010836c>] (arch_cpu_idle+0x20/0x3c)
[  594.132798] [<c010836c>] (arch_cpu_idle) from [<c018bf7c>] (do_idle+0x164/0x218)
[  594.140610] [<c018bf7c>] (do_idle) from [<c018c39c>] (cpu_startup_entry+0x18/0x1c)
[  594.148619] [<c018c39c>] (cpu_startup_entry) from [<c0b00c30>] (start_kernel+0x344/0x3bc)
[  594.157238] ---[ end trace 12c5b6488c1e8c76 ]---
[  594.467931] usb 1-1.3: new high-speed USB device number 8 using musb-hdrc
[  594.672753] usb 1-1.3: New USB device found, idVendor=058f, idProduct=6387
[  594.680179] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  594.688032] usb 1-1.3: Product: Mass Storage Device
[  594.693192] usb 1-1.3: Manufacturer: Generic
[  594.697708] usb 1-1.3: SerialNumber: OU2ACT49
[  594.710778] usb-storage 1-1.3:1.0: USB Mass Storage device detected
[  594.730376] scsi host1: usb-storage 1-1.3:1.0
[  595.771756] scsi 1:0:0:0: Direct-Access     JetFlash TS128MJF2A       8.07 PQ: 0 ANSI: 2
[  595.799177] sd 1:0:0:0: [sdb] 255998 512-byte logical blocks: (131 MB/125 MiB)
[  595.818767] sd 1:0:0:0: [sdb] Write Protect is off
[  595.838684] sd 1:0:0:0: [sdb] No Caching mode page found
[  595.844350] sd 1:0:0:0: [sdb] Assuming drive cache: write through
[  595.905633]  sdb:
[  595.921145] sd 1:0:0:0: [sdb] Attached SCSI removable disk
[  596.556411] FAT-fs (sdb): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[  615.452300] ------------[ cut here ]------------
[  615.457291] WARNING: CPU: 0 PID: 0 at drivers/dma/cppi41.c:330 cppi41_irq+0x228/0x260 [cppi41]
[  615.466367] Modules linked in: usb_storage evdev musb_dsps musb_hdrc udc_core cppi41 phy_am335x usbcore phy_generic usb_common phy_am335x_control snd_soc_simple_card snd_soc_simple_card_utils snd_soc_davinci_mcasp tps65218_pn
[  615.506931] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.10.0-rc3-00560-g51afc29 #133
[  615.516366] Hardware name: Generic AM33XX (Flattened Device Tree)
[  615.522850] [<c011013c>] (unwind_backtrace) from [<c010c300>] (show_stack+0x10/0x14)
[  615.531034] [<c010c300>] (show_stack) from [<c04a0278>] (dump_stack+0xac/0xe0)
[  615.538685] [<c04a0278>] (dump_stack) from [<c013700c>] (__warn+0xd8/0x104)
[  615.546049] [<c013700c>] (__warn) from [<c01370e4>] (warn_slowpath_null+0x20/0x28)
[  615.554066] [<c01370e4>] (warn_slowpath_null) from [<bf1d0384>] (cppi41_irq+0x228/0x260 [cppi41])
[  615.563481] [<bf1d0384>] (cppi41_irq [cppi41]) from [<c01a6888>] (__handle_irq_event_percpu+0x48/0x3b4)
[  615.573500] [<c01a6888>] (__handle_irq_event_percpu) from [<c01a6c10>] (handle_irq_event_percpu+0x1c/0x58)
[  615.583789] [<c01a6c10>] (handle_irq_event_percpu) from [<c01a6c84>] (handle_irq_event+0x38/0x5c)
[  615.593251] [<c01a6c84>] (handle_irq_event) from [<c01aa004>] (handle_level_irq+0xc0/0x154)
[  615.602151] [<c01aa004>] (handle_level_irq) from [<c01a5b9c>] (generic_handle_irq+0x20/0x34)
[  615.611144] [<c01a5b9c>] (generic_handle_irq) from [<c01a60f0>] (__handle_domain_irq+0x64/0xe0)
[  615.620432] [<c01a60f0>] (__handle_domain_irq) from [<c07f92f0>] (__irq_svc+0x70/0x98)
[  615.628893] [<c07f92f0>] (__irq_svc) from [<c010836c>] (arch_cpu_idle+0x20/0x3c)
[  615.636786] [<c010836c>] (arch_cpu_idle) from [<c018bf7c>] (do_idle+0x164/0x218)
[  615.644677] [<c018bf7c>] (do_idle) from [<c018c39c>] (cpu_startup_entry+0x18/0x1c)
[  615.652766] [<c018c39c>] (cpu_startup_entry) from [<c0b00c30>] (start_kernel+0x344/0x3bc)
[  615.661470] ---[ end trace 12c5b6488c1e8c77 ]---
[  615.676487] usb 1-1.3: USB disconnect, device number 8

root@am335x-evm:~# 
root@am335x-evm:~# [  626.008636] usb 1-1: USB disconnect, device number 6
[  626.013945] usb 1-1.4: USB disconnect, device number 7
[  630.538101] usb 1-1: new high-speed USB device number 9 using musb-hdrc
[  630.709737] usb 1-1: New USB device found, idVendor=058f, idProduct=6254
[  630.716845] usb 1-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[  630.724564] usb 1-1: Product: USB2.0Hub
[  630.736885] hub 1-1:1.0: USB hub found
[  630.750975] hub 1-1:1.0: 4 ports detected
[  631.077965] usb 1-1.4: new high-speed USB device number 10 using musb-hdrc
[  631.211138] usb 1-1.4: New USB device found, idVendor=058f, idProduct=6366
[  631.218452] usb 1-1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  631.226116] usb 1-1.4: Product: Mass Storage Device
[  631.231311] usb 1-1.4: Manufacturer: Generic
[  631.235793] usb 1-1.4: SerialNumber: 058F0O1111B1
[  631.245578] usb-storage 1-1.4:1.0: USB Mass Storage device detected
[  631.259530] scsi host0: usb-storage 1-1.4:1.0
[  632.333419] scsi 0:0:0:0: Direct-Access     Multi    Flash Reader     1.00 PQ: 0 ANSI: 0
[  632.389945] sd 0:0:0:0: [sda] Attached SCSI removable disk
[  637.378367] ------------[ cut here ]------------
[  637.383358] WARNING: CPU: 0 PID: 0 at drivers/dma/cppi41.c:330 cppi41_irq+0x228/0x260 [cppi41]
[  637.392431] Modules linked in: usb_storage evdev musb_dsps musb_hdrc udc_core cppi41 phy_am335x usbcore phy_generic usb_common phy_am335x_control snd_soc_simple_card snd_soc_simple_card_utils snd_soc_davinci_mcasp tps65218_pn
[  637.432996] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.10.0-rc3-00560-g51afc29 #133
[  637.442432] Hardware name: Generic AM33XX (Flattened Device Tree)
[  637.448914] [<c011013c>] (unwind_backtrace) from [<c010c300>] (show_stack+0x10/0x14)
[  637.457099] [<c010c300>] (show_stack) from [<c04a0278>] (dump_stack+0xac/0xe0)
[  637.464748] [<c04a0278>] (dump_stack) from [<c013700c>] (__warn+0xd8/0x104)
[  637.472112] [<c013700c>] (__warn) from [<c01370e4>] (warn_slowpath_null+0x20/0x28)
[  637.480130] [<c01370e4>] (warn_slowpath_null) from [<bf1d0384>] (cppi41_irq+0x228/0x260 [cppi41])
[  637.489545] [<bf1d0384>] (cppi41_irq [cppi41]) from [<c01a6888>] (__handle_irq_event_percpu+0x48/0x3b4)
[  637.499565] [<c01a6888>] (__handle_irq_event_percpu) from [<c01a6c10>] (handle_irq_event_percpu+0x1c/0x58)
[  637.509852] [<c01a6c10>] (handle_irq_event_percpu) from [<c01a6c84>] (handle_irq_event+0x38/0x5c)
[  637.519315] [<c01a6c84>] (handle_irq_event) from [<c01aa004>] (handle_level_irq+0xc0/0x154)
[  637.528216] [<c01aa004>] (handle_level_irq) from [<c01a5b9c>] (generic_handle_irq+0x20/0x34)
[  637.537217] [<c01a5b9c>] (generic_handle_irq) from [<c01a60f0>] (__handle_domain_irq+0x64/0xe0)
[  637.546495] [<c01a60f0>] (__handle_domain_irq) from [<c07f92f0>] (__irq_svc+0x70/0x98)
[  637.554954] [<c07f92f0>] (__irq_svc) from [<c010836c>] (arch_cpu_idle+0x20/0x3c)
[  637.562772] [<c010836c>] (arch_cpu_idle) from [<c018bf7c>] (do_idle+0x164/0x218)
[  637.570585] [<c018bf7c>] (do_idle) from [<c018c39c>] (cpu_startup_entry+0x18/0x1c)
[  637.578594] [<c018c39c>] (cpu_startup_entry) from [<c0b00c30>] (start_kernel+0x344/0x3bc)
[  637.587211] ---[ end trace 12c5b6488c1e8c78 ]---
[  637.897902] usb 1-1.3: new high-speed USB device number 11 using musb-hdrc
[  638.032611] usb 1-1.3: New USB device found, idVendor=058f, idProduct=6387
[  638.040050] usb 1-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  638.047911] usb 1-1.3: Product: Mass Storage Device
[  638.053072] usb 1-1.3: Manufacturer: Generic
[  638.057587] usb 1-1.3: SerialNumber: OU2ACT49
[  638.070774] usb-storage 1-1.3:1.0: USB Mass Storage device detected
[  638.089869] scsi host1: usb-storage 1-1.3:1.0
[  639.133691] scsi 1:0:0:0: Direct-Access     JetFlash TS128MJF2A       8.07 PQ: 0 ANSI: 2
[  639.167142] sd 1:0:0:0: [sdb] 255998 512-byte logical blocks: (131 MB/125 MiB)
[  639.189067] sd 1:0:0:0: [sdb] Write Protect is off
[  639.200963] sd 1:0:0:0: [sdb] No Caching mode page found
[  639.206621] sd 1:0:0:0: [sdb] Assuming drive cache: write through
[  639.260360]  sdb:
[  639.295633] sd 1:0:0:0: [sdb] Attached SCSI removable disk
[  639.937425] FAT-fs (sdb): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[  643.522357] ------------[ cut here ]------------
[  643.527345] WARNING: CPU: 0 PID: 0 at drivers/dma/cppi41.c:330 cppi41_irq+0x228/0x260 [cppi41]
[  643.536418] Modules linked in: usb_storage evdev musb_dsps musb_hdrc udc_core cppi41 phy_am335x usbcore phy_generic usb_common phy_am335x_control snd_soc_simple_card snd_soc_simple_card_utils snd_soc_davinci_mcasp tps65218_pn
[  643.576981] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.10.0-rc3-00560-g51afc29 #133
[  643.586416] Hardware name: Generic AM33XX (Flattened Device Tree)
[  643.592898] [<c011013c>] (unwind_backtrace) from [<c010c300>] (show_stack+0x10/0x14)
[  643.601082] [<c010c300>] (show_stack) from [<c04a0278>] (dump_stack+0xac/0xe0)
[  643.608733] [<c04a0278>] (dump_stack) from [<c013700c>] (__warn+0xd8/0x104)
[  643.616095] [<c013700c>] (__warn) from [<c01370e4>] (warn_slowpath_null+0x20/0x28)
[  643.624111] [<c01370e4>] (warn_slowpath_null) from [<bf1d0384>] (cppi41_irq+0x228/0x260 [cppi41])
[  643.633526] [<bf1d0384>] (cppi41_irq [cppi41]) from [<c01a6888>] (__handle_irq_event_percpu+0x48/0x3b4)
[  643.643547] [<c01a6888>] (__handle_irq_event_percpu) from [<c01a6c10>] (handle_irq_event_percpu+0x1c/0x58)
[  643.653839] [<c01a6c10>] (handle_irq_event_percpu) from [<c01a6c84>] (handle_irq_event+0x38/0x5c)
[  643.663294] [<c01a6c84>] (handle_irq_event) from [<c01aa004>] (handle_level_irq+0xc0/0x154)
[  643.672200] [<c01aa004>] (handle_level_irq) from [<c01a5b9c>] (generic_handle_irq+0x20/0x34)
[  643.681196] [<c01a5b9c>] (generic_handle_irq) from [<c01a60f0>] (__handle_domain_irq+0x64/0xe0)
[  643.690479] [<c01a60f0>] (__handle_domain_irq) from [<c07f92f0>] (__irq_svc+0x70/0x98)
[  643.698937] [<c07f92f0>] (__irq_svc) from [<c010836c>] (arch_cpu_idle+0x20/0x3c)
[  643.706753] [<c010836c>] (arch_cpu_idle) from [<c018bf7c>] (do_idle+0x164/0x218)
[  643.714566] [<c018bf7c>] (do_idle) from [<c018c39c>] (cpu_startup_entry+0x18/0x1c)
[  643.722573] [<c018c39c>] (cpu_startup_entry) from [<c0b00c30>] (start_kernel+0x344/0x3bc)
[  643.731190] ---[ end trace 12c5b6488c1e8c79 ]---
[  643.745259] usb 1-1.3: USB disconnect, device number 11
[  647.703381] usb 1-1: USB disconnect, device number 9
[  647.708865] usb 1-1.4: USB disconnect, device number 10
[  654.308094] usb 1-1: new high-speed USB device number 12 using musb-hdrc
[  654.482563] usb 1-1: New USB device found, idVendor=058f, idProduct=6387
[  654.489807] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  654.497345] usb 1-1: Product: Mass Storage Device
[  654.502452] usb 1-1: Manufacturer: Generic
[  654.506791] usb 1-1: SerialNumber: OU2ACT49
[  654.519849] usb-storage 1-1:1.0: USB Mass Storage device detected
[  654.539319] scsi host0: usb-storage 1-1:1.0
[  655.613494] scsi 0:0:0:0: Direct-Access     JetFlash TS128MJF2A       8.07 PQ: 0 ANSI: 2
[  655.646875] sd 0:0:0:0: [sda] 255998 512-byte logical blocks: (131 MB/125 MiB)
[  655.668688] sd 0:0:0:0: [sda] Write Protect is off
[  655.680249] sd 0:0:0:0: [sda] No Caching mode page found
[  655.685906] sd 0:0:0:0: [sda] Assuming drive cache: write through
[  655.754170]  sda:
[  655.774799] sd 0:0:0:0: [sda] Attached SCSI removable disk
[  656.382509] FAT-fs (sda): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[  661.348430] usb 1-1: USB disconnect, device number 12
[  667.908145] usb 1-1: new high-speed USB device number 13 using musb-hdrc
[  668.082589] usb 1-1: New USB device found, idVendor=058f, idProduct=6387
[  668.089834] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  668.097373] usb 1-1: Product: Mass Storage Device
[  668.102528] usb 1-1: Manufacturer: Generic
[  668.106868] usb 1-1: SerialNumber: OU2ACT49
[  668.119949] usb-storage 1-1:1.0: USB Mass Storage device detected
[  668.139462] scsi host0: usb-storage 1-1:1.0
[  669.211804] scsi 0:0:0:0: Direct-Access     JetFlash TS128MJF2A       8.07 PQ: 0 ANSI: 2
[  669.238458] sd 0:0:0:0: [sda] 255998 512-byte logical blocks: (131 MB/125 MiB)
[  669.258577] sd 0:0:0:0: [sda] Write Protect is off
[  669.270862] sd 0:0:0:0: [sda] No Caching mode page found
[  669.276468] sd 0:0:0:0: [sda] Assuming drive cache: write through
[  669.337468]  sda:
[  669.380588] sd 0:0:0:0: [sda] Attached SCSI removable disk
[  670.003597] FAT-fs (sda): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[  674.253935] usb 1-1: USB disconnect, device number 13
[  678.888173] usb 1-1: new high-speed USB device number 14 using musb-hdrc
[  679.062609] usb 1-1: New USB device found, idVendor=058f, idProduct=6387
[  679.069866] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  679.077403] usb 1-1: Product: Mass Storage Device
[  679.082516] usb 1-1: Manufacturer: Generic
[  679.086855] usb 1-1: SerialNumber: OU2ACT49
[  679.100234] usb-storage 1-1:1.0: USB Mass Storage device detected
[  679.119805] scsi host0: usb-storage 1-1:1.0
[  680.181609] scsi 0:0:0:0: Direct-Access     JetFlash TS128MJF2A       8.07 PQ: 0 ANSI: 2
[  680.216574] sd 0:0:0:0: [sda] 255998 512-byte logical blocks: (131 MB/125 MiB)
[  680.239868] sd 0:0:0:0: [sda] Write Protect is off
[  680.250587] sd 0:0:0:0: [sda] No Caching mode page found
[  680.256243] sd 0:0:0:0: [sda] Assuming drive cache: write through
[  680.313569]  sda:
[  680.334123] sd 0:0:0:0: [sda] Attached SCSI removable disk
[  680.949436] FAT-fs (sda): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[  683.787309] usb 1-1: USB disconnect, device number 14


-- 
regards,
-grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
