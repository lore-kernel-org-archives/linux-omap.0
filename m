From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions:
 watchdog, UART, i2c
Date: Wed, 6 Oct 2010 00:18:25 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF3B2F3B@dbde02.ent.ti.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
 <20100928201844.GI3117@atomide.com> <87tyl8rxwp.fsf@deeprootsystems.com>
 <20100930021819.GD3117@atomide.com> <877hi3i9cp.fsf@deeprootsystems.com>
 <87pqvvgt8g.fsf@deeprootsystems.com> <877hi3gqq7.fsf@deeprootsystems.com>
 <0680EC522D0CC943BC586913CF3768C003FF2DAF74@dbde02.ent.ti.com>
 <4CA60F88.4020303@ti.com>
 <alpine.DEB.2.00.1010042359170.13816@utopia.booyaka.com>
  <0680EC522D0CC943BC586913CF3768C003FF3B2E05@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1010051056540.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53963 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843Ab0JESsf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 14:48:35 -0400
In-Reply-To: <alpine.DEB.2.00.1010051056540.13816@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>



> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Tuesday, October 05, 2010 10:28 PM
> To: Nayak, Rajendra
> Cc: Cousson, Benoit; Kevin Hilman; Tony Lindgren; linux-omap@vger.kernel.org; Varadarajan, Charulatha; Raja,
> Govindraj
> Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
> 
> On Tue, 5 Oct 2010, Nayak, Rajendra wrote:
> 
> > So looks like the issue with i2c on n800 isn't really because of additional
> > delay needed after a clock enable, but related to the omap_readl/writel's
> > done on the 16bit i2c registers as I was suspecting earlier.
> >
> > The below patch fixes the n800 issue for me. My mailer might mess up the alignment
> > hence attaching it too.
> >
> > >From af9733f2e63a16b446635d52015e05d631f0788f Mon Sep 17 00:00:00 2001
> > From: Rajendra Nayak <rnayak@ti.com>
> > Date: Tue, 5 Oct 2010 16:36:30 +0530
> > Subject: [PATCH] OMAP: hwmod: Handle modules with 16bit registers
> >
> > Some modules which have 16bit registers can cause imprecise
> > aborts if a __raw_readl/writel is used to read/write 32 bits.
> >
> > Add an additional flag to identify modules which have such
> > hard requirement, and handle it in the hwmod framework.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> 
> Nice work, looks good to me.  Hopefully we won't need that enable_delay
> patch!

Yeah, unless Benoit thinks it's needed for OMAP4 where he's seeing some
issues with FDIF and ISS.

> 
> I was initially concerned that your patch tried to store a 32-bit quantity
> into a 16-bit register.  But I guess the cast to unsigned short in
> the __raw_writew macro takes care of this:
> 
>                 __raw_writew(v, oh->_mpu_rt_va + reg_offs);
>       28:       16ff3070        uxthne  r3, r0
>       2c:       118130b2        strhne  r3, [r1, r2]
> 
> gcc for some reason decides to zero-extend it first, but that is not your
> bug to fix.
> 
> This patch is targeted for merging via 2.6.37 via Tony's tree.
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> 
> - Paul
