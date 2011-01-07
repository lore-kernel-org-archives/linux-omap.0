From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: 4430SDP boot failure - solved + SPI bug fix
Date: Sat, 8 Jan 2011 00:35:38 +0530
Message-ID: <04b3a28e12c18714cce8c15c1645cc2d@mail.gmail.com>
References: <d540408e2df154cf13932e79d3a11ceb@mail.gmail.com>
 <20110107092800.GJ1198@n2100.arm.linux.org.uk> <86f60bc5418ca1d3e87db960e5e2c48f@mail.gmail.com>
 <729152acd9ee0c3e3e3cd505e84f8865@mail.gmail.com> <20110107125132.GM1198@n2100.arm.linux.org.uk>
 <48cbfb338be4d33a8a19e070430d015b@mail.gmail.com> <20110107142432.GO1198@n2100.arm.linux.org.uk>
 <c71399f20609c539b8c335344963253f@mail.gmail.com> <20110107154920.GQ1198@n2100.arm.linux.org.uk>
 <b52c0ce136053d3185debccaa3a9d252@mail.gmail.com> <20110107185250.GT1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:42390 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754693Ab1AGTFl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 14:05:41 -0500
Received: by mail-bw0-f47.google.com with SMTP id 10so16565305bwz.34
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 11:05:40 -0800 (PST)
In-Reply-To: <20110107185250.GT1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Saturday, January 08, 2011 12:23 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; Tony Lindgren
> Subject: Re: 4430SDP boot failure - solved + SPI bug fix
>
> On Fri, Jan 07, 2011 at 11:55:10PM +0530, Santosh Shilimkar wrote:
> > > And, with one ARM errata disabled, the kernel finally boots.  So
> the
> > > "X-Loader hangs" message means that we did something that non-
> secure
> > > mode prevented us from doing.
> > >
> > Actually it's not. The error message is quite misleading.
> Basically in
> > x-loader exception handlers are setup and all these handlers
> report
> > same message ("X-Loader hangs"). This should be fixed so that it
> can
> > report more meaningful info like data abort, prefetch abort etc.
> >
> > Till the vector relocation in the kernel exceptions are not set up
> > so code jumps to already installed exceptions in the x-loader and
> > hence the messege.
>
> I disagree with your "actually it's not".  It was errata 742230,
> which
> requires access to the CP15, c15, c0, 1 register (a diagnostic
> register)
> which I bet provokes an undefined instruction trap from non-secure
> mode.
>
742230 errata workaround is not implemented in the x-loader so I
can surely say it's not the secure violation.

He is the x-loader source tree.
http://dev.omapzoom.org/?p=bootloader/x-loader.git;a=shortlog;h=refs/heads
/omap4_dev

Even simple things like if DDR is not configured correctly or not
Stable, code/data access takes abort which lands up in the "X-loader
hang messege"

> Hence, the reason it vectored to the X-loader was because we tried
> to
> do something in the non-secure mode which we're prevented from
> doing.
My suspect was clock configurations on the older boot loaders were
Incomplete that might have lead to issue since now more drivers are
getting enabled in newer kernels.
