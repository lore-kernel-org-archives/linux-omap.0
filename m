From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP build now completely broken in latest arm-soc
Date: Mon, 26 Nov 2012 09:37:07 -0800
Message-ID: <20121126173707.GI5279@atomide.com>
References: <20121125093704.GV3332@n2100.arm.linux.org.uk>
 <CAOesGMgvGxfghFbyki7aXE8dVbAA7QQP6nwBKhzHftngGRi0Tw@mail.gmail.com>
 <20121125140701.GW3332@n2100.arm.linux.org.uk>
 <CAOesGMiv374Bhpt=Hu5o7E+eUGhX8R4w=1DLgxzzE6ieRUva=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:40260 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756708Ab2KZRhN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Nov 2012 12:37:13 -0500
Content-Disposition: inline
In-Reply-To: <CAOesGMiv374Bhpt=Hu5o7E+eUGhX8R4w=1DLgxzzE6ieRUva=w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap <linux-omap@vger.kernel.org>, arm@kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

* Olof Johansson <olof@lixom.net> [121125 22:02]:
> Hi,
> 
> On Sun, Nov 25, 2012 at 6:07 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Sun, Nov 25, 2012 at 05:56:58AM -0800, Olof Johansson wrote:
> >> Hi,
> >>
> >> On Sun, Nov 25, 2012 at 1:37 AM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > Not much more to say...
> >> >
> >> > arch/arm/plat-omap/i2c.c:35:1: error: expected identifier or '(' before '<<' token
> >>
> >> Hmm. In for-next, line 35 is a blank line.
> >>
> >> Could this be because of a merge conflict in your local version? This
> >> is one of the files that has conflicts with mainline right now; I'll
> >> look to see if we can resolve those in our tree later today.
> >
> > Hmm, it looks like a merge conflict which didn't get fixed up... and
> > looking at it, it's beyond what I'd call trivial to fix.
> >
> > So I'll shut down the build system until that can be resolved properly;
> > as OMAP is effectively unbuildable there's not much point it running the
> > builds.
> 
> Tony, Tomi,
> 
> I've taken a stab at resolving these conflicts. They seem to come from
> the cleanups combined with fixes that went upstream, and it seems like
> we want to stick to the arm-soc versions for most of the conflicts.
> 
> I've pushed a merge of 3.7-rc7 into next/cleanup (and for-next) of
> arm-soc, can you please check and see if this is the correct
> resolution? As far as I can tell it is, but a double-check would be
> appreciated.
> 
> Conflicts were in:
> 
>         arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>         arch/arm/plat-omap/i2c.c
>         drivers/video/omap2/dss/dss.c
> 
> The hwmod data was trivial (include files). i2c was a little hairier,
> a revert in mainline -- I presumed we're still good with our arm-soc
> contents so I stuck close to what we had there. The DSS change seems
> to be done completely differently in mainline, i.e. the surrounding
> code is different to what we have in arm-soc today, and it looks like
> the bugfix (3630-specific stuff) is taken care of in the version we
> had. So I stuck to that.

Looks like that i2c revert probably needs a fixup patch as we still
don't have the prerequisites merged. Anyways, the fixup should be done
in mach-omap2/i2c.c instead of plat-omap/i2c.c, so your merge fix
is OK.
 
> But, please speak up ASAP if the above doesn't look correct, since we
> want to fix it up before we merge much on top.

That's good, thanks.

Regards,

Tony
