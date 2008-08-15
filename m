From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [RFC] Port TI DSP BRIDGE for a new dedicated branch in linux-omap
Date: Sat, 16 Aug 2008 00:33:13 +0530
Message-ID: <5d5443650808151203l65a764d5m44b964c91bac8f60@mail.gmail.com>
References: <1218782824-12596-1-git-send-email-Hiroshi.DOYU@nokia.com>
	 <5d5443650808150052l29bf0830u60ff256b51d53066@mail.gmail.com>
	 <94a0d4530808150247g52c1e258v5b922e01fb5154bc@mail.gmail.com>
	 <20080815.133409.81509340.Hiroshi.DOYU@nokia.com>
	 <20080815112112.GB16840@atomide.com>
	 <13B9B4C6EF24D648824FF11BE8967162036210E182@dlee02.ent.ti.com>
	 <0680EC522D0CC943BC586913CF3768C00208C16543@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f29.google.com ([209.85.217.29]:58926 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758077AbYHOTDO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2008 15:03:14 -0400
Received: by gxk10 with SMTP id 10so2967186gxk.13
        for <linux-omap@vger.kernel.org>; Fri, 15 Aug 2008 12:03:13 -0700 (PDT)
In-Reply-To: <0680EC522D0CC943BC586913CF3768C00208C16543@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ramirez Luna, Omar" <x00omar@ti.com>, "Gupta, Ramesh" <grgupta@ti.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "felipe.contreras@gmail.com" <felipe.contreras@gmail.com>, "Pasam, Vijay" <vpasam@ti.com>, "Kridner, Jason" <jdk@ti.com>, "Mills, William" <wmills@ti.com>

Hi Khasim,

On Fri, Aug 15, 2008 at 11:02 PM, Syed Mohammed, Khasim <khasim@ti.com> wrote:

>>
>> Really all the design, maintenance and test experience of that code is inside of TI.  This has lived
>> for years and derivates have shipped in products.  Who ever watches over it needs to be able to
>> provide a creditable multi-year commitment.
>>
> <snip>
>
> Just to add few points,
>
> As we know the OMAP3530 (having same DSP as 3430) processor _today_ supports DSP Link / CE for ARM-DSP communications. Link/CE is extensively used in Davinci family of processors and has been continued on OMAP3530 as well.
>

Oh..so you are saying that DSPBridge is going to be deprecated going
on and DSPLink will be used? It beats me that why anyone would go for
two separate bridges one for OMAP3 and another for DaVinci, and now
you are mentioning that OMAP3530 will go for DSP-Link instead of
DSPBridge. It is just confusing.

> Moving forward we should also see a common set of API framework evolving for users of Link and Bridge to leverage applications developed for different domains.
>

I wish that DSPBridge and DSPLink/CE would kill each other in fight
and hope new winner will emerge dspfs-no-bridge-no-link but only
communication :)

> We also have DSP gateway on our tree today which is used to some extent but might be deprecated in future.
>

I hope you mean Nokia DSPGateWay.

> So, a maintainer needs to know past, present and future work that is going to happen for DSP software development in >coming months. With multiple open platforms on OMAP, I think we will see a good amount of traffic for OMAP and DSP in >particular.

Yes and No, as far as TI is ready to support him.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
