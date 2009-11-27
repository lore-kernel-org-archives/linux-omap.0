From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: omap3evm: touchscreen delays on pm branch
Date: Fri, 27 Nov 2009 16:04:38 +0530
Message-ID: <040b01ca6f4d$38ac95c0$LocalHost@wipultra793>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE72D63F@dbde02.ent.ti.com> <4B0F9045.6030404@ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301DE7B90E2@dbde02.ent.ti.com> <1259312859.19138.4.camel@boson> <B85A65D85D7EB246BE421B3FB0FBB59301DE7B9180@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35923 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754244AbZK0Keg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Nov 2009 05:34:36 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id nARAYdvP004128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 04:34:41 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, "Dasgupta, Romit" <romit@ti.com>
Cc: linux-omap@vger.kernel.org

----- Original Message ----- 
From: "Premi, Sanjeev" <premi@ti.com>
To: "Dasgupta, Romit" <romit@ti.com>
Cc: <linux-omap@vger.kernel.org>
Sent: Friday, November 27, 2009 3:20 PM
Subject: RE: omap3evm: touchscreen delays on pm branch


>> -----Original Message-----
>> From: Dasgupta, Romit 
>> Sent: Friday, November 27, 2009 2:38 PM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org
>> Subject: RE: omap3evm: touchscreen delays on pm branch
>> 
>> On Fri, 2009-11-27 at 14:11 +0530, Premi, Sanjeev wrote:
>> > > -----Original Message-----
>> > > From: Dasgupta, Romit 
>> > > Sent: Friday, November 27, 2009 2:10 PM
>> > > To: Premi, Sanjeev
>> > > Cc: linux-omap@vger.kernel.org
>> > > Subject: Re: omap3evm: touchscreen delays on pm branch
>> > > 
>> > > Premi, Sanjeev wrote:
>> > > > Hi,
>> > > > 
>> > > > I am finding the response of touchscreen on the 
>> omap3evm very slow.
>> > > > 
>> > > > Here is my test:
>> > > > On console, I run : watch -n2 "cat /proc/interrupts"
>> > > > Then, I tap the touchscreen approximately once per 
>> second. However,
>> > > > (usually) no interrupts are registered. As I increase 
>> the frequency
>> > > > of 'taps' more and more interrupts are registered. But still not
>> > > > matching exact taps.
>> > > > 
>> > > > However, when I keep the cpu busy with "cat /dev/zero > 
>> /dev/null &"
>> > > > each tap is recognized.
>> > > > 
>> > > Do you see this even if we don't enable OFF?
>> > > 
>> > Yes. Sleep_while_idle=0; enable_off_mode=0
>> > ~sanjeev
>> 
>> Hopefully you have the same TSC driver. Nevertheless, can you 
>> please try
>> this (just to see if clock domain idling is causing any 
>> problem or not):
> 
> It is the same driver at SDP3430. I had earlier tried removing
> cpuidle altogether and did not see this issue. I too believe that
> issue is caused by clocks being going to (auto)idle.
> 
> But then, Hemanth should be seeing the same behavior.

Zoom2/Zoom3 use a different touchscreen driver compared to SDP.
Its uses Synaptic Touchscreen over I2C.
