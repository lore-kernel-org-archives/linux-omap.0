From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/5] ARM: twd: Add context save restore support
Date: Tue, 25 Jan 2011 17:38:49 +0530
Message-ID: <8784651c2ea55ec67dabca6037034970@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
 <1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com>
 <20110124110609.GJ16202@n2100.arm.linux.org.uk> <20110124111114.GA19409@n2100.arm.linux.org.uk>
 <AANLkTikLDamkp9TgnWRESyx4=698D4NXP=W_M9=abfax@mail.gmail.com>
 <20110125112946.GA13300@n2100.arm.linux.org.uk> <b4c0d6db681c3fcfaf5d6f39d1022bb7@mail.gmail.com>
 <20110125114848.GC13300@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:36266 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752486Ab1AYMIw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 07:08:52 -0500
Received: by mail-fx0-f50.google.com with SMTP id 14so5595239fxm.9
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 04:08:51 -0800 (PST)
In-Reply-To: <20110125114848.GC13300@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>
Cc: Colin Cross <ccross@android.com>, catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Looping Thomas G
> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Tuesday, January 25, 2011 5:19 PM
> To: Santosh Shilimkar
> Cc: Colin Cross; catalin.marinas@arm.com;
> linus.ml.walleij@gmail.com; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
>
> On Tue, Jan 25, 2011 at 05:10:37PM +0530, Santosh Shilimkar wrote:
> > As I was suspecting the one shot mode wouldn't work it. Collin
> > just confirmed it.
> > To make it fully work it needs control register save restore.
> > And that can be managed within TWD library so that every platform
> > doesn't have to bother of calling it from their idle code.
> >
> > Do you prefer that as a separate patch or I can post a new version
> > in which can add your fix + per cpu control register shadowing ?
>
> I said earlier:
> | The next question is can we teach the generic time infrastructure
> about
> | this so we don't have to modify every clock event driver for it?
> We
> | really need to get away from having this kind of knowledge buried
> down
> | in the lowest levels of every driver.
>
> IOW, if we go into a PM idle mode, when we come back out we need to
> call clockevent set_mode to ensure that the control register is
> properly
> reset.  I don't think its right to have this kind of knowledge
> buried
> in each and every clockevent driver.
May be Thomas can comment on this.

Regards,
Santosh
