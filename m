From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2] OMAP3: PM: PRCM interrupt: Fix warning "MPU wakeup
 but no wakeup sources"
Date: Thu, 16 Dec 2010 11:17:03 +0100
Message-ID: <20101216111703.7df0498c@surf>
References: <1290175355-32444-1-git-send-email-ext-madhusudhan.1.gowda@nokia.com>
	<8739qxe0dz.fsf@deeprootsystems.com>
	<090FE800A758CA439B2752C082AC3DEF0666E2AB0C@NOK-EUMSG-06.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:39122 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab0LPKRN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Dec 2010 05:17:13 -0500
In-Reply-To: <090FE800A758CA439B2752C082AC3DEF0666E2AB0C@NOK-EUMSG-06.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-madhusudhan.1.gowda@nokia.com
Cc: khilman@deeprootsystems.com, t-petazzoni@ti.com, linux-omap@vger.kernel.org, paul@pwsan.com

Hello Gowda, Hello Kevin,

On Mon, 22 Nov 2010 11:26:25 +0100
<ext-madhusudhan.1.gowda@nokia.com> wrote:

> I did verify Thomas Petazzoni's patch -   [PATCH] omap: prcm: switch
> to a chained IRQ handler mechanism, and I have below questions or
> comments.
> 
> 1. I see for each WKUP_ST or IO_ST interrupt the
> _prcm_int_handle_wakeup handler is getting called 2 times which
> impacts on performance. printk("irq:%d,%d\n",irq,c); just before
> returning from the handler shows. [  221.966308] irq wkst:377,2
> [  221.968597] irq wkst:377,0
> 
> I see, the code checking the below warning  is removed, won't it be
> good to retain this check ? WARN(c == 0, "prcm: WARNING: PRCM
> indicated " "MPU wakeup but no wakeup sources "
>                "are marked\n");
> 
> Also need to address the corner case issue,  for which I submitted
> the patch fix. [  222.002563] irq wkst:368,3 
> [  222.004913] irq iost:377,0 

I am not sure to fully understand what's going on with thse WKUP_ST and
IO_ST interrupts. Here is what I see :

 * When going to retention (i.e after echo 0
   > /debug/pm_debug/enable_off_mode), what happens is

    - PRCM main interrupt handler is called, it sees pending events at
      0x201 (which means WKUP_ST and IO_ST)

    - it calls the interrupt handler for WKUP_ST, which happens to be
      _prcm_int_handle_wakeup, which says that "c" is 2.

    - it acks the WKUP_ST interrupt by clearing the bit in the PRCM
      status register

    - it calls the interrupt handler for IO_ST, which happens to also
      be _prcm_int_handle_wakeup, which says that "c" is 0

    - it acks the IO_ST interrupt by clearing the corresponding bit in
      the PRCM status register

    - the PRCM main interrupt handler checks again the PRCM status
      register, and sees pending events to be 0x1 (which means WKUP_ST)

    - it calls again the WKUP_ST interrupt handler, which is
      _prcm_int_handle_wakeup, which says that "c" is 0

    - it acks the WKUP_ST interrupt by clearing the bit in the PRCM
      status register

    - the PRCM main interrupt handler checks again the PRCM status
      register, and sees pending events to be 0x0, and returns.

 * When going to off (i.e after echo 1
   > /debug/pm_debug/enable_off_mode), what happens is :

    - PRCM main interrupt handler is called, it sees pending events at
      0x200 (which means IO_ST)

    - it calls the interrupt handler for IO_ST, which happens to also
      be _prcm_int_handle_wakeup, which says that "c" is 1

    - it acks the IO_ST interrupt by clearing the corresponding bit in
      the PRCM status register

    - the PRCM main interrupt handler checks again the PRCM status
      register, and sees pending events to be 0x200 (which means
      IO_ST)

    - it calls the interrupt handler for IO_ST, which happens to also
      be _prcm_int_handle_wakeup, which says that "c" is 0

    - it acks the IO_ST interrupt by clearing the corresponding bit in
      the PRCM status register

    - the PRCM main interrupt handler checks again the PRCM status
      register, and sees pending events to be 0x0, and returns.

