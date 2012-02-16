From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 8/8] arm: omap3: prevent per_clkdm from attempting
 manual domain transitions
Date: Thu, 16 Feb 2012 10:57:32 +0200
Message-ID: <1329382652.4102.386.camel@sokoban>
References: <1329320274-481-1-git-send-email-t-kristo@ti.com>
	 <1329320274-481-9-git-send-email-t-kristo@ti.com>  <87pqdf99c2.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44843 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752666Ab2BPI5n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 03:57:43 -0500
In-Reply-To: <87pqdf99c2.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On Wed, 2012-02-15 at 11:37 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > Attempting this will cause problems especially with off-mode enabled.
> 
> Please be more verbose about the problems seen, and the root cause(s).
> 

I was actually looking forward for some help with this commit message,
as I am still not quite sure what is going on in here. :) Here is the
log for suspend (btw, cam_pwrdm does not go to off in mainline yet, but
I think that is probably fixed by the patch from Paul,
omap_set_pwrdm_state() does not work properly.) The warning comes out
after wakeup from off-mode, and it is triggered by the disabling of
autodeps before off-mode entry.



[   79.010345] PM: Syncing filesystems ... done.
[   79.083801] Freezing user space processes ... (elapsed 0.01 seconds)
done.
[   79.110839] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) don
e.
[   79.141845] Suspending console(s) (use no_console_suspend to debug)
[   79.266815] PM: suspend of devices complete after 115.551 msecs
[   79.269958] PM: late suspend of devices complete after 3.142 msecs
[   79.270050] Disabling non-boot CPUs ...
[   79.697235] Powerdomain (cam_pwrdm) didn't enter target state 0
[   79.697265] Could not enter target state in pm_suspend
[   79.699829] PM: early resume of devices complete after 2.257 msecs
[   79.699920] ------------[ cut here ]------------
[   79.699981] WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:161
omap3_l3_app_ir
q+0xd8/0x130()
[   79.699981] In-band Error seen by MPU  at address 0
[   79.699981] Modules linked in:
[   79.700042] [<c001bcd0>] (unwind_backtrace+0x0/0xf4) from
[<c00428d0>] (warn_
slowpath_common+0x4c/0x64)
[   79.700073] [<c00428d0>] (warn_slowpath_common+0x4c/0x64) from
[<c004297c>] (
warn_slowpath_fmt+0x30/0x40)
[   79.700103] [<c004297c>] (warn_slowpath_fmt+0x30/0x40) from
[<c0034a2c>] (oma
p3_l3_app_irq+0xd8/0x130)
[   79.700103] [<c0034a2c>] (omap3_l3_app_irq+0xd8/0x130) from
[<c00a09e4>] (han
dle_irq_event_percpu+0x5c/0x22c)
[   79.700134] [<c00a09e4>] (handle_irq_event_percpu+0x5c/0x22c) from
[<c00a0bf0
>] (handle_irq_event+0x3c/0x5c)
[   79.700164] [<c00a0bf0>] (handle_irq_event+0x3c/0x5c) from
[<c00a3a70>] (hand
le_level_irq+0xac/0x118)
[   79.700195] [<c00a3a70>] (handle_level_irq+0xac/0x118) from
[<c00a0490>] (gen
eric_handle_irq+0x34/0x44)
[   79.700225] [<c00a0490>] (generic_handle_irq+0x34/0x44) from
[<c00151ec>] (ha
IdRQ+0x4c/0xac)
[   79.700256] [<c00151ec>] (handle_IRQ+0x4c/0xac) from [<c0008548>]
(omap3_intc
_handle_irq+0x44/0x4c)
[   79.700256] [<c0008548>] (omap3_intc_handle_irq+0x44/0x4c) from
[<c0476824>] 
(__irq_svc+0x44/0x60)
[   79.700286] Exception stack(0xcefe7e78 to 0xcefe7ec0)
[   79.700286] 7e60:
00007
a93 cedb25d0
[   79.700317] 7e80: 00000000 cedb2140 60000153 c0676994 00000000
c0676994 60000
153 00000000
[   79.700347] 7ea0: c0676940 000a3008 c0721d40 cefe7ec0 00007a94
c04765e4 20000
153 ffffffff
[   79.700347] [<c0476824>] (__irq_svc+0x44/0x60) from [<c04765e4>]
(_raw_spin_u
nlock_irqrestore+0x34/0x44)
[   79.700378] [<c04765e4>] (_raw_spin_unlock_irqrestore+0x34/0x44) from
[<c00a5
e18>] (resume_irqs+0x9c/0xbc)
[   79.700408] [<c00a5e18>] (resume_irqs+0x9c/0xbc) from [<c008061c>]
(suspend_d
evices_and_enter+0x114/0x2d8)
[   79.700439] [<c008061c>] (suspend_devices_and_enter+0x114/0x2d8) from
[<c0080
91c>] (enter_state+0x13c/0x184)
[   79.700469] [<c008091c>] (enter_state+0x13c/0x184) from [<c007f5fc>]
(state_s
tore+0xd0/0x170)
[   79.700500] [<c007f5fc>] (state_store+0xd0/0x170) from [<c02536a8>]
(kobj_att
r_store+0x18/0x1c)
[   79.700531] [<c02536a8>] (kobj_attr_store+0x18/0x1c) from
[<c0167a9c>] (sysfs
_write_file+0xfc/0x180)
[   79.700561] [<c0167a9c>] (sysfs_write_file+0xfc/0x180) from
[<c0107ed4>] (vfs
_write+0xb0/0x134)
[   79.700561] [<c0107ed4>] (vfs_write+0xb0/0x134) from [<c0108028>]
(sys_write+
0x40/0x70)
[   79.700592] [<c0108028>] (sys_write+0x40/0x70) from [<c0014160>]
(ret_fast_sy
scall+0x0/0x3c)
[   79.700622] ---[ end trace 338e34a6f123bc2b ]---
[   80.121765] PM: resume of devices complete after 420.012 msecs
[   80.414886] Restarting tasks ... done.


> Kevin
> 
> > Previously this issue was hidden by the fact that per_clkdm never
> > attempted manual idle by software, as the usecounts for the clockdomain
> > were broken.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > ---
> >  arch/arm/mach-omap2/clockdomains3xxx_data.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> > index b84e138..db31bbf 100644
> > --- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
> > +++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> > @@ -282,7 +282,7 @@ static struct clockdomain usbhost_clkdm = {
> >  static struct clockdomain per_clkdm = {
> >  	.name		= "per_clkdm",
> >  	.pwrdm		= { .name = "per_pwrdm" },
> > -	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> > +	.flags		= CLKDM_CAN_HWSUP_SWSUP | CLKDM_NO_MANUAL_TRANS,
> >  	.dep_bit	= OMAP3430_EN_PER_SHIFT,
> >  	.wkdep_srcs	= per_wkdeps,
> >  	.sleepdep_srcs	= per_sleepdeps,


