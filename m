From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2] OMAP3: Keypad: Fix failure exit path in probe
Date: Fri, 24 Sep 2010 17:10:51 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027863E252@dbde02.ent.ti.com>
References: <1285069770-4261-1-git-send-email-manjugk@ti.com>
 <0680EC522D0CC943BC586913CF3768C003C21EEB60@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55851 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab0IXLlF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 07:41:05 -0400
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003C21EEB60@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dtor@mail.ru>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>

 

> -----Original Message-----
> From: Datta, Shubhrajyoti 
> Sent: Friday, September 24, 2010 5:00 PM
> To: G, Manjunath Kondaiah; linux-omap@vger.kernel.org
> Cc: linux-input@vger.kernel.org; Dmitry Torokhov; 
> linux-arm-kernel@lists.infradead.org; Tony Lindgren
> Subject: RE: [PATCH v2] OMAP3: Keypad: Fix failure exit path in probe
> 
> 
> 
> > -----Original Message-----
> > From: linux-input-owner@vger.kernel.org [mailto:linux-input- 
> > owner@vger.kernel.org] On Behalf Of G, Manjunath Kondaiah
> > Sent: Tuesday, September 21, 2010 5:20 PM
> > To: linux-omap@vger.kernel.org
> > Cc: linux-input@vger.kernel.org; Dmitry Torokhov; linux-arm- 
> > kernel@lists.infradead.org; Tony Lindgren
> > Subject: [PATCH v2] OMAP3: Keypad: Fix failure exit path in probe
> > 
> > The failure exit paths seems to be wrong in probe function.
> > This patch corrects exit failure paths for error handling cases.
> > 
> > Boot warning incase of request irq failure:
> > 
> > [    1.553985] twl4030_keypad twl4030_keypad: request_irq 
> failed for irq
> > no=369
> > [    1.561157] ------------[ cut here ]------------
> > [    1.565795] WARNING: at kernel/irq/manage.c:899 
> __free_irq+0x88/0x164()
> > [    1.572418] Trying to free already-free IRQ 369
> > [    1.576965] Modules linked in:
> > [    1.580047] [<c00470ec>] (unwind_backtrace+0x0/0xe4) 
> from [<c0078b5c>]
> > (warn_slowpath_common+0x4c/0x64)
> > [    1.589477] [<c0078b5c>] (warn_slowpath_common+0x4c/0x64) from
> > [<c0078bf4>] (warn_slowpath_fmt+0x2c/0x3c)
> > [    1.599060] [<c0078bf4>] (warn_slowpath_fmt+0x2c/0x3c) from
> > [<c00adb90>] (__free_irq+0x88/0x164)
> > [    1.607849] [<c00adb90>] (__free_irq+0x88/0x164) from 
> [<c00adca8>]
> > (free_irq+0x3c/0x5c)
> > [    1.615875] [<c00adca8>] (free_irq+0x3c/0x5c) from [<c043ab2c>]
> > (twl4030_kp_probe+0x308/0x374)
> > [    1.624511] [<c043ab2c>] (twl4030_kp_probe+0x308/0x374) from
> > [<c023c338>] (platform_drv_probe+0x14/0x18)
> > [    1.634033] [<c023c338>] (platform_drv_probe+0x14/0x18) from
> > [<c023b4dc>] (driver_probe_device+0xc8/0x184)
> > [    1.643707] [<c023b4dc>] (driver_probe_device+0xc8/0x184) from
> > [<c023b600>] (__driver_attach+0x68/0x8c)
> > [    1.653106] [<c023b600>] (__driver_attach+0x68/0x8c) 
> from [<c023ad34>]
> > (bus_for_each_dev+0x48/0x74)
> > [    1.662170] [<c023ad34>] (bus_for_each_dev+0x48/0x74) 
> from [<c023a690>]
> > (bus_add_driver+0x9c/0x210)
> > [    1.671234] [<c023a690>] (bus_add_driver+0x9c/0x210) 
> from [<c023b8f8>]
> > (driver_register+0xa8/0x134)
> > [    1.680297] [<c023b8f8>] (driver_register+0xa8/0x134) 
> from [<c0041340>]
> > (do_one_initcall+0x58/0x1b4)
> > [    1.689453] [<c0041340>] (do_one_initcall+0x58/0x1b4) 
> from [<c0008574>]
> > (kernel_init+0x98/0x150)
> > [    1.698272] [<c0008574>] (kernel_init+0x98/0x150) from 
> [<c0042970>]
> > (kernel_thread_exit+0x0/0x8)
> > [    1.707214] ---[ end trace 6559b322ad3cbdfe ]---
> > [    1.718292] twl4030_keypad: probe of twl4030_keypad 
> failed with error -
> > 16
> > 
> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> > Cc: linux-input@vger.kernel.org
> > Cc: Dmitry Torokhov <dtor@mail.ru>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-input@vger.kernel.org
> > Cc: Tony Lindgren <tony@atomide.com>
> > ---
> >  version v1 : initial patch
> >  version v2 : CC'ed input subsystem and arm kernel mailing lists.
> > 
> >  drivers/input/keyboard/twl4030_keypad.c |   10 ++++------
> >  1 files changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/input/keyboard/twl4030_keypad.c
> > b/drivers/input/keyboard/twl4030_keypad.c
> > index fb16b5e..39a9f30 100644
> > --- a/drivers/input/keyboard/twl4030_keypad.c
> > +++ b/drivers/input/keyboard/twl4030_keypad.c
> > @@ -347,8 +347,7 @@ static int __devinit twl4030_kp_probe(struct 
> > platform_device *pdev)
> >  	kp = kzalloc(sizeof(*kp), GFP_KERNEL);
> >  	input = input_allocate_device();
> >  	if (!kp || !input) {
> > -		error = -ENOMEM;
> > -		goto err1;
> Wont you leak memory here ?

Already catpured this comment and dmitry has posted alternate patch at:
http://www.spinics.net/lists/arm-kernel/msg99053.html

-Manjunath