From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 2/2] arm: omap: sram: skip the first 16K on OMAP3 HS
Date: Wed, 26 Sep 2012 16:01:17 +0300
Message-ID: <20120926160117.0d36ededcdcb071953286d6f@bitmer.com>
References: <1346253871-5761-1-git-send-email-aaro.koskinen@iki.fi>
	<1346253871-5761-2-git-send-email-aaro.koskinen@iki.fi>
	<CAMQu2gy+4oXgekvqbXDQ9kRr7hmojAZ+RqiZRg97uG1OBo_Ndg@mail.gmail.com>
	<20120830204030.GD1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:47358 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879Ab2IZNBJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Sep 2012 09:01:09 -0400
In-Reply-To: <20120830204030.GD1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org

Hi Aaro

On Thu, 30 Aug 2012 13:40:30 -0700
Tony Lindgren <tony@atomide.com> wrote:

> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [120829 08:30]:
> > On Wed, Aug 29, 2012 at 8:24 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > > In some OMAP3 HS devices (at least Nokia N9 and N950), the public SRAM
> > > seems to conflict with secure portition of SRAM. When booting the 3.6-rc3
> > > kernel (and also earlier) on these devices, the kernel gets tainted with
> > > tons of the following warnings:
> > >
> > >         [    6.894348] In-band Error seen by MPU  at address 0
> > >         [...]
> > >         [    6.894378] WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162
> > >
> > > Fix this by skipping the first 16K of the public SRAM. (Note that the
> > > mapping could not be changed, as it resulted in secure monitor call
> > > failure in save_secure_sram().)
> > >
> > > This will leave 12K SRAM available that should be still sufficient. The
> > > patch has been boot tested with vanilla 3.6-rc3 on N900, N950 and N9.
> > >
> > > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > > ---
> > >  arch/arm/plat-omap/sram.c |    9 ++++++---
> > >  1 files changed, 6 insertions(+), 3 deletions(-)
> > >
> > Looks good.
> > 
> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Thanks applying both into fixes. Aaro, note that now that we're merging
> patches via the arm soc tree, let's use "ARM: OMAP: " for the subject so
> I don't need to fix it up ;)
> 
This issue appears to be in 3.5 too (I didn't check others). Should you commit id of this patch and affected kernel versions to stable?

-- 
Jarkko
