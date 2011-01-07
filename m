From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: 4430SDP boot failure - solved + SPI bug fix
Date: Sat, 8 Jan 2011 00:58:49 +0530
Message-ID: <f3d46b4669eca2d370275ce730d8ce8a@mail.gmail.com>
References: <86f60bc5418ca1d3e87db960e5e2c48f@mail.gmail.com>
 <729152acd9ee0c3e3e3cd505e84f8865@mail.gmail.com> <20110107125132.GM1198@n2100.arm.linux.org.uk>
 <48cbfb338be4d33a8a19e070430d015b@mail.gmail.com> <20110107142432.GO1198@n2100.arm.linux.org.uk>
 <c71399f20609c539b8c335344963253f@mail.gmail.com> <20110107154920.GQ1198@n2100.arm.linux.org.uk>
 <b52c0ce136053d3185debccaa3a9d252@mail.gmail.com> <20110107185250.GT1198@n2100.arm.linux.org.uk>
 <04b3a28e12c18714cce8c15c1645cc2d@mail.gmail.com> <20110107191949.GV1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:35723 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753934Ab1AGT2w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 14:28:52 -0500
Received: by mail-bw0-f53.google.com with SMTP id 12so12231951bwg.26
        for <linux-omap@vger.kernel.org>; Fri, 07 Jan 2011 11:28:51 -0800 (PST)
In-Reply-To: <20110107191949.GV1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Saturday, January 08, 2011 12:50 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; Tony Lindgren
> Subject: Re: 4430SDP boot failure - solved + SPI bug fix
>
> On Sat, Jan 08, 2011 at 12:35:38AM +0530, Santosh Shilimkar wrote:
> > > -----Original Message-----
> > > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > > Sent: Saturday, January 08, 2011 12:23 AM
> > > To: Santosh Shilimkar
> > > Cc: linux-omap@vger.kernel.org; Tony Lindgren
> > > Subject: Re: 4430SDP boot failure - solved + SPI bug fix
> > >
> > > On Fri, Jan 07, 2011 at 11:55:10PM +0530, Santosh Shilimkar
> wrote:
> > > > > And, with one ARM errata disabled, the kernel finally boots.
> So
> > > the
> > > > > "X-Loader hangs" message means that we did something that
> non-
> > > secure
> > > > > mode prevented us from doing.
> > > > >
> > > > Actually it's not. The error message is quite misleading.
> > > Basically in
> > > > x-loader exception handlers are setup and all these handlers
> > > report
> > > > same message ("X-Loader hangs"). This should be fixed so that
> it
> > > can
> > > > report more meaningful info like data abort, prefetch abort
> etc.
> > > >
> > > > Till the vector relocation in the kernel exceptions are not
> set up
> > > > so code jumps to already installed exceptions in the x-loader
> and
> > > > hence the messege.
> > >
> > > I disagree with your "actually it's not".  It was errata 742230,
> > > which
> > > requires access to the CP15, c15, c0, 1 register (a diagnostic
> > > register)
> > > which I bet provokes an undefined instruction trap from non-
> secure
> > > mode.
> > >
> > 742230 errata workaround is not implemented in the x-loader so I
> > can surely say it's not the secure violation.
>
> Precisely.  So when we directly read, modify and write this
> diagnostic
> register in the non-secure world during kernel boot, we end up
> faulting.
> Comment those instructions out, we don't get a fault, and the kernel
> boots normally.

I understand now. Was confused last time.

So your custom build did have this errata
CONFIG_ARM_ERRATA_742230 where there is an access
to diagnostic register which is not accessible on OMAP4
from non-secure side.

Thanks for clarification.

Regards,
Santosh
