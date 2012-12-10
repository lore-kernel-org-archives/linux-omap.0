From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [rtc-linux] [PATCH v3 1/5] rtc: OMAP: Add system pm_power_off
 to rtc driver
Date: Mon, 10 Dec 2012 06:50:00 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA946F6@DBDE01.ent.ti.com>
References: <1353404927-14412-1-git-send-email-anilkumar@ti.com>
 <1353404927-14412-2-git-send-email-anilkumar@ti.com>
 <20121127154239.0efad6d5.akpm@linux-foundation.org>
 <20121128111226.GX3332@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121128111226.GX3332-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: 'Russell King - ARM Linux' <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: "a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org" <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, "sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Colin Foe-Parker <colin.foeparker-L+YfUVVR8+RBDgjK7y7TUQ@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org" <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org" <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 28, 2012 at 16:42:26, Russell King - ARM Linux wrote:
> On Tue, Nov 27, 2012 at 03:42:39PM -0800, Andrew Morton wrote:
> > > +	/* Do not allow to execute any other task */
> > > +	spin_lock_irqsave(&lock, flags);
> > > +	while (1);
> > 
> > I suspect this doesn't do what you want it to do.
> > 
> > Firstly, please provide adequate code comments here so that code
> > readers do not also need to be mind readers.
> > 
> > If you want to stop this CPU dead in its tracks (why?) then
> > 
> > 	local_irq_disable();
> > 	while (1)
> > 		;		/* Note correct code layout */
> > 
> > will do it.  But it means that the NMI watchdog (if present) will come
> > along and whack the machine in the head a few seconds later.  And this
> > does nothing to stop other CPUs.
> > 
> > But not being a mind reader, I'm really at a loss to suggest what
> > should be done here.  

Here intention is to disable all interrupts between rtc power_off request
till system actually went to power off mode, max 2 seconds based on when
the AM335x RTC alarm2 expires. The idea was that since the system is
going to shutdown, it is better to not process any more interrupts.

> It's hooking into the pm_power_off hook, which is called from kernel/sys.c
> via arch code.  We will have already stopped all other CPUs at this point.
> 
> Why there's that while (1) there I don't know; when pm_power_off is not
> hooked, we don't do anything like that - and what will happen in that
> case is we'll return all the way back to sys_reboot(), which will call
> do_exit(0) on us.

When testing with v3.7-rc7, I saw the following BUG() triggered when I did
not use a while(1). Logs below.

Before calling do_exit(0), there is a reboot_mutex lock that is taken in
reboot syscall. do_exit() function is , checking for any locks held by the
processor and if yes then it is printing a BUG_ON from print_held_locks_bug() function along with the locks held information.
Even though the BUG triggers, the system is going to power off because
The hardware has been triggered.

==== (log)
[root@arago /]# poweroff
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system poweroff
[   32.125900] Disabling non-boot CPUs ...
[   32.130155] Power down.
[   32.132741] System will go to power_off state in approx. 2 secs
[   32.139994]
[   32.141575] =====================================
[   32.146564] [ BUG: lock held at task exit time! ]
[   32.151522] 3.7.0-rc7-00015-g3f8bbe0 #32 Not tainted
[   32.156721] -------------------------------------
[   32.161676] init/622 is exiting with locks still held!
[   32.167085] 1 lock held by init/622:
[   32.170831]  #0:  (reboot_mutex){+.+...}, at: [<c0056fb8>] sys_reboot+0xf4/0x1e8
[   32.178679]
[   32.178679] stack backtrace:
[   32.183305] [<c001af24>] (unwind_backtrace+0x0/0xf0) from [<c0046978>] (do_exit+0x488/0x7e8)
[   32.192183] [<c0046978>] (do_exit+0x488/0x7e8) from [<c0056fc4>] (sys_reboot+0x100/0x1e8)
[   32.200797] [<c0056fc4>] (sys_reboot+0x100/0x1e8) from [<c0013320>] (ret_fast_syscall+0x0/0x3c)
=====

It is not clear to me where reboot_mutex should have been unlocked before
debug_check_no_locks_held() is called in do_exit()?

Note: In latest linux-next tip I am *not* seeing this error. I have not
bisected yet to see what fixed this. Since with latest linux-next I am
not seeing an issue, I will remove spinlock and the while(1). Hope that
will make the patch more acceptable.

> I don't see a problem with that, and I don't see why we need to spin
> (without any power saving too) waiting for some event.  If we've called
> sys_reboot with LINUX_REBOOT_CMD_POWER_OFF, we'd better have already
> killed most of userspace off by that time anyway.
> 

I did a search of various power-off implementations in *arch/arm*.

Those that use a while(1):
=========================
arch/arm/mach-at91/board-gsia18s.c
arch/arm/mach-at91/setup.c doesn't
arch/arm/mach-cns3xxx/cns3420vb.c
arch/arm/mach-iop32x/glantank.c
arch/arm/mach-iop32x/iq31244.c
arch/arm/mach-iop32x/n2100.c local_irq_disable() and then a while(1)
arch/arm/mach-kirkwood/board-lsxl.c

arch/arm/mach-highbank/highbank.c does while(1) cpu_do_idle()

Those that don't have a while(1):
================================
arch/arm/mach-imx/mach-mx31moboard.c
arch/arm/mach-iop32x/em7210.c

Doesn't have a while(1) but setting a gpio so presumably kills the system immediately:
===========
arch/arm/mach-ixp4xx/dsmg600-setup.c  
arch/arm/mach-ixp4xx/nas100d-setup.c
arch/arm/mach-ixp4xx/nslu2-setup.c
arch/arm/mach-kirkwood/board-dnskw.c
arch/arm/mach-kirkwood/board-ib62x0.c
arch/arm/mach-kirkwood/board-dnskw.c
arch/arm/mach-kirkwood/board-ib62x0.c
arch/arm/mach-kirkwood/d2net_v2-setup.c
arch/arm/mach-kirkwood/netspace_v2-setup.c
arch/arm/mach-kirkwood/netxbig_v2-setup.c
arch/arm/mach-kirkwood/t5325-setup.c
arch/arm/mach-orion5x/dns323-setup.c

arch/arm/mach-vexpress/v2m.c take a spinlock, not sure when it will shut down

arch/arm/mach-kirkwood/board-ts219.c sends a character to PIC and potentially returns...
arch/arm/mach-kirkwood/ts219-setup.c

So it seems there is a plethora of variations of how this is implemented
(probably driven also by hardware differences). Since what I mentioned
above works for me (in linux-next), I will go ahead and submit at v4.
Let me know if there are objections.

Thanks
AnilKumar
