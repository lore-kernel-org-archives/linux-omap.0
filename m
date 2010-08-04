From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 04/11] OMAP3: DMA: HWMOD: Add hwmod data structures
Date: Wed, 4 Aug 2010 15:45:49 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C641E1E6@dbde02.ent.ti.com>
References: <1280397545-27323-1-git-send-email-manjugk@ti.com>
	<1280397545-27323-5-git-send-email-manjugk@ti.com>
 <87eiefnyvs.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402708B48E3@dbde02.ent.ti.com>
 <4C593C11.5040600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47718 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932177Ab0HDKP6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 06:15:58 -0400
In-Reply-To: <4C593C11.5040600@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "Sawant, Anand" <sawant@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Varadarajan, Charulatha" <charu@ti.com>

> -----Original Message-----
> From: Cousson, Benoit
> Sent: Wednesday, August 04, 2010 3:38 PM
> To: G, Manjunath Kondaiah
> Cc: Kevin Hilman; linux-omap@vger.kernel.org; Paul Walmsley; Tony
> Lindgren; Sawant, Anand; Shilimkar, Santosh; Nayak, Rajendra; Basak,
> Partha; Varadarajan, Charulatha
> Subject: Re: [PATCH 04/11] OMAP3: DMA: HWMOD: Add hwmod data structures
> 
> On 8/4/2010 2:35 AM, G, Manjunath Kondaiah wrote:
> > Kevin,
> >
> >> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> >> Sent: Wednesday, August 04, 2010 3:27 AM
> >>
> >> Manjunatha GK<manjugk@ti.com>  writes:
> >>
> >>> This patch adds OMAP3 DMA hwmod structures.
> >>>
> >>> Signed-off-by: Manjunatha GK<manjugk@ti.com>
> >>
> >> [...]
> >>
> >>> +static struct omap_hwmod omap3xxx_dma_system_hwmod = {
> >>> +	.name		= "dma",
> >>> +	.class		=&omap3xxx_dma_hwmod_class,
> >>> +	.mpu_irqs	= omap3xxx_dma_system_irqs,
> >>> +	.mpu_irqs_cnt	= ARRAY_SIZE(omap3xxx_dma_system_irqs),
> >>> +	.main_clk	= "l3_div_ck",
> >>> +	.prcm = {
> >>> +		.omap2 = {
> >>> +			/* .clkctrl_reg = NULL, */
> >>> +		},
> >>> +	},
> >>
> >> Has this been tested?  Without valid fields here the hwmod
> >> will never be
> >> enabled.
> >
> > This patch series has been tested on both omap3 and omap4. I didn't find
> > any entries for DMA module in prcm-common.h(for assigning .module_bit
> etc)
> > hence I commented this for clarification.
> 
> There is no explicit PRCM control for the SDMA. You can just access the
> standby status and change the sysconfig idle and standby settings.
> It uses the L3 interface clock as functional clock.
> You should still use HWMOD_NO_IDLEST status to prevent the enable to
> crash.
> 
> In your case, I think that you are probably never explicitly enabling or
> disabling the dma device due to the library kind of API and the fact
> that the HW is managing is automatically, isn't it?
> 
> We had the same kind of discussion for the hwspinlock. Since these IPs
> are using interface clock as a functional clock, there is no need to
> explicitly enable them. But we should, otherwise we have no way to track
> the usage of this IP and potentially to enable the power domain that
> contains these IP.
> 
> Each time a dma channel is requested, you should call the
> pm_runtime_get, and pm_runtime_put() when the channel is not needed
> anymore.
> 
Request call can get called on multiple channels.
So at the time of request a channel, other channels might be already 
in use. So logically " pm_runtime_put" should only be done if
reserved channels are 0
