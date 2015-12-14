From: Belisko Marek <marek.belisko@gmail.com>
Subject: 4.4-rc5 : INFO: rcu_sched detected stalls on CPUs/tasks in twl4030_bci_usb_ncb
Date: Mon, 14 Dec 2015 21:29:12 +0100
Message-ID: <CAAfyv35n==9_f2QergynuweOvtKd5DyHwifZe1Rvk4H290xhEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Hi,

randomly hit this issue from 4.4-rc1:

[   35.926605] INFO: rcu_sched detected stalls on CPUs/tasks:
[   35.932373]  (detected by 0, t=2602 jiffies, g=519, c=518, q=38)
[   35.938659] All QSes seen, last rcu_sched kthread activity 2602
(-26407--29009), jiffies_till_next_fqs=1, root ->qsmask 0x0
[   35.950317] kworker/0:2     R running      0   964      2 0x00000002
[   35.957031] Workqueue: events omap_musb_mailbox_work
[   35.962249] [<c0016db4>] (unwind_backtrace) from [<c0013438>]
(show_stack+0x10/0x14)
[   35.970367] [<c0013438>] (show_stack) from [<c009a4a4>]
(rcu_check_callbacks+0x548/0x774)
[   35.978942] [<c009a4a4>] (rcu_check_callbacks) from [<c009edc8>]
(update_process_times+0x30/0x5c)
[   35.988250] [<c009edc8>] (update_process_times) from [<c00aeb38>]
(tick_sched_handle+0x48/0x54)
[   35.997375] [<c00aeb38>] (tick_sched_handle) from [<c00aeb9c>]
(tick_sched_timer+0x58/0x9c)
[   36.006103] [<c00aeb9c>] (tick_sched_timer) from [<c009f7d8>]
(__hrtimer_run_queues+0x198/0x2b0)
[   36.015319] [<c009f7d8>] (__hrtimer_run_queues) from [<c009ff9c>]
(hrtimer_interrupt+0xac/0x1f4)
[   36.024536] [<c009ff9c>] (hrtimer_interrupt) from [<c00242e4>]
(omap2_gp_timer_interrupt+0x20/0x30)
[   36.034027] [<c00242e4>] (omap2_gp_timer_interrupt) from
[<c008de8c>] (handle_irq_event_percpu+0x78/0x1d4)
[   36.044128] [<c008de8c>] (handle_irq_event_percpu) from
[<c008e020>] (handle_irq_event+0x38/0x5c)
[   36.053436] [<c008e020>] (handle_irq_event) from [<c00910b0>]
(handle_level_irq+0xf0/0x130)
[   36.062194] [<c00910b0>] (handle_level_irq) from [<c008d5a4>]
(generic_handle_irq+0x18/0x28)
[   36.071014] [<c008d5a4>] (generic_handle_irq) from [<c008d8b0>]
(__handle_domain_irq+0x98/0xd8)
[   36.080139] [<c008d8b0>] (__handle_domain_irq) from [<c05a58b8>]
(__irq_svc+0x58/0x78)
[   36.088470] [<c05a58b8>] (__irq_svc) from [<bf0049a0>]
(twl4030_bci_usb_ncb+0x10/0x4c [twl4030_charger])
[   36.098449] [<bf0049a0>] (twl4030_bci_usb_ncb [twl4030_charger])
from [<c00587b8>] (notifier_call_chain+0x48/0x70)
[   36.109283] [<c00587b8>] (notifier_call_chain) from [<c0058918>]
(__atomic_notifier_call_chain+0x94/0x118)
[   36.119415] [<c0058918>] (__atomic_notifier_call_chain) from
[<c00589b0>] (atomic_notifier_call_chain+0x14/0x1c)
[   36.130065] [<c00589b0>] (atomic_notifier_call_chain) from
[<c04322a0>] (omap_musb_mailbox_work+0x28/0x48)
[   36.140197] [<c04322a0>] (omap_musb_mailbox_work) from [<c0051e2c>]
(process_one_work+0x284/0x484)
[   36.149597] [<c0051e2c>] (process_one_work) from [<c0052f98>]
(worker_thread+0x2a4/0x3d8)
[   36.158142] [<c0052f98>] (worker_thread) from [<c0057960>]
(kthread+0xd8/0xec)
[   36.165740] [<c0057960>] (kthread) from [<c000ef70>]
(ret_from_fork+0x14/0x24)
[   36.173309] rcu_sched kthread starved for 2602 jiffies! g519 c518
f0x2 s3 ->state=0x0


is it known problem? Is there fix for this issue? Thanks.

BR,

marek


-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
