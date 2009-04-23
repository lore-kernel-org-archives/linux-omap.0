From: Paul Walmsley <paul@pwsan.com>
Subject: Re: PM: 4 Problems in OMAP3430 DVFS (SmartReflex, Cpufreq)
Date: Thu, 23 Apr 2009 02:52:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904230245440.6400@utopia.booyaka.com>
References: <4d34a0a70904222200oc699378k56367cf3b378b5d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42012 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbZDWIww (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2009 04:52:52 -0400
In-Reply-To: <4d34a0a70904222200oc699378k56367cf3b378b5d9@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: r-woodruff2@ti.com
Cc: Kim Kyuwon <chammoru@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, OMAP <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>, =?EUC-KR?B?uc66tMij?= <bhmin@samsung.com>, Tony Lindgren <tony@atomide.com>

Hello Richard,

On Thu, 23 Apr 2009, Kim Kyuwon wrote:

> 4. Current PM code didn't enable the maximum clock (i.e. CPU: 600Mhz)
> according to the comment as below:
> 
> 	/* Avoid registering the 120% Overdrive with CPUFreq */
> 	prcm = mpu_opps + MAX_VDD1_OPP - 1;
> 
> But in some cases, we should use 600Mhz for multimedia application.
> And, even thought we enable the maximum clock, CPU frequency seldom
> goes into maximum clock. I think we don't have to avoid registering
> the max OPP.

Do you know if this restriction can be lifted now, i.e., can the silicon 
run at VDD1 OPP1 100% of the time and meet the device lifespan targets?

- Paul
