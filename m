From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Kernel hang on OMAP3 based Beagle board, RTC issue?
Date: Tue, 15 Jul 2008 01:49:34 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0807150131580.467@utopia.booyaka.com>
References: <486BDD2A.5070500@googlemail.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BB6621C@dbde02.ent.ti.com> <AF70E37B-038B-4117-B69F-B2BCD9EFF6AA@student.utwente.nl> <486F21F6.7020208@googlemail.com> <5A47E75E594F054BAF48C5E4FC4B92AB022BFE73A2@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB022BFE73BE@dbde02.ent.ti.com> <87vdzi2ln0.fsf@trdhcp146196.ntc.nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB022C0F9263@dbde02.ent.ti.com> <746A464E-F4E2-467A-9D01-DFE2AB3BB02E@student.utwente.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36928 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754AbYGOHtf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Jul 2008 03:49:35 -0400
In-Reply-To: <746A464E-F4E2-467A-9D01-DFE2AB3BB02E@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, =?ISO-8859-15?Q?H=F6gander_Jouni?= <jouni.hogander@nokia.com>, Dirk Behme <dirk.behme@googlemail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 15 Jul 2008, Koen Kooi wrote:

> > > --- a/arch/arm/mach-omap2/pm34xx.c
> > > +++ b/arch/arm/mach-omap2/pm34xx.c
> > > @@ -380,11 +380,11 @@ int __init omap3_pm_init(void)
> > >               goto err1;
> > >       }
> > > 
> > > -       ret = pwrdm_for_each(pwrdms_setup);
> > > -       if (ret) {
> > > -               printk(KERN_ERR "Failed to setup powerdomains\n");
> > > -               goto err2;
> > > -       }
> > > +/*     ret = pwrdm_for_each(pwrdms_setup); */
> > > +/*     if (ret) { */
> > > +/*             printk(KERN_ERR "Failed to setup powerdomains\n"); */
> > > +/*             goto err2; */
> > > +/*     } */
> > > 
> > >       mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
> > >       if (mpu_pwrdm == NULL) {
> > 
> > With this change, the hang does not happene. Applied this patch on the
> > current
> > linux-omap tree.
> > 
> > Thanks for the patch. It fixes the hang for now. I'm not sure why the hang
> > happens, but could it be because the SDP uses ttyS0 by default as the
> > console while the Beagle is on ttyS2?
> 
> With that patch I still get the same behaviour:
> 
> serial console freezes, but responds to sysrq

Likewise on Beagle rev B4 here. Patching the PM code as above does not 
seem to make a difference; nor leaving out the RTC.

The failure mode that seems to recur here is that a userspace binary will 
exit, but no shell prompt is displayed afterwards.  Once wedged, Sysrq-T 
provided some interesting output, included below.  uart_wait_until_sent() ?
That doesn't seem right.

N.B., on the Beagle here, TWL4030 IRQ handling has to be commented out to 
accomplish anything useful.  Otherwise the console drowns in "TWL4030 
module irq 368 is disabled but can't be masked!" messages on at least 90% 
of reboots.  This is in drivers/i2c/chips/twl4030-core.c, commenting out 
the lines underneath:

   /* install an irq handler to demultiplex the TWL4030 interrupt */   

Have not yet had a chance to study the problem - could be a TWL4030 GPIO 
interrupt issue?


- Paul


<6>sh            Ssh            S c024cf70  c024cf70     0   362      1
    0   362      1
[<c024cd0c>] [<c024cd0c>] (schedule+0x0/0x2a0) (schedule+0x0/0x2a0) from 
[<c024d1d0>] from [<c024d1d0>] (schedule_timeout+0x90/0xb8)
(schedule_timeout+0x90/0xb8)
[<c024d140>] [<c024d140>] (schedule_timeout+0x0/0xb8) 
(schedule_timeout+0x0/0xb8) from [<c024d24c>] from [<c024d24c>] 
(schedule_timeout_interruptible+0x28/0x2c)
(schedule_timeout_interruptible+0x28/0x2c)
 r7:c03257b8 r7:c03257b8 r6:00000001 r6:00000001 r5:ffff888e r5:ffff888e 
r4:c7d9e000 r4:c7d9e000

[<c024d224>] [<c024d224>] (schedule_timeout_interruptible+0x0/0x2c) 
(schedule_timeout_interruptible+0x0/0x2c) from [<c0053fe4>] from 
[<c0053fe4>] (msleep_interruptible+0x28/0x58)
(msleep_interruptible+0x28/0x58)
[<c0053fbc>] [<c0053fbc>] (msleep_interruptible+0x0/0x58) 
(msleep_interruptible+0x0/0x58) from [<c017c56c>] from [<c017c56c>] 
(uart_wait_until_sent+0x94/0xf8)
(uart_wait_until_sent+0x94/0xf8)
 r5:ffff888e r5:ffff888e r4:c7d9e000 r4:c7d9e000

[<c017c4d8>] [<c017c4d8>] (uart_wait_until_sent+0x0/0xf8) 
(uart_wait_until_sent+0x0/0xf8) from [<c016e0cc>] from [<c016e0cc>] 
(tty_wait_until_sent+0xe4/0xf4)
(tty_wait_until_sent+0xe4/0xf4)
 r7:c7d9e000 r7:c7d9e000 r6:7fffffff r6:7fffffff r5:c7d6b640 r5:c7d6b640 
r4:c7d9fd30 r4:c7d9fd30

[<c016dfe8>] [<c016dfe8>] (tty_wait_until_sent+0x0/0xf4) 
(tty_wait_until_sent+0x0/0xf4) from [<c016e2b4>] from [<c016e2b4>] 
(set_termios+0x1d8/0x4cc)
(set_termios+0x1d8/0x4cc)
[<c016e0dc>] [<c016e0dc>] (set_termios+0x0/0x4cc) (set_termios+0x0/0x4cc) 
from [<c016e7f4>] from [<c016e7f4>] (tty_mode_ioctl+0x24c/0x3d8)
(tty_mode_ioctl+0x24c/0x3d8)
[<c016e5a8>] [<c016e5a8>] (tty_mode_ioctl+0x0/0x3d8) 
(tty_mode_ioctl+0x0/0x3d8) from [<c016ebd8>] from [<c016ebd8>] 
(n_tty_ioctl+0x258/0x268)
(n_tty_ioctl+0x258/0x268)
 r7:c7c6f740 r7:c7c6f740 r6:beaac3fc r6:beaac3fc r5:beaac3fc r5:beaac3fc 
r4:c7d80400 r4:c7d80400

[<c016e980>] [<c016e980>] (n_tty_ioctl+0x0/0x268) (n_tty_ioctl+0x0/0x268) 
from [<c016b4d4>] from [<c016b4d4>] (tty_ioctl+0xda8/0xe04)
(tty_ioctl+0xda8/0xe04)
 r7:c7c6f740 r7:c7c6f740 r6:c7d80400 r6:c7d80400 r5:beaac3fc r5:beaac3fc 
r4:00005403 r4:00005403

[<c016a72c>] [<c016a72c>] (tty_ioctl+0x0/0xe04) (tty_ioctl+0x0/0xe04) from 
[<c009fa80>] from [<c009fa80>] (vfs_ioctl+0x34/0x78)
(vfs_ioctl+0x34/0x78)
[<c009fa4c>] [<c009fa4c>] (vfs_ioctl+0x0/0x78) (vfs_ioctl+0x0/0x78) from 
[<c009fd34>] from [<c009fd34>] (do_vfs_ioctl+0x270/0x280)
(do_vfs_ioctl+0x270/0x280)
 r5:beaac3fc r5:beaac3fc r4:c7c6f740 r4:c7c6f740

[<c009fac4>] [<c009fac4>] (do_vfs_ioctl+0x0/0x280) 
(do_vfs_ioctl+0x0/0x280) from [<c009fd84>] from [<c009fd84>] 
(sys_ioctl+0x40/0x64)
(sys_ioctl+0x40/0x64)
 r7:c7c6f740 r7:c7c6f740 r6:00005403 r6:00005403 r5:beaac3fc r5:beaac3fc 
r4:00000000 r4:00000000

[<c009fd44>] [<c009fd44>] (sys_ioctl+0x0/0x64) (sys_ioctl+0x0/0x64) from 
[<c0027a40>] from [<c0027a40>] (ret_fast_syscall+0x0/0x2c)
(ret_fast_syscall+0x0/0x2c)
 r7:00000036 r7:00000036 r6:beaac488 r6:beaac488 r5:00000000 r5:00000000 
r4:00000a31 r4:00000a31

