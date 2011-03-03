From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 04/17] omap4: pm: Add CPUx OFF mode support
Date: Thu, 3 Mar 2011 21:44:23 +0530
Message-ID: <f53cb17bd85faa93de4367e6db88e1e2@mail.gmail.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-5-git-send-email-santosh.shilimkar@ti.com>
 <87wrkh5fz4.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:47946 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755670Ab1CCQOZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 11:14:25 -0500
Received: by mail-qy0-f182.google.com with SMTP id 27so1077624qyk.13
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 08:14:24 -0800 (PST)
In-reply-to: <87wrkh5fz4.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Thursday, March 03, 2011 3:43 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 04/17] omap4: pm: Add CPUx OFF mode support
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > This patch adds the CPU0 and CPU1 off mode support. CPUX close
> switch
>
> s/CPUX/CPUx/
>
> > retention (CSWR) is not supported by hardware design.
> >
> > The CPUx OFF mode isn't supported on OMAP4430 ES1.0
> >
> > CPUx sleep code is common for hotplug, suspend and cpuilde.
>
> s/cpuilde/CPUidle/
>
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Reviewed-by: Kevin Hilman <khilman@ti.com>
>
> > ---
Fixed all the comments on this patch.

[....]

> > +++ b/arch/arm/mach-omap2/sleep44xx.S
[....]

>
> I didn't do a detailed review of the below assembly since you're
> much more knowlegable there than me.
>
> However, will the assembly code here work in Thumb-2 mode?  Dave
> Martin
> has been working on that for OMAP3, but we should make sure the
> OMAP4 stuff is Thumb-2 ready out of the box.
>
The code as such builds for THUMB2 as I tried last time. At least
I have tried not to break it for THUMB2 anywhere.

Regards,
Santosh
