From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 4/5] musb: use system DMA for unaligned buffers on RTL
 >= 1.8
Date: Fri, 14 May 2010 10:09:57 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E4054AC@dbde02.ent.ti.com>
References: <1273664979-493-1-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-2-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-3-git-send-email-ajay.gupta@ti.com>
 <1273664979-493-4-git-send-email-ajay.gupta@ti.com>
 <4BEAAA8A.1000003@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E7394044E405072@dbde02.ent.ti.com>
 <4BEAC268.1080601@ru.mvista.com> <20100512175543.GD3285@gandalf>
 <19F8576C6E063C45BE387C64729E7394044E40516A@dbde02.ent.ti.com>
 <20100513194311.GA19318@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41241 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751658Ab0ENEkM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 00:40:12 -0400
In-Reply-To: <20100513194311.GA19318@gandalf>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "me@felipebalbi.com" <me@felipebalbi.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Subbrathnam, Swaminathan" <swami.iyer@ti.com>

Hi,
> On Thu, May 13, 2010 at 09:44:11AM +0530, Gupta, Ajay Kumar wrote:
> > Hi,
> > > -----Original Message-----
> > > From: Felipe Balbi [mailto:me@felipebalbi.com]
> > > Sent: Wednesday, May 12, 2010 11:26 PM
> > > To: Sergei Shtylyov
> > > Cc: Gupta, Ajay Kumar; linux-usb@vger.kernel.org; linux-
> > > omap@vger.kernel.org
> > > Subject: Re: [PATCH 4/5] musb: use system DMA for unaligned buffers on
> RTL
> > > >= 1.8
> > >
> > > On Wed, May 12, 2010 at 06:59:52PM +0400, Sergei Shtylyov wrote:
> > > >    Better wrap your stuff into #ifdef OMAP, I think...
> > >
> > > please don't, better to use the bounce buffer... It would work on
> > > blackfin, davinci and omap...
> >
> > Just working is not enough. We need to think of performance and cpu
> > loading as well.
> 
> allocating a bounce buffer doesn't take long and you can still use
> mentor DMA to transfer the data.

But there is a memcpy involved right? It will use cpu and thus would be
hitting on performance, cpu loading and power consumption. Instead why
not use other available system resources (system dma)to do this job.

I understand, some platform may not support/have system dma then they can surely use bounce buffer or use PIO mode.

There was another workaround proposed earlier which was using 'memmove'
(similar to memcpy) that was badly affecting cpu loading. I was hardly getting 50Mbits/sec of throughput with 100% loading. Instead when I tried system DMA, numbers went up to 90Mbits/sec  with a cpu loading of 50%.

I think we must use system DMA for this issue and also have bounce buffer
Or PIO fallback mechanism in place for platforms not supporting system DMA.

Regards,
Ajay
> 
> --
> balbi
