From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Unbalanced IRQ wake disable during resume from static suspend
Date: Thu, 2 Dec 2010 20:24:07 +0530
Message-ID: <3e628cf50d6e5d414abf749b47232e4e@mail.gmail.com>
References: <alpine.DEB.2.00.1012020057550.2515@utopia.booyaka.com><alpine.DEB.2.00.1012020112540.2515@utopia.booyaka.com><1c6ea016b8c01ee8b470e95fdcae4ee0@mail.gmail.com><AANLkTikqvVK2BWpiik5SVWPRzC6NMKs=Udvrtru5BfR-@mail.gmail.com><09fd160109a43efec9a472055d541c9e@mail.gmail.com>
 <87y6882rc9.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:50990 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932098Ab0LBOyJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 09:54:09 -0500
Received: by mail-qw0-f44.google.com with SMTP id 5so7014383qwg.3
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 06:54:08 -0800 (PST)
In-Reply-To: <87y6882rc9.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Govindraj <govindraj.ti@gmail.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, December 02, 2010 7:46 PM
> To: Santosh Shilimkar
> Cc: Govindraj; Paul Walmsley; linux-omap@vger.kernel.org
> Subject: Re: Unbalanced IRQ wake disable during resume from static
suspend
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> [...]
>
> > Here is the refreshed version with change log. Also
> > attached the patch in case google mails raps it up.
> >
> > From 0170159ae34957efb839d9143123f7ced795f62e Mon Sep 17 00:00:00 2001
> > From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Date: Thu, 2 Dec 2010 14:36:17 +0530
> > Subject: [PATCH] omap: irq: Dummy handler for enable_irq_wake
> >
> > With PM enabled, enable_irq_wake() has a callback for
> > interrupt controllers. But since omap INTC handler did not had this
> > call back associated, it was always returning -ENXIO, which was
> > breaking the existing drivers. This patch adds dummy handlers in
> > in order to avoid breaking of existing drivers.
>
> Can you describe a little more exacly how drivers were being broken
> (e.g. describe why this caused unbalanced IRQs, etc.)
>
Whenever " set_irq_wake_real" fails, the desc->wake_depth =0
And that generates a WARN_ON

if (desc->wake_depth == 0) {
			WARN(1, "Unbalanced IRQ %d wake disable\n", irq);


> Other than that this looks like the right fix.
>
> I guess this hasn't been seen before since we haven't tested the sysfs
> wakeup interface for the omap-serial driver.  For on-chip OMAP UARTs,
> using the sysfs interface isn't needed as the serial core is already
> doing device_init_wakeup(dev, true);
>
> Kevin
>
> > Without this patch you get below warnings with wakeup enabled on
devices
> >
> > ------------[ cut here ]------------
> > WARNING: at kernel/irq/manage.c:382 set_irq_wake+0x80/0xe4()
> > Unbalanced IRQ 72 wake disable
> > Modules linked in:
> > [<c0062a28>] (unwind_backtrace+0x0/0xec) from [<c0092260>]
> > (warn_slowpath_common+0x4c/0x64)
> > [<c0092260>] (warn_slowpath_common+0x4c/0x64) from [<c00922f8>]
> > (warn_slowpath_fmt+0x2c/0x3c
> >
> > [<c00922f8>] (warn_slowpath_fmt+0x2c/0x3c) from [<c00d3238>]
> > (set_irq_wake+0x80/0xe4)
> > [<c00d3238>] (set_irq_wake+0x80/0xe4) from [<c029dd60>]
> > (uart_resume_port+0x84/0x248)
> > [<c029dd60>] (uart_resume_port+0x84/0x248) from [<c02a2338>]
> > (serial_omap_resume+0x20/0x2c)
> > [<c02a2338>] (serial_omap_resume+0x20/0x2c) from [<c02a92d4>]
> > (platform_pm_resume+0x48/0x54)
> > [<c02a92d4>] (platform_pm_resume+0x48/0x54) from [<c02abd1c>]
> > (pm_op+0x6c/0xac)
> > [<c02abd1c>] (pm_op+0x6c/0xac) from [<c02ac0fc>]
> > (device_resume+0x58/0x10c)
> > [<c02ac0fc>] (device_resume+0x58/0x10c) from [<c02ac2ec>]
> > (dpm_resume_end+0xf4/0x360)
> > [<c02ac2ec>] (dpm_resume_end+0xf4/0x360) from [<c00cf58c>]
> > (suspend_devices_and_enter+0x1ac/
> > 0x200)
> > [<c00cf58c>] (suspend_devices_and_enter+0x1ac/0x200) from [<c00cf6c0>]
> > (enter_state+0xe0/0x1
> > 38)
> > [<c00cf6c0>] (enter_state+0xe0/0x138) from [<c00ced18>]
> > (state_store+0x90/0xb8)
> > [<c00ced18>] (state_store+0x90/0xb8) from [<c0243b98>]
> > (kobj_attr_store+0x18/0x1c)
> > [<c0243b98>] (kobj_attr_store+0x18/0x1c) from [<c0176128>]
> > (sysfs_write_file+0x10c/0x144)
> > [<c0176128>] (sysfs_write_file+0x10c/0x144) from [<c0125528>]
> > (vfs_write+0xac/0x134)
> > [<c0125528>] (vfs_write+0xac/0x134) from [<c012565c>]
> > (sys_write+0x3c/0x68)
> > [<c012565c>] (sys_write+0x3c/0x68) from [<c005bb00>]
> > (ret_fast_syscall+0x0/0x3c)
> > ---[ end trace 19fe50b7b47ba94f ]---
> >
> > Reported-by: Paul Walmsley <paul@pwsan.com>
> > Tested-by: Govindraj.R <govindraj.raja@ti.com>
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/mach-omap2/irq.c |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> > index 32eeabe..6a964d3 100644
> > --- a/arch/arm/mach-omap2/irq.c
> > +++ b/arch/arm/mach-omap2/irq.c
> > @@ -143,11 +143,21 @@ static void omap_mask_ack_irq(unsigned int irq)
> >  	omap_ack_irq(irq);
> >  }
> >
> > +#ifdef CONFIG_PM
> > +static int omap_set_wake(unsigned int irq, unsigned int on)
> > +{
> > +	return 0;
> > +}
> > +#else
> > +#define omap_set_wake NULL
> > +#endif
> > +
> >  static struct irq_chip omap_irq_chip = {
> >  	.name	= "INTC",
> >  	.ack	= omap_mask_ack_irq,
> >  	.mask	= omap_mask_irq,
> >  	.unmask	= omap_unmask_irq,
> > +	.set_wake = omap_set_wake,
> >  };
> >
> >  static void __init omap_irq_bank_init_one(struct omap_irq_bank *bank)
