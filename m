From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2 09/11] OMAP: DMA: Implement generic errata handling
Date: Sat, 18 Sep 2010 06:40:52 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402784DCD77@dbde02.ent.ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
	<1282647866-6918-10-git-send-email-manjugk@ti.com>
 <87sk1qtpnu.fsf@deeprootsystems.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A93@dbde02.ent.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402784DC7D5@dbde02.ent.ti.com>
 <4C9317B5.3050308@ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402784DC994@dbde02.ent.ti.com>
 <4C9342FB.30401@ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402784DCB8E@dbde02.ent.ti.com>
 <4C938066.2080908@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40131 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753805Ab0IRBLD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 21:11:03 -0400
In-Reply-To: <4C938066.2080908@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

 

> -----Original Message-----
> From: Cousson, Benoit 
> Sent: Friday, September 17, 2010 8:21 PM
> To: G, Manjunath Kondaiah
> Cc: Kevin Hilman; linux-omap@vger.kernel.org; Shilimkar, Santosh
> Subject: Re: [PATCH v2 09/11] OMAP: DMA: Implement generic 
> errata handling
> 
> On 9/17/2010 1:28 PM, G, Manjunath Kondaiah wrote:
> >> From: Cousson, Benoit
> >> Sent: Friday, September 17, 2010 3:59 PM
> >>
> >> On 9/17/2010 10:09 AM, G, Manjunath Kondaiah wrote:
> >>> Hi Benoit,
> >>>
> >>
> >> <...>
> >>
> >>>>>
> >>>>> I assume you are ok with option #1. Let me know if you have any 
> >>>>> issues/concenrs with above approach. I am in the process of
> >>>> consolidating
> >>>>> all the review comments and addressing all applicable
> >>>> review comments.
> >>>>
> >>>> Not really, the option #1 will still require you to use the oh 
> >>>> pointer, which is supposed to be private to the omap_device.
> >>>>
> >>>> What is still not clear is why and when you need to change the 
> >>>> sysconfig setting.
> >>>
> >>> It is required before stopping DMA chain transfer.
> >>
> >> OK, but why? What happen if you do not do that? Could you 
> please give 
> >> the full errata description to help us understanding?
> >
> > Here is summary of errata description:
> >
> > Software will program DMA to transfer an arbitrary high number of 
> > data, and disable the DMA channel whenever it is sure that all the 
> > data have been read from the source and transferred to the 
> destination.
> >
> > When doing this, software must ensure that the DMA is 
> configured in No 
> > Standby mode (DMAx_OCP_SYSCONFIG.MIDLEMODE = "01"). If this 
> is not the 
> > case, the software may disable the channel when it is 
> transitioning to 
> > standby state. This would cause the DMA internal FIFO 
> pointer not to 
> > be reset correctly and available DMA FIFO space to be artificially 
> > decreased. The consequences range from unnecessary 
> unaligned accesses performed, to complete DMA transfer hanging.
> 
> Thanks for the details.
> 
> That's an interesting bug to handle...
> 
> And what happen if you do not disable the DMA channel at that time?

I don't know since this errata is applicable only for 3430 ES1.0 and
from ES2.0 onwards it is fixed. This was implemented during 3430 post wakeup
period.

> 
> 
> > WORKAROUND
> > The correct procedure to disable a DMA channel before it 
> reaches end of block is:
> 
> That part is not clear: Why do we have to disable a channel 
> before its completion? Cannot we wait?

Not before completion, it is after completion of data transfer and before
disabling channel, sysconfig register needs to be set to standby mode.

> 
> > 1. Set OCP_SYSCONFIG.MIDLEMODE to "01"
> > 2. Disable DMA channel by writing bit DMA4_CCR_i[7].Enable='0'
> > 3. Ensure current DMA transfer is completed by polling the relevant 
> > DMA4_CCR_i[9].RD_ACTIVE/ DMA4_CCR_i[10].WR_ACTIVE bit.
> > 4. Restore OCP_SYSCONFIG.MIDLEMODE to its previous value.
> 
> >>>> Do you have a details explanation? Ideally you should try
> >> to couple
> >>>> the sysconfig change along with pm_runtime / hwmod state
> >> change, then
> >>>> we will be able to handle that smoothly in the framework.
> >>>
> >>> Since channel is already requested(and there is possibility
> >> of other
> >>> channels also used at the same time), using pm_runtime
> >> API's will only
> >>> increase usage count and will not invoke omap_device_enable.
> >>
> >> This is the part that is not clear, and where the full 
> errata should 
> >> help, because if you do have other channel in use, you will not be 
> >> able to do any clock gating anyway, that why changing the 
> sysconfig 
> >> at that time might be useless.
> >
> > Errata description provided.
> >
> >>
> >>>> If you cannot do that, you will need to add an 
> omap_device API as 
> >>>> well.
> >>>
> >>> There is already one such API exists in hwmod layer for
> >> handling this
> >>> type of errata(omap_hwmod_set_slave_idlemode in omap_hwmod.c).
> >>> Above proposal is based on similar implementation.
> >>
> >> Maybe, but this is not enough. In both case you should not use 
> >> directly this API from the driver, so if you want to use 
> that kind of 
> >> approach, you will need the omap_device layer as well.
> >
> > Does that mean, extending omap device layer for modifying sysconfig?
> 
> Yes,

This part is not clear. Is it implementing new API in omap device layer or
extending existing API? 

-Manjunath
