From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] dmaengine: cppi41: Fix oops in cppi41_runtime_resume
Date: Fri, 13 Jan 2017 11:01:26 -0800
Message-ID: <20170113190126.GE2630@atomide.com>
References: <20170113180132.9188-1-tony@atomide.com>
 <d6fddff7-3d00-1de1-ebbf-ee2a949a6284@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d6fddff7-3d00-1de1-ebbf-ee2a949a6284-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [170113 10:37]:
> 
> 
> On 01/13/2017 12:01 PM, Tony Lindgren wrote:
> > Commit fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
> > together with recent MUSB changes allowed USB and DMA on BeagleBone to idle
> > when no cable is connected. But looks like few corner case issues still
> > remain.
> > 
> > Looks like just by re-plugging USB cable about ten or so times on BeagleBone
> > when configured in USB peripheral mode we can get warnings and eventually
> > trigger an oops in cppi41 DMA:
> > 
> > WARNING: CPU: 0 PID: 14 at drivers/dma/cppi41.c:1154 cppi41_runtime_suspend+
> > x28/0x38 [cppi41]
> > ...
> > 
> > WARNING: CPU: 0 PID: 14 at drivers/dma/cppi41.c:452
> > push_desc_queue+0x94/0x9c [cppi41]
> > ...
> > 
> > Unable to handle kernel NULL pointer dereference at virtual
> > address 00000104
> > pgd = c0004000
> > [00000104] *pgd=00000000
> > Internal error: Oops: 805 [#1] SMP ARM
> > ...
> > [<bf0d92cc>] (cppi41_runtime_resume [cppi41]) from [<c0589838>]
> > (__rpm_callback+0xc0/0x214)
> > [<c0589838>] (__rpm_callback) from [<c05899ac>] (rpm_callback+0x20/0x80)
> > [<c05899ac>] (rpm_callback) from [<c0589460>] (rpm_resume+0x504/0x78c)
> > [<c0589460>] (rpm_resume) from [<c058a1a0>] (pm_runtime_work+0x60/0xa8)
> > [<c058a1a0>] (pm_runtime_work) from [<c0156120>] (process_one_work+0x2b4/0x808)
> > 
> > This is because of a race with runtime PM and cppi41_dma_issue_pending()
> > as reported by Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> in earlier
> > set of patches. Based on mailing list discussions we however came to the
> > conclusion that a different fix from Alexandre's fix is needed in order
> > to guarantee that DMA is really active when we try to use it.
> > 
> > To fix the issue, we need to add a driver specific flag as we otherwise
> > can have -EINPROGRESS state set by runtime PM and can't rely on
> > pm_runtime_active() to tell us when we can use the DMA.
> > 
> > And we need to make sure the DMA transfers get triggered in the queued
> > order. So let's always queue the transfers, then flush the queue
> > from both cppi41_dma_issue_pending() and cppi41_runtime_resume()
> > as suggested by Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> in an
> > earlier example patch.
> > 
> > For reference, this is also documented in Documentation/power/runtime_pm.txt
> > in the example at the end of the file as pointed out by Grygorii Strashko
> > <grygorii.strashko-l0cyMroinI0@public.gmane.org>.
> > 
> > Based on earlier patches from Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> > and Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> modified based on
> > testing and what was discussed on the mailing lists.
> > 
> > Fixes: fdea2d09b997 ("dmaengine: cppi41: Add basic PM runtime support")
> > Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
> > Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
> > Cc: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> > Cc: Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> > Cc: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
> > Reported-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > ---
> > 
> > Alexandre & Grygorii, can you guys please review and test?
> 
> I've just tested it on BBB. And it triggers warning from IRQ
> 
> root@am335x-evm:~# [  242.280546] ------------[ cut here ]------------
> [  242.285532] WARNING: CPU: 0 PID: 0 at drivers/dma/cppi41.c:330 cppi41_irq+0x228/0x260 [cppi41]
> [  242.335164] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W       4.10.0-rc3-00560-g51afc29 #133
> [  242.344601] Hardware name: Generic AM33XX (Flattened Device Tree)
> [  242.351084] [<c011013c>] (unwind_backtrace) from [<c010c300>] (show_stack+0x10/0x14)
> [  242.359269] [<c010c300>] (show_stack) from [<c04a0278>] (dump_stack+0xac/0xe0)
> [  242.366919] [<c04a0278>] (dump_stack) from [<c013700c>] (__warn+0xd8/0x104)
> [  242.374282] [<c013700c>] (__warn) from [<c01370e4>] (warn_slowpath_null+0x20/0x28)
> [  242.382299] [<c01370e4>] (warn_slowpath_null) from [<bf1d0384>] (cppi41_irq+0x228/0x260 [cppi41])
> [  242.391714] [<bf1d0384>] (cppi41_irq [cppi41]) from [<c01a6888>] (__handle_irq_event_percpu+0x48/0x3b4)
> [  242.401727] [<c01a6888>] (__handle_irq_event_percpu) from [<c01a6c10>] (handle_irq_event_percpu+0x1c/0x58)
> [  242.412017] [<c01a6c10>] (handle_irq_event_percpu) from [<c01a6c84>] (handle_irq_event+0x38/0x5c)
> [  242.421477] [<c01a6c84>] (handle_irq_event) from [<c01aa004>] (handle_level_irq+0xc0/0x154)
> [  242.430378] [<c01aa004>] (handle_level_irq) from [<c01a5b9c>] (generic_handle_irq+0x20/0x34)
> [  242.439378] [<c01a5b9c>] (generic_handle_irq) from [<c01a60f0>] (__handle_domain_irq+0x64/0xe0)
> [  242.448660] [<c01a60f0>] (__handle_domain_irq) from [<c07f92f0>] (__irq_svc+0x70/0x98)
> [  242.457117] [<c07f92f0>] (__irq_svc) from [<c010836c>] (arch_cpu_idle+0x20/0x3c)
> [  242.464935] [<c010836c>] (arch_cpu_idle) from [<c018bf7c>] (do_idle+0x164/0x218)
> [  242.472748] [<c018bf7c>] (do_idle) from [<c018c39c>] (cpu_startup_entry+0x18/0x1c)
> [  242.480758] [<c018c39c>] (cpu_startup_entry) from [<c0b00c30>] (start_kernel+0x344/0x3bc)
> [  242.489376] ---[ end trace 12c5b6488c1e8c75 ]---
> [  242.496525] usb 1-1.3: USB disconnect, device number 4
> 
> test sequence:
> - plug usb hub + cd card reader
> - plug usb stick in hub
>   37  mount /dev/sdb /media
>    38  ls /media/
>    39  rm /media/data 
>    40  time dd if=/dev/zero of=/media/data bs=128k count=100
>    41  umount /media
> - unplug USB stick - > Warning
> 
> ^ The same sequence without Hub -- > no warnings
> 
> When I plug-unplug USB stick from Hub I can reproduce it pretty often :(
> but it can be different issue :(

Hmm interesting, I'll try it here too. I wonder if adding spin_lock_irqsave/
restore around the WARN_ON() in the interrupt handler is enough to make it
go away?

> Patch by itself looks good

OK

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
