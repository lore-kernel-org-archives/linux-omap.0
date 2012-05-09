From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] ARM: OMAP2+: irq: Increase no of supported interrupts
 to 128
Date: Wed, 9 May 2012 09:58:12 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA1C06F@DBDE01.ent.ti.com>
References: <1336486679-15892-1-git-send-email-hvaibhav@ti.com>
 <87lil2o6u1.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34737 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663Ab2EIKSl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 06:18:41 -0400
In-Reply-To: <87lil2o6u1.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Mohammed, Afzal" <afzal@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

On Wed, May 09, 2012 at 00:09:34, Hilman, Kevin wrote:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> > With addition to TI81XX, AM33XX family of devices, the number
> > of interrupts supported has increased to 128, compared to 96.
> > The current implementation for irq handling is hardcoded to use
> > 96 interrupts (with 3 register-sets to handle), this patch cleanups
> > the code, to increase maximum number of interrupts support
> > to 128, with dynamic detection of no of registers required for
> > handling all interrupts.
> >
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > ---
> > Ideally, we should use dynamic allocation to allocate memory
> > for registers/arrays, 
> 
> Yes.
> 

Thanks Kevin, I will put this activity in my TODO list.

> > may be too much cleanup for this patch,
> 
> There is no such thing as too much cleanup.  ;)  
> And the INTC is in need of it, IMO.
> 

Indeed it is in need of cleanup...


> > so as of now restricting to minimal changes to fit devices
> > like, am33xx/ti81xx.
> 
> Then someone else will have to do the cleanup later.  It would be
> greatly appreciated if you could do the necessary cleanup in order to
> cleanly add support for more SoCs.  Yes, we probably should've insisted
> when support for TI81xx was added, but that one slipped in under the
> radar.
> 

Yeah, I understand. As I said I will put this activity in my TODO list.

> For starters, the notion of a banks this code is a rather messed up and
> needs a cleanup.  A bank is supposed to be a group of 32 interrupts, 
> and the INTC is made up of 3 (or 4) banks.   However, the current
> code creates a single "bank" of 96 (or 128) interrupts.  
> 
> It also confuses what registers are part of the bank and what are global
> to the INTC.  This confusion is both in init and in context save/restore.
> 
> IMO, to clean this up, first the notion of banks needs to be fixed in
> that code there is a distinction between what acts on banks and what
> works on the whole INTC.
> 
> Then, the init/alloc should be done dynamically based on the number of
> interrupts passed to omap_init_irq()
> 

Kevin,
Let me finish up with am33xx baseport upstream activity which is currently 
going on at full swing, then next thing I will pick up is this code cleanup.

I still feel, this is still a valid cleanup patch, and can be merged, as it 
is required/used when we do major cleanup.

Thanks,
Vaibhav
