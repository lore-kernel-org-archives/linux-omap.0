From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: RE: [GIT PULL] for testing: OMAP hwmod driver conversions:
 watchdog, UART, i2c
Date: Wed, 6 Oct 2010 00:23:52 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C003FF3B2F3D@dbde02.ent.ti.com>
References: <8762xpenf8.fsf@deeprootsystems.com>
	<20100928201844.GI3117@atomide.com>	<87tyl8rxwp.fsf@deeprootsystems.com>
	<20100930021819.GD3117@atomide.com>	<877hi3i9cp.fsf@deeprootsystems.com>
	<87pqvvgt8g.fsf@deeprootsystems.com>	<877hi3gqq7.fsf@deeprootsystems.com>
	<0680EC522D0CC943BC586913CF3768C003FF2DAF74@dbde02.ent.ti.com>
	<4CA60F88.4020303@ti.com>
	<alpine.DEB.2.00.1010042359170.13816@utopia.booyaka.com>
	<0680EC522D0CC943BC586913CF3768C003FF3B2E05@dbde02.ent.ti.com>
 <874od0tvu3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54679 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481Ab0JESyB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 14:54:01 -0400
In-Reply-To: <874od0tvu3.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charulatha" <charu@ti.com>, "Raja, Govindraj" <govindraj.raja@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, October 05, 2010 10:34 PM
> To: Nayak, Rajendra
> Cc: Paul Walmsley; Cousson, Benoit; Tony Lindgren; linux-omap@vger.kernel.org; Varadarajan, Charulatha; Raja,
> Govindraj
> Subject: Re: [GIT PULL] for testing: OMAP hwmod driver conversions: watchdog, UART, i2c
> 
> "Nayak, Rajendra" <rnayak@ti.com> writes:
> 
> > <snip>..
> >
> >> >
> >> > Below is an untested patch to provide some mechanism to deal with this --
> >> > I'd appreciate everyone's comments on this, particularly the comments in
> >> > the patch code on how to deal with this problem.
> >>
> >> Hi Paul,
> >>
> >> I'll test this patch to see if it solves the issue seen with i2c on n800.
> >
> > Hi Paul, Benoit, Kevin,
> >
> > So looks like the issue with i2c on n800 isn't really because of additional
> > delay needed after a clock enable, but related to the omap_readl/writel's
> > done on the 16bit i2c registers as I was suspecting earlier.
> >
> > The below patch fixes the n800 issue for me. My mailer might mess up the alignment
> > hence attaching it too.
> >
> > From af9733f2e63a16b446635d52015e05d631f0788f Mon Sep 17 00:00:00 2001
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
> Can you also send a corresponding patch to the i2c hwmod data.
Hi Kevin,

Ok, I'll repost the original patch which adds the omap2 hwmod data with
these flags added for omap2420. Does that sound fine?

Regards,
Rajendra

> 
> I'll rebase the rest of the series against current l-o master, and maybe
> we can still get this in for .37.
> 
> Kevin
