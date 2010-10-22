From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: hwmod and insertable modules
Date: Fri, 22 Oct 2010 17:47:21 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593023461A7AC@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB593023458C204@dbde02.ent.ti.com>
 <0680EC522D0CC943BC586913CF3768C003FF2DAF8D@dbde02.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593023458C250@dbde02.ent.ti.com>
 <4CC15CC3.7060406@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB593023458C2BE@dbde02.ent.ti.com>
 <4CC166C6.7060403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49250 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483Ab0JVMR2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Oct 2010 08:17:28 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o9MCHPEp002571
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 07:17:27 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o9MCHNC5027610
	for <linux-omap@vger.kernel.org>; Fri, 22 Oct 2010 17:47:24 +0530 (IST)
In-Reply-To: <4CC166C6.7060403@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "Nayak, Rajendra" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Friday, October 22, 2010 3:56 PM
> To: Premi, Sanjeev
> Cc: Nayak, Rajendra; linux-omap@vger.kernel.org
> Subject: Re: hwmod and insertable modules
> 
> Premi, Sanjeev had written, on 10/22/2010 05:01 AM, the following:
> 
> >>>>> During module_init I used omap_device_build() to create the 
> >>>> omap_device.
> >>>>> But when trying to implement the module_exit, I 
> couldn't find the
> >>>>> corresponding 'destructor'.
> >>>> omap_device_build essentially does  a platform_device 
> >> register today
> >>>> and hence its not something to be done from a 
> insmod'able 'driver'.
> >>> [sp] How does this work for - say dspbridge - where the DSP 
> >> as device
> >>> may not be 'registered' until it is really expected to be used?
> >>>
> >> arch/arm/mach-omap2/dspbridge.c? ;)
> > 
> > Which repo? On the dspbridge branch on linux-omap, there is not such
> :) it is not there as dspbridge is in staging at the moment - 
> I believe 
> there is some sort of rule of not depending on staging drivers or 
> something like that.. but the point I was attempting to make 
> is backing 
> Rajendra's statement -> split your driver into silicon 
> specific data and 
> silicon independent driver -> the silicon dependent data (like hwmod) 
> can be collected by a file located in arch/arm/mach-omap2 -> pass the

I am not really concerned for location of the file - but intent of the
original query was to understand if we ever thought of antonym of
omap_device_build() OR if it did come for discussion if there was an
accepted disposition.

> data as platform_data(with stuff like baseaddress etc..) to 
> the driver 
> and things can happily function... Would suggest posting out a 
> RFC patch 
> if you'd like better ideas from the community I guess.

I was trying other way - understand if there is an existing norm/
convention that I can follow - rather than (re)invent it!

Based on discussion so far, I will definitely have an RFC.

> 
> -- 
> Regards,
> Nishanth Menon
> 