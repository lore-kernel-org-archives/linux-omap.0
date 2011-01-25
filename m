From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 3/5] ARM: twd: Add context save restore support
Date: Tue, 25 Jan 2011 17:50:42 +0530
Message-ID: <a55f0ad81a6885ae79fc6d9cb92e6d05@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
 <1295859080-15259-4-git-send-email-santosh.shilimkar@ti.com>
 <20110124110609.GJ16202@n2100.arm.linux.org.uk> <20110124111114.GA19409@n2100.arm.linux.org.uk>
 <AANLkTikLDamkp9TgnWRESyx4=698D4NXP=W_M9=abfax@mail.gmail.com>
 <20110125112946.GA13300@n2100.arm.linux.org.uk> <b4c0d6db681c3fcfaf5d6f39d1022bb7@mail.gmail.com>
 <20110125114848.GC13300@n2100.arm.linux.org.uk> <8784651c2ea55ec67dabca6037034970@mail.gmail.com>
 <20110125121745.GE13300@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:34155 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751895Ab1AYMUs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 07:20:48 -0500
Received: by fxm17 with SMTP id 17so5255025fxm.20
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 04:20:46 -0800 (PST)
In-Reply-To: <20110125121745.GE13300@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>, Colin Cross <ccross@android.com>, catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Tuesday, January 25, 2011 5:48 PM
> To: Santosh Shilimkar
> Cc: Thomas Gleixner; Colin Cross; catalin.marinas@arm.com;
> linus.ml.walleij@gmail.com; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH 3/5] ARM: twd: Add context save restore support
>

> > > call clockevent set_mode to ensure that the control register is
> > > properly
> > > reset.  I don't think its right to have this kind of knowledge
> > > buried
> > > in each and every clockevent driver.
> > May be Thomas can comment on this.
>
> He was already added on my previous email... we're going round in
> circles.
Sorry about that. Didn't noticed earlier
