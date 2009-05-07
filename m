From: Kim Kyuwon <q1.kim@samsung.com>
Subject: Re: PM: 4 Problems in OMAP3430 DVFS (SmartReflex, Cpufreq)
Date: Thu, 07 May 2009 16:42:34 +0900
Message-ID: <4A0290EA.1070405@samsung.com>
References: <4d34a0a70904222200oc699378k56367cf3b378b5d9@mail.gmail.com>
 <alpine.DEB.2.00.0904230245440.6400@utopia.booyaka.com>
 <13B9B4C6EF24D648824FF11BE896716203821CC314@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:22599 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbZEGHmw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 03:42:52 -0400
Received: from epmmp1 (mailout2.samsung.com [203.254.224.25])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KJ9000HUK2ZPS@mailout1.samsung.com> for
 linux-omap@vger.kernel.org; Thu, 07 May 2009 16:42:35 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KJ900E4XK2Z8V@mmp1.samsung.com> for
 linux-omap@vger.kernel.org; Thu, 07 May 2009 16:42:35 +0900 (KST)
In-reply-to: <13B9B4C6EF24D648824FF11BE896716203821CC314@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kim Kyuwon <chammoru@gmail.com>, OMAP <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tony Lindgren <tony@atomide.com>

Hi Kevin, Tony, Paul and other experts.

Woodruff, Richard wrote:
>> From: Paul Walmsley [mailto:paul@pwsan.com] Sent: Thursday, April
>> 23, 2009 3:53 AM To: Woodruff, Richard
> 
>>> 4. Current PM code didn't enable the maximum clock (i.e. CPU:
>>> 600Mhz) according to the comment as below:
>>> 
>>> /* Avoid registering the 120% Overdrive with CPUFreq */ prcm =
>>> mpu_opps + MAX_VDD1_OPP - 1;
>>> 
>>> But in some cases, we should use 600Mhz for multimedia
>>> application. And, even thought we enable the maximum clock, CPU
>>> frequency seldom goes into maximum clock. I think we don't have
>>> to avoid registering the max OPP.
>> Do you know if this restriction can be lifted now, i.e., can the
>> silicon run at VDD1 OPP1 100% of the time and meet the device
>> lifespan targets?
> 
> So, there have been some characterization changes which give more
> leeway for software usage off overdrive.
> 
> What you found before was guarantees against typical mobile usage for
> a few classes of devices. This was done using a mix of OPPs with the
> majority of active time in lower OPPs and inactive time in low idles
> (optimal usage for mix of typical operations, this is the way you
> would want to run ideally). Against this and many more variables,
> reliability data was validated and published.
> 
> Recently there was some change to also measure active time at max
> overdrive for same usage mix. This resulted in still meeting lifetime
> goals for typical usage.
> 
> This can translate to a smart phone maker of being able to use
> overdrive as they see fit and still have long life (assuming they can
> supply adequate power and still dissipate what ever additional heat
> there is). This is still not 100% of the time in active mode.

What do you think of enabling to register the 120% Overdrive with CPUFreq
in l-o tree?.

Regard,
Kyuwon

> I suspect TI will continue to create parts for certain markets when
> the need is there. The part might be nearly identical but the way
> it's rated (with chip binning and other tricks) will allow different
> guarantees. This fits well with mobile business customer needs.
> 
> As an open source individual owner of a device, you might do things
> in a non-typical way. You are free to do this. Depending on which
> base chip variant you are using, its life may have some impact (or
> not). Your chip likely will still last many years. The phone or other
> device might die first.
> 
> All that said, today personally, I feel much more comfortable
> exposing overdrives in the reference code. Mobile users and their
> devices which actually sleep at night should be pretty safe.
> 
> Watch data sheets for details :)
> 
> Regards, Richard W.
> 

