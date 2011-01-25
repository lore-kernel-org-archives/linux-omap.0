From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Tue, 25 Jan 2011 19:17:12 +0530
Message-ID: <27075ff850379ad574590bcb0a3587e8@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
 <1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com>
 <20110125114635.GB13300@n2100.arm.linux.org.uk> <236d45e400a960cc3b32db538b3a79ae@mail.gmail.com>
 <20110125121655.GD13300@n2100.arm.linux.org.uk> <4534e82bf14eeea9f96769df760df5ae@mail.gmail.com>
 <20110125134128.GJ13300@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:50420 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753045Ab1AYNrO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 08:47:14 -0500
Received: by mail-fx0-f41.google.com with SMTP id 12so5649761fxm.14
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 05:47:13 -0800 (PST)
In-Reply-To: <20110125134128.GJ13300@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, ccross@android.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Tuesday, January 25, 2011 7:11 PM
> To: Santosh Shilimkar
> Cc: linux-arm-kernel@lists.infradead.org; catalin.marinas@arm.com;
> ccross@android.com; linus.ml.walleij@gmail.com; linux-
> omap@vger.kernel.org
> Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header
> file
>
> On Tue, Jan 25, 2011 at 06:06:27PM +0530, Santosh Shilimkar wrote:
> > Ok. I missed some information my last email.
> > The SCU power status programming is used to take CPU in/out
> > of coherency as an alternative to SMP bit. We don't
> > have an access to SMP bit on OMAP4. ARM has already
> > confirmed SCU programming is same as SMP bit enable/disable.
> >
> > I don't know how safe is to use spin lock when one CPU is
> > goes out of coherency after programming the power state. The
> > spin lock release may not even be visible to other CPU.
> > The programming happens from IDLE or suspend where the
>
> BTW, presumably we should be flushing the caches/tlbs before setting
> the CPU power register to a non-normal setting?
>
Yes but only till inner shareability domain. i.e L1
L2 will be flushed after this. This is one more issue
where the current L2 cache current APIs(use locks) becomes
not so suitable.

> I'll wait until there's more information available (such as an
> example
> implementation.)