See the end of my e-mail for a trace.

This raises a few questions :

 * Why is the set of PRCM events different in the OFF and the retention
   case ?

 * Why do we need to ack the WKUP_ST event (in the first case) and the
   IO_ST event (in the second case) twice ?

 * The _prcm_int_handle_wakeup() was written to be called *once* for a
   given PRCM interrupt with IO_WT or WKUP_ST enabled. Now, it gets
   called twice since they are separate interrupt handlers for those
   two events. Is this a problem ? Should we rewrite
   _prcm_int_handle_wakeup() in two separate functions, one taking into
   account the IO_ST event and the other one taking into account the
   WKUP_ST event ?

Thanks for your input,

Thomas

/ # echo 0 > /debug/pm_debug/enable_off_mode 
/ # echo mem > /sys/power/state 
[  507.936614] PM: Syncing filesystems ... done.
[  507.951629] Freezing user space processes ... (elapsed 0.01 seconds) done.
[  507.976470] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
[  508.009368] Suspending console(s) (use no_console_suspend to debug)
[  508.140106] PM: suspend of devices complete after 119.263 msecs
[  508.143951] omap_device: omap_i2c.1: new worst case deactivate latency 0: 183105
[  508.144195] PM: late suspend of devices complete after 4.089 msecs
[  508.144287] Disabling non-boot CPUs ...
[  508.144927] omap_device: omap_uart.2: new worst case deactivate latency 0: 30517
[  508.508300] omap_device: omap_uart.0: new worst case activate latency 0: 61035
[  508.508453] Successfully put all powerdomains to target state
[  508.508636] prcm_irq_handler pending=0x201
[  508.508666] calling irq 368
[  508.508666] prcm_irq_mask 368
[  508.508697] prcm_irq_ack 368
[  508.508728] _prcm_int_handle_wakeup 368 : 2
[  508.508728] prcm_irq_unmask 368
[  508.508758] calling irq 377
[  508.508758] prcm_irq_mask 377
[  508.508789] prcm_irq_ack 377
[  508.508819] _prcm_int_handle_wakeup 377 : 0
[  508.508819] prcm_irq_unmask 377
[  508.508850] prcm_irq_handler pending=0x1
[  508.508850] calling irq 368
[  508.508880] prcm_irq_mask 368
[  508.508880] prcm_irq_ack 368
[  508.508911] _prcm_int_handle_wakeup 368 : 0
[  508.508911] prcm_irq_unmask 368
[  508.508941] prcm_irq_handler pending=0x0
[  508.510955] PM: early resume of devices complete after 1.953 msecs
[  508.804077] PM: resume of devices complete after 292.754 msecs
[  508.930664] Restarting tasks ... done.
/ # echo 1 > /debug/pm_debug/enable_off_mode 
/ # echo mem > /sys/power/state 
[  515.526428] PM: Syncing filesystems ... done.
[  515.531677] Freezing user space processes ... (elapsed 0.02 seconds) done.
[  515.559417] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.
[  515.591400] Suspending console(s) (use no_console_suspend to debug)
[  515.714813] PM: suspend of devices complete after 112.121 msecs
[  515.718627] PM: late suspend of devices complete after 3.753 msecs
[  515.718658] Disabling non-boot CPUs ...
[  516.187805] Successfully put all powerdomains to target state
[  516.187988] prcm_irq_handler pending=0x200
[  516.188018] calling irq 377
[  516.188018] prcm_irq_mask 377
[  516.188049] prcm_irq_ack 377
[  516.188079] _prcm_int_handle_wakeup 377 : 1
[  516.188079] prcm_irq_unmask 377
[  516.188110] prcm_irq_handler pending=0x200
[  516.188110] calling irq 377
[  516.188140] prcm_irq_mask 377
[  516.188140] prcm_irq_ack 377
[  516.188171] _prcm_int_handle_wakeup 377 : 0
[  516.188201] prcm_irq_unmask 377
[  516.188201] prcm_irq_handler pending=0x0
[  516.190338] PM: early resume of devices complete after 2.075 msecs
[  516.483612] PM: resume of devices complete after 292.999 msecs
[  516.570281] Restarting tasks ... done.


-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
