From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] arm: omap: sram: skip the first 16K on OMAP3 HS
Date: Thu, 30 Aug 2012 13:40:30 -0700
Message-ID: <20120830204030.GD1303@atomide.com>
References: <1346253871-5761-1-git-send-email-aaro.koskinen@iki.fi>
 <1346253871-5761-2-git-send-email-aaro.koskinen@iki.fi>
 <CAMQu2gy+4oXgekvqbXDQ9kRr7hmojAZ+RqiZRg97uG1OBo_Ndg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:38345 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab2H3Ukf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Aug 2012 16:40:35 -0400
Content-Disposition: inline
In-Reply-To: <CAMQu2gy+4oXgekvqbXDQ9kRr7hmojAZ+RqiZRg97uG1OBo_Ndg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [120829 08:30]:
> On Wed, Aug 29, 2012 at 8:24 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > In some OMAP3 HS devices (at least Nokia N9 and N950), the public SRAM
> > seems to conflict with secure portition of SRAM. When booting the 3.6-rc3
> > kernel (and also earlier) on these devices, the kernel gets tainted with
> > tons of the following warnings:
> >
> >         [    6.894348] In-band Error seen by MPU  at address 0
> >         [...]
> >         [    6.894378] WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162
> >
> > Fix this by skipping the first 16K of the public SRAM. (Note that the
> > mapping could not be changed, as it resulted in secure monitor call
> > failure in save_secure_sram().)
> >
> > This will leave 12K SRAM available that should be still sufficient. The
> > patch has been boot tested with vanilla 3.6-rc3 on N900, N950 and N9.
> >
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > ---
> >  arch/arm/plat-omap/sram.c |    9 ++++++---
> >  1 files changed, 6 insertions(+), 3 deletions(-)
> >
> Looks good.
> 
> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks applying both into fixes. Aaro, note that now that we're merging
patches via the arm soc tree, let's use "ARM: OMAP: " for the subject so
I don't need to fix it up ;)

Tony
