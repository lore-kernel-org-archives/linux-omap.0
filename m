From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Way operationcan
 cause data corruption
Date: Mon, 28 Feb 2011 18:17:07 +0530
Message-ID: <69dd173e3c7b4d02ef50ceaa19b2343a@mail.gmail.com>
References: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com>
 <1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com>
 <20110227120021.GA15314@n2100.arm.linux.org.uk> <20110228101351.GA30781@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:45232 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753789Ab1B1MrK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 07:47:10 -0500
Received: by qyg14 with SMTP id 14so3134832qyg.12
        for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 04:47:09 -0800 (PST)
In-Reply-To: <20110228101351.GA30781@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: tony@atomide.com, catalin.marinas@arm.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Monday, February 28, 2011 3:44 PM
> To: Santosh Shilimkar
> Cc: tony@atomide.com; catalin.marinas@arm.com; linux-
> omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Way
> operationcan cause data corruption
>
> On Sun, Feb 27, 2011 at 12:00:21PM +0000, Russell King - ARM Linux
> wrote:
> > > +#else
> > > +/* Optimised out for non-errata case */
> > > +static inline void debug_writel(unsigned long val)
> > > +{
> > >  }
> >
> > #define l2x0_set_debug	NULL
> >
> > > +#endif
>
> I notice you got rid of the inline function.  Have you tried
> building this without the errata enabled?

I accidently dropped the inline function while
incorporating the comment from you. :(

Fixed it. Updated version # 6770/1

Regards,
Santosh
