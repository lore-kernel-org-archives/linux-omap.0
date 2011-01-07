From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: 4430SDP boot failure - solved + SPI bug fix
Date: Fri, 7 Jan 2011 19:19:49 +0000
Message-ID: <20110107191949.GV1198@n2100.arm.linux.org.uk>
References: <86f60bc5418ca1d3e87db960e5e2c48f@mail.gmail.com> <729152acd9ee0c3e3e3cd505e84f8865@mail.gmail.com> <20110107125132.GM1198@n2100.arm.linux.org.uk> <48cbfb338be4d33a8a19e070430d015b@mail.gmail.com> <20110107142432.GO1198@n2100.arm.linux.org.uk> <c71399f20609c539b8c335344963253f@mail.gmail.com> <20110107154920.GQ1198@n2100.arm.linux.org.uk> <b52c0ce136053d3185debccaa3a9d252@mail.gmail.com> <20110107185250.GT1198@n2100.arm.linux.org.uk> <04b3a28e12c18714cce8c15c1645cc2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58065 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030Ab1AGTT7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 14:19:59 -0500
Content-Disposition: inline
In-Reply-To: <04b3a28e12c18714cce8c15c1645cc2d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Sat, Jan 08, 2011 at 12:35:38AM +0530, Santosh Shilimkar wrote:
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Sent: Saturday, January 08, 2011 12:23 AM
> > To: Santosh Shilimkar
> > Cc: linux-omap@vger.kernel.org; Tony Lindgren
> > Subject: Re: 4430SDP boot failure - solved + SPI bug fix
> >
> > On Fri, Jan 07, 2011 at 11:55:10PM +0530, Santosh Shilimkar wrote:
> > > > And, with one ARM errata disabled, the kernel finally boots.  So
> > the
> > > > "X-Loader hangs" message means that we did something that non-
> > secure
> > > > mode prevented us from doing.
> > > >
> > > Actually it's not. The error message is quite misleading.
> > Basically in
> > > x-loader exception handlers are setup and all these handlers
> > report
> > > same message ("X-Loader hangs"). This should be fixed so that it
> > can
> > > report more meaningful info like data abort, prefetch abort etc.
> > >
> > > Till the vector relocation in the kernel exceptions are not set up
> > > so code jumps to already installed exceptions in the x-loader and
> > > hence the messege.
> >
> > I disagree with your "actually it's not".  It was errata 742230,
> > which
> > requires access to the CP15, c15, c0, 1 register (a diagnostic
> > register)
> > which I bet provokes an undefined instruction trap from non-secure
> > mode.
> >
> 742230 errata workaround is not implemented in the x-loader so I
> can surely say it's not the secure violation.

Precisely.  So when we directly read, modify and write this diagnostic
register in the non-secure world during kernel boot, we end up faulting.
Comment those instructions out, we don't get a fault, and the kernel
boots normally.
