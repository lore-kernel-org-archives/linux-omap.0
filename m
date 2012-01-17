From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: OMAP3 L2/outer cache enabled in kernel (after being disabled
 by uBoot)?
Date: Tue, 17 Jan 2012 13:39:18 +0000
Message-ID: <20120117133918.GE11475@arm.com>
References: <WC20120116100344.4204CC@terrafix.co.uk>
 <CAMQu2gw4H=m1QA+ucORYsO_LZR8Sj57=+jwmrkHu_7sdCzhN8g@mail.gmail.com>
 <20120116105949.GG16726@n2100.arm.linux.org.uk>
 <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
 <20120116131329.GA928@n2100.arm.linux.org.uk>
 <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk>
 <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com>
 <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:42007 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753395Ab2AQNju (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Jan 2012 08:39:50 -0500
Content-Disposition: inline
In-Reply-To: <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Aneesh V <aneesh@ti.com>, Joe Woodward <jw@terrafix.co.uk>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 17, 2012 at 12:40:54PM +0000, Shilimkar, Santosh wrote:
> On Tue, Jan 17, 2012 at 1:27 PM, Aneesh V <aneesh@ti.com> wrote:
> > Hi Catalin,
> >
> >
> > On Tuesday 17 January 2012 05:41 PM, Catalin Marinas wrote:
> >>
> >> On Tue, Jan 17, 2012 at 08:54:44AM +0000, Joe Woodward wrote:
> >>>
> >>> So, is the upshot of this that the kernel isn't going to be in a
> >>> position to enable the L2/outer cache on OMAP3 (due to the need for
> >>> hacky/unmaintainable code)?
> >>>
> >>> Hence the bootloader/uBoot had better leave it enabled...
> >>
> >> It could but the Linux decompressor needs to be aware and either flush
> >> the L2 (more difficult as it doesn't have all the device information) or
> >
> > Cortex-A8 is aware of L2$ and can flush it, isn't it?
> >
> >> set the page table attributes to outer non-cacheable (TEX[2:0] = 0b100).
> >
> > If the above is right, this is not needed right?
>
> Well the L2 can be configured as inner or outer, so above
> alone won't work.
> 
> Boot-loader disabling L2 cache ( all caches)  is still right thing
> and that's what kernel expect.
> 
> Since the early kernel code can't be patches for A8, may be
> delaying L2 enabled would work.

Ah, I missed the fact that the L2 is an inner cache on OMAP3+A8. In this
case, I would argue to just leave it enabled since as long as the MMU is
off it won't be accessed. Why does U-Boot need to disable the L2 (I
suspect via some auxiliary control register)?

> But then on A15, we are back to square one since there is no
> control to turn ON/OFF l2 cache.

Well, it's an inner cache, it gets disabled/enabled via the SCTLR.M bit
as is the L1 cache. It does not need to be disabled independently.

> On A15 infact there are other CP15 registers which needs to be set
> before MMU is enabled to have best configuration.

Yes, there are, and my view is that it is up to the platform firmware to
set things right.

-- 
Catalin
