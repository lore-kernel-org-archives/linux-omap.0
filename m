From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/6] ARM: Add inline function smp_on_up() for early
 init testing
Date: Wed, 8 Sep 2010 13:26:11 -0700
Message-ID: <20100908202611.GV22507@atomide.com>
References: <20100820120622.GL25742@atomide.com>
 <20100830225527.GC11597@atomide.com>
 <20100902133637.GJ26319@n2100.arm.linux.org.uk>
 <20100902161659.GJ11597@atomide.com>
 <20100902161846.GK11597@atomide.com>
 <20100902170830.GW26319@n2100.arm.linux.org.uk>
 <20100902174244.GU11597@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02CCFE75A2@dbde02.ent.ti.com>
 <AANLkTik2FNBv-72C4L7PxBoMsTENSds-PvbAzxGd-h4y@mail.gmail.com>
 <20100908032642.GL22507@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64281 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141Ab0IHU00 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Sep 2010 16:26:26 -0400
Content-Disposition: inline
In-Reply-To: <20100908032642.GL22507@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Will Deacon <will.deacon@arm.com>

* Tony Lindgren <tony@atomide.com> [100907 20:19]:
> * Bryan Wu <bryan.wu@canonical.com> [100906 03:09]:
> > Tony,
> > 
> > I tried your latest branch: devel-smp-on-unicore, kernel boots up but
> > got lots of WARN_ON fired:
> > 
> > ---
> > ------------[ cut here ]------------
> > [    1.149719] WARNING: at mm/percpu-vm.c:320 pcpu_alloc+0x2fc/0x888()
> > [    1.149780] Modules linked in:
> > [    1.149841] [<c01b34c8>] (unwind_backtrace+0x0/0xe4) from
> > [<c01e939c>] (warn_slowpath_common+0x4c/0x64)
> > [    1.149902] [<c01e939c>] (warn_slowpath_common+0x4c/0x64) from
> > [<c01e93cc>] (warn_slowpath_null+0x18/0x1c)
> > [    1.149993] [<c01e93cc>] (warn_slowpath_null+0x18/0x1c) from
> > [<c0274730>] (pcpu_alloc+0x2fc/0x888)
> > [    1.150085] [<c0274730>] (pcpu_alloc+0x2fc/0x888) from [<c0279578>]
> > (sget+0x198/0x43c)
> > [    1.150146] [<c0279578>] (sget+0x198/0x43c) from [<c0279adc>]
> > (get_sb_ns+0x20/0x90)
> > [    1.150238] [<c0279adc>] (get_sb_ns+0x20/0x90) from [<c02791a4>]
> > (vfs_kern_mount+0x9c/0x18c)
> > [    1.150299] [<c02791a4>] (vfs_kern_mount+0x9c/0x18c) from
> > [<c0022280>] (init_mqueue_fs+0x68/0xc8)
> > [    1.150390] [<c0022280>] (init_mqueue_fs+0x68/0xc8) from
> > [<c01ac5d0>] (do_one_initcall+0xcc/0x1a4)
> > [    1.150451] [<c01ac5d0>] (do_one_initcall+0xcc/0x1a4) from
> > [<c0008760>] (kernel_init+0x148/0x210)
> > [    1.150543] [<c0008760>] (kernel_init+0x148/0x210) from
> > [<c01adcf8>] (kernel_thread_exit+0x0/0x8)
> > [    1.150604] ---[ end trace 1b75b31a2719ed74 ]---
> > ---
> > 
> > It looks like we still missed to set some flag for chuck.
> 
> Yeah I think there's some .config option that needs to be handled
> properly to fix this.

This seems to disappear when CONFIG_LOCK_STAT is disabled,
I wonder why?

Here are my current changes to omap3_defconfig that I use for testing.

Tony
--- a/arch/arm/configs/omap3_defconfig
+++ b/arch/arm/configs/omap3_defconfig
@@ -55,6 +55,7 @@ CONFIG_MACH_OMAP_4430SDP=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_SMP=y
 CONFIG_AEABI=y
 CONFIG_LEDS=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
@@ -218,9 +219,9 @@ CONFIG_USB_DEVICEFS=y
 CONFIG_USB_SUSPEND=y
 # CONFIG_USB_OTG_WHITELIST is not set
 CONFIG_USB_MON=y
-CONFIG_USB_MUSB_HDRC=y
-CONFIG_USB_MUSB_OTG=y
-CONFIG_USB_GADGET_MUSB_HDRC=y
+# CONFIG_USB_MUSB_HDRC is not set
+# CONFIG_USB_MUSB_OTG is not set
+# CONFIG_USB_GADGET_MUSB_HDRC is not set
 CONFIG_USB_MUSB_DEBUG=y
 CONFIG_USB_WDM=y
 CONFIG_USB_STORAGE=y
@@ -276,7 +277,7 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_SCHEDSTATS=y
 CONFIG_TIMER_STATS=y
 CONFIG_PROVE_LOCKING=y
-CONFIG_LOCK_STAT=y
+# CONFIG_LOCK_STAT is not set
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
