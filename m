From: "Syed Mohammed, Khasim" <khasim@ti.com>
Subject: RE: [RFC] Port TI DSP BRIDGE for a new dedicated branch in
	linux-omap
Date: Fri, 15 Aug 2008 23:02:11 +0530
Message-ID: <0680EC522D0CC943BC586913CF3768C00208C16543@dbde02.ent.ti.com>
References: <1218782824-12596-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <5d5443650808150052l29bf0830u60ff256b51d53066@mail.gmail.com>
 <94a0d4530808150247g52c1e258v5b922e01fb5154bc@mail.gmail.com>
 <20080815.133409.81509340.Hiroshi.DOYU@nokia.com>
 <20080815112112.GB16840@atomide.com>
 <13B9B4C6EF24D648824FF11BE8967162036210E182@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from calf.ext.ti.com ([198.47.26.144]:42377 "EHLO calf.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753422AbYHORc1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 13:32:27 -0400
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036210E182@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "soni.trilok@gmail.com" <soni.trilok@gmail.com>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "Pasam, Vijay" <vpasam@ti.com>, "Kridner, Jason" <jdk@ti.com>, "Mills, William" <wmills@ti.com>

Hi,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of
> Woodruff, Richard
> Sent: Friday, August 15, 2008 9:32 PM
> To: Tony Lindgren; Hiroshi DOYU
> Cc: linux-omap@vger.kernel.org; soni.trilok@gmail.com; Kanigeri, Hari; Ramirez Luna, Omar; Gupta,
> Ramesh; felipe.contreras@nokia.com; felipe.contreras@gmail.com; Pasam, Vijay
> Subject: RE: [RFC] Port TI DSP BRIDGE for a new dedicated branch in linux-omap
> 
> Hi,
> 
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > * Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080815 13:34]:
> > > Thank you guys for your comments,
> > >
> > > It seems that some of the patches couldn't be sent to ML because of
> > > the size limitation of vger.kernel.org ML. Now Tony is finding the
> > > place to put the rest up on somewhere for review. I don't know if
> > > reviwing these base code makes so much sense at this momenent,
> > > though..which doesn't mean "no probelm";p
> >
> > I've copied your patches to:
> >
> > http://www.muru.com/linux/tidspbridge/
> >
> > > I hope that everyone could work together on this branch without any
> > > problems eventually.
> >
> > We need to also figure out who's going to maintain the dspbridge
> > branch. Ideally somebody with experience with dsp and linux..
> 
> Really all the design, maintenance and test experience of that code is inside of TI.  This has lived
> for years and derivates have shipped in products.  Who ever watches over it needs to be able to
> provide a creditable multi-year commitment.
>
<snip>

Just to add few points, 

As we know the OMAP3530 (having same DSP as 3430) processor _today_ supports DSP Link / CE for ARM-DSP communications. Link/CE is extensively used in Davinci family of processors and has been continued on OMAP3530 as well. 

Moving forward we should also see a common set of API framework evolving for users of Link and Bridge to leverage applications developed for different domains.

We also have DSP gateway on our tree today which is used to some extent but might be deprecated in future.

So, a maintainer needs to know past, present and future work that is going to happen for DSP software development in coming months. With multiple open platforms on OMAP, I think we will see a good amount of traffic for OMAP and DSP in particular.

Regards,
Khasim
