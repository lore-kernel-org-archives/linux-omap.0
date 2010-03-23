From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-WIP-OPP][PATCH 3/4] omap: pm: opp: add ability to store
 data per opp
Date: Tue, 23 Mar 2010 10:36:32 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03220FC0C3@dbde02.ent.ti.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com>
 <1268937891-19445-2-git-send-email-nm@ti.com>
 <1268937891-19445-3-git-send-email-nm@ti.com>
 <1268937891-19445-4-git-send-email-nm@ti.com>
 <20100319144333.GU18995@nokia.com> <4BA3975E.70206@ti.com>
 <74583B8642AB8841B30447520659FCA9EBAC2C6A@dnce01.ent.ti.com>
 <4BA770D6.9020707@ti.com>
 <74583B8642AB8841B30447520659FCA9EBAC3458@dnce01.ent.ti.com>
 <4BA7B601.1060504@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35590 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555Ab0CWFGr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 01:06:47 -0400
In-Reply-To: <4BA7B601.1060504@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>



>>
>>[...] [I am not about to repeat everything I stated in previous
>>threads.. so  snipping the discussion down.]
>>
>>>
>>> Otherwise the primary idea to remove OPP ID is good, and the way to go.
>>
>>good. So lets NAK that SR series and see how else we can implement it
>>without OPP ID. I am open to any clean mechanisms you may propose
>>without using OPP ID referencing :).

Ok guys.. In the current V2 series , I have linked N targets with voltage.. Only it does not come from voltage layer but from smartreflex devices layer. The smartreflex driver does not use opp ids at all.. Also whether you call it by opp ids or by any other name, we need to know the number of different voltages supported by VDD1 and VDD2 and form the table.. That is exactly what I am doing in smartreflex device layer. I am just creating a table with different voltages and N target values associated with those voltages. To create this table I need to know there should be 5 voltages for VDD1 and 3 voltages for VDD2 which unfortunately coincides with the number of different OPP's defined in OMAP3430 today.. 
I also think it is an excellent idea to NAK a series of 19 patches for which everybody has been shouting for, for this reason.

Regards
Thara  

