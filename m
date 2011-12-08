From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH 6/6] cbus: retu: implement irq_domain support
Date: Wed, 7 Dec 2011 16:47:30 -0800
Message-ID: <20111208004729.GY31337@atomide.com>
References: <1322056848-1188-1-git-send-email-balbi@ti.com>
 <1322056848-1188-7-git-send-email-balbi@ti.com>
 <20111123165857.GA1839@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41034 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756745Ab1LHArc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Dec 2011 19:47:32 -0500
Content-Disposition: inline
In-Reply-To: <20111123165857.GA1839@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [111123 08:23]:
> Hi,
> 
> On Wed, Nov 23, 2011 at 04:00:48PM +0200, Felipe Balbi wrote:
> > Then, when moving to devicetree, we can list
> > IRQs as 1, 2, 3. It's the only way to have a
> > sane devicetree actually.
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  drivers/cbus/retu.c |   42 +++++++++++++++++++++++++++---------------
> >  1 files changed, 27 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
> > index 25fa405..f25e0a3 100644
> > --- a/drivers/cbus/retu.c
> > +++ b/drivers/cbus/retu.c
> > @@ -25,7 +25,7 @@
> >  
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> > -
> > +#include <linux/irqdomain.h>
> >  #include <linux/slab.h>
> >  #include <linux/kernel.h>
> >  #include <linux/errno.h>
> > @@ -46,6 +46,7 @@ struct retu {
> >  	struct mutex		mutex;
> >  	struct device		*dev;
> >  
> > +	struct irq_domain	irq_domain;
> >  	struct irq_chip		irq_chip;
> >  
> >  	int			irq_base;
> > @@ -199,11 +200,9 @@ static irqreturn_t retu_irq_handler(int irq, void *_retu)
> >  
> >  	while (idr) {
> >  		unsigned long	pending = __ffs(idr);
> > -		unsigned int	irq;
> >  
> >  		idr &= ~BIT(pending);
> > -		irq = pending + retu->irq_base;
> > -		handle_nested_irq(irq);
> > +		handle_nested_irq(pending);
> 
> This is particular, I'm not sure if it's correct. Not sure if we should
> use hw IRQ number of linux IRQ number. A boot test should be enough to
> verify though.

This one does not seem to work, so pushing only the first five. The watchdog
seems to be kicked, so looks like they work.

Tony

[    2.810638] tahvo tahvo: Betty v2.1 found
[    2.819549] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    2.828430] pgd = c0004000
[    2.831420] [00000000] *pgd=00000000
[    2.835205] Internal error: Oops: 5 [#1] SMP
[    2.839691] Modules linked in:
[    2.842926] CPU: 0    Not tainted  (3.2.0-rc2-01686-gf3667721-dirty #231)
[    2.850097] PC is at irq_domain_add+0x10/0x154
[    2.854766] LR is at retu_probe+0x130/0x358
[    2.859161] pc : [<c009dda4>]    lr : [<c0426294>]    psr: 60000013
[    2.859191] sp : c7827eb8  ip : 00010000  fp : c0537458
[    2.871215] r10: c066bf68  r9 : c0bf4418  r8 : 00000068
[    2.876708] r7 : 00000001  r6 : c7a888ec  r5 : c7a888a0  r4 : 00000001
[    2.883575] r3 : 00000000  r2 : c7825400  r1 : c06caf80  r0 : c7a888ec
[    2.890441] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    2.898101] Control: 00c5387d  Table: 80004000  DAC: 00000017
[    2.904144] Process swapper (pid: 1, stack limit = 0xc78262f8)
[    2.910278] Stack: (0xc7827eb8 to 0xc7828000)
[    2.914855] 7ea0:                                                       00000001 c7a888a0
[    2.923461] 7ec0: c7a8890c 00000078 00000068 c0426294 00000000 00000000 c069d090 c066bf68
[    2.932067] 7ee0: c066bf68 c069d090 c0291024 c068f8d0 c0bf25b0 c069d090 c06a7480 c02922ac
[    2.940673] 7f00: c066bf68 c0290ef8 c066bf68 c066bf9c c069d090 c0291024 c068f8d0 00000000
[    2.949279] 7f20: c7abb5e0 c02910b8 00000000 c7827f38 c069d090 c0290724 c781a658 c78641b0
[    2.957885] 7f40: 00000000 c0537458 c061b0ac c069d090 c069d090 c0290034 c0537458 c0233bd0
[    2.966491] 7f60: c061b50c c061b0ac c069d090 00000013 c7826000 c05f6958 00000000 c02916bc
[    2.975097] 7f80: c061b50c c061b0ac c061b5f4 00000013 c7826000 c0008688 c0626880 c009e650
[    2.983703] 7fa0: 0000005f 00000000 c061b5f4 35390013 00000000 00000000 00000000 0000019a
[    2.992309] 7fc0: c067cf94 c061b50c c061b0ac c061b5f4 00000013 00000000 00000000 00000000
[    3.000915] 7fe0: 00000000 c05d0298 00000000 c05d0200 c0014f88 c0014f88 ffffffff ffffff9f
[    3.009521] [<c009dda4>] (irq_domain_add+0x10/0x154) from [<c0426294>] (retu_probe+0x130/0x358)
[    3.018707] [<c0426294>] (retu_probe+0x130/0x358) from [<c02922ac>] (platform_drv_probe+0x18/0x1c)
[    3.028167] [<c02922ac>] (platform_drv_probe+0x18/0x1c) from [<c0290ef8>] (driver_probe_device+0x98/0x1c4)
[    3.038330] [<c0290ef8>] (driver_probe_device+0x98/0x1c4) from [<c02910b8>] (__driver_attach+0x94/0x98)
[    3.048217] [<c02910b8>] (__driver_attach+0x94/0x98) from [<c0290724>] (bus_for_each_dev+0x60/0x8c)
[    3.057739] [<c0290724>] (bus_for_each_dev+0x60/0x8c) from [<c0290034>] (bus_add_driver+0x198/0x260)
[    3.067352] [<c0290034>] (bus_add_driver+0x198/0x260) from [<c02916bc>] (driver_register+0x6c/0x148)
[    3.076965] [<c02916bc>] (driver_register+0x6c/0x148) from [<c0008688>] (do_one_initcall+0x34/0x180)
[    3.086578] [<c0008688>] (do_one_initcall+0x34/0x180) from [<c05d0298>] (kernel_init+0x98/0x144)
[    3.095855] [<c05d0298>] (kernel_init+0x98/0x144) from [<c0014f88>] (kernel_thread_exit+0x0/0x8)
[    3.105102] Code: e92d41f0 e1a06000 e5903014 e5907010 (e5933000) 
[    3.111816] ---[ end trace 539355b8447db297 ]---
[    3.116729] Kernel panic - not syncing: Attempted to kill init!
