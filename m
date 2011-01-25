From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 4/5] ARM: scu: Move register defines to header file
Date: Tue, 25 Jan 2011 18:09:09 +0530
Message-ID: <f2acc7ff1572649863feb3cb0f6c79ee@mail.gmail.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
 <1295859080-15259-5-git-send-email-santosh.shilimkar@ti.com>
 <20110125114635.GB13300@n2100.arm.linux.org.uk> <236d45e400a960cc3b32db538b3a79ae@mail.gmail.com>
 <20110125121655.GD13300@n2100.arm.linux.org.uk> <20110125122924.GF13300@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:51537 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750831Ab1AYMjL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Jan 2011 07:39:11 -0500
Received: by mail-fx0-f45.google.com with SMTP id 12so5616704fxm.32
        for <linux-omap@vger.kernel.org>; Tue, 25 Jan 2011 04:39:10 -0800 (PST)
In-Reply-To: <20110125122924.GF13300@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: catalin.marinas@arm.com, linus.ml.walleij@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ccross@android.com

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Tuesday, January 25, 2011 5:59 PM
> To: Santosh Shilimkar
> Cc: catalin.marinas@arm.com; linus.ml.walleij@gmail.com; linux-
> omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> ccross@android.com
> Subject: Re: [PATCH 4/5] ARM: scu: Move register defines to header
> file
>
> I did mean to include the updated patch:

As said in other email will work towards this.

>
>  arch/arm/include/asm/smp_scu.h |    5 +++++
>  arch/arm/kernel/smp_scu.c      |   23 +++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 0 deletions(-)
>
[....]

>
> If we need a SMC call, that should happen within the spinlock'd
> region via
> a function pointer which the platform can set.  I can't code that
> into this
> patch until I know what the SMC call requires as arguments (cpu
> number,
> power state, or new register value, or mask and bits to set?)

No problem. Will update SMC stuff if needed.

Regards,
Santosh
