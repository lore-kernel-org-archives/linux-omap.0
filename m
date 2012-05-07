From: "Mohammed, Afzal" <afzal@ti.com>
Subject: RE: [PATCH v4-alt 3/6] ARM: OMAP3: hwmod data: add gpmc
Date: Mon, 7 May 2012 11:12:16 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E987188@DBDE01.ent.ti.com>
References: <cover.1335941443.git.afzal@ti.com>
 <99ffbbcc634022ed3c781c37e03989f1d898003e.1335941444.git.afzal@ti.com>
 <alpine.DEB.2.00.1205051949290.20926@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46184 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598Ab2EGLMV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 07:12:21 -0400
In-Reply-To: <alpine.DEB.2.00.1205051949290.20926@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Paul,

On Sun, May 06, 2012 at 07:34:07, Paul Walmsley wrote:
> Did you notice the warning that this patch generates on boot?
> 
> omap_hwmod: gpmc: cannot be enabled for reset (3)
> 
> The HWMOD_NO_IDLEST hwmod flag is needed, since there is no GPMC IDLEST 
> bit.

Yes, putting that flag makes warning go away, Thanks

> 
> ...
> 
> Also, the OMAP2xxx GPMC hwmod data is missing.  It can be combined 
> with this patch.

In v4, it has been sent as two patches - one for 3xxx & one for 2xxx,
do you want to combine both ?

> > +static struct omap_hwmod omap3xxx_gpmc_hwmod = {
> > +	.name		= "gpmc",
> > +	.class		= &omap3xxx_gpmc_hwmod_class,
> > +	.clkdm_name	= "l3_init_clkdm",
> > +	.mpu_irqs	= omap3xxx_gpmc_irqs,
> > +	.main_clk	= "gpmc_fck",
> > +	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
> > +};
> 
> Is there some reason why you are setting the HWMOD_INIT_NO_RESET flag 
> here?  Seems to me that the kernel should not rely on the bootloader GPMC 
> configuration, but should use a configuration from the board file or DT.


Major reason was that there are some boards that rely on bootloader
settings, eg. kernel does not do any setting for smsc911x. I did not
want to break those, at least it causes problem with omap3evm, see below

Another was that this was created based on,
"eb42b5d ARM: OMAP4: hwmod data: add GPMC" and an internal one for AM335X,
Both had HWMOD_INIT_NO_RESET flag.

Removing it causes multiple problems, one is that CS0 is valid after reset
of module, with base address starting from zero, which causes requesting
resource failure for CS0, with the way it is currently coded (GPMC resource
starts from 1MB). Even upon skipping CS0, kernel oops at seemingly unrelated
location as follows, probably due to gpmc reset, as bootloader configured
values are modified to reset value. Omap3 evm uses smsc911x.

[    2.660095] WARNING: at /home/afzal/dev/SA/src/-kernel/kernel/lockdep.c:956 __bfs+0x1f0/0x230()
[    2.669708] Modules linked in:
[    2.672973] [<c001a568>] (unwind_backtrace+0x0/0xf0) from [<c003cfec>] (warn_slowpath_common+0x4c/0x64)
[    2.682891] [<c003cfec>] (warn_slowpath_common+0x4c/0x64) from [<c003d020>] (warn_slowpath_null+0x1c/0x24)
[    2.693084] [<c003d020>] (warn_slowpath_null+0x1c/0x24) from [<c00827d0>] (__bfs+0x1f0/0x230)
[    2.702087] [<c00827d0>] (__bfs+0x1f0/0x230) from [<c0084a74>] (check_usage_forwards+0x60/0x10c)
[    2.711364] [<c0084a74>] (check_usage_forwards+0x60/0x10c) from [<c00857b8>] (mark_lock+0x1bc/0x64c)
[    2.720977] [<c00857b8>] (mark_lock+0x1bc/0x64c) from [<c0086634>] (__lock_acquire+0x9ec/0x1c64)
[    2.730255] [<c0086634>] (__lock_acquire+0x9ec/0x1c64) from [<c0087e3c>] (lock_acquire+0x98/0x100)
[    2.739715] [<c0087e3c>] (lock_acquire+0x98/0x100) from [<c004a5f8>] (run_timer_softirq+0x13c/0x378)
[    2.749359] [<c004a5f8>] (run_timer_softirq+0x13c/0x378) from [<c00438b0>] (__do_softirq+0xc8/0x1f4)
[    2.759002] [<c00438b0>] (__do_softirq+0xc8/0x1f4) from [<c0043e64>] (irq_exit+0x90/0x98)
[    2.767639] [<c0043e64>] (irq_exit+0x90/0x98) from [<c00141dc>] (handle_IRQ+0x50/0xac)
[    2.776000] [<c00141dc>] (handle_IRQ+0x50/0xac) from [<c00086fc>] (omap3_intc_handle_irq+0x54/0x68)
[    2.785552] [<c00086fc>] (omap3_intc_handle_irq+0x54/0x68) from [<c0425724>] (__irq_svc+0x4


Another issue on OMAP3EVM is the detection of evm revision based on phy id,
by reading hardcoded address, 0x2c000000. It had to be skipped to reach till
above mentioned.

Regards
Afzal
