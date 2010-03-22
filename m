From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] AM35x: Add musb support
Date: Mon, 22 Mar 2010 16:51:29 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DE0E730@dbde02.ent.ti.com>
References: <1267017495-17548-1-git-send-email-ajay.gupta@ti.com>,<4BA4CCF3.4060500@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E7394044DCC5F29@dbde02.ent.ti.com>
 <4BA5FBF6.8010102@mvista.com>
 <19F8576C6E063C45BE387C64729E7394044DE0E5E6@dbde02.ent.ti.com>
 <4BA742ED.6080004@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E7394044DE0E71B@dbde02.ent.ti.com>
 <4BA74E48.30109@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43807 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837Ab0CVLVg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 07:21:36 -0400
In-Reply-To: <4BA74E48.30109@ru.mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

Hi,
> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
> Sent: Monday, March 22, 2010 4:33 PM
> To: Gupta, Ajay Kumar
> Cc: Sergei Shtylyov; linux-omap@vger.kernel.org; linux-usb@vger.kernel.org
> Subject: Re: [PATCH] AM35x: Add musb support
> 
> Gupta, Ajay Kumar wrote:
> 
> >>>>> I have not added CPPI4.1 DMA  specific register here..
> >>>>>
> >>>>>
> >>>>>
> >>>>    Ah. Then they're not compatible with DA8xx anyway...
> >>>>
> >>>>
> >>> We could make it compatible with some change as done at,
> >>> http://arago-project.org/git/people/?p=sriram/ti-psp-
> >>>
> >> omap.git;a=commitdiff;h=2ecce9529bd56c32997e0b2cbe84f7727ba5b217
> >>
> >> I'm not sure where cppi41_dma.c gets the definitions for
> >> USB_[RT]X_MODE_REG...
> >>
> >
> > It is being used from plat/usb.h.
> >
> 
>    I haven't found where it's included.

It's from cppi41_dma.h.

-Ajay
> 
> WBR, Sergei

