From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PM-WIP-OPP][PATCH 1/4] omap3: pm: cpufreq: BUG_ON cleanup
Date: Fri, 19 Mar 2010 16:50:06 +0200
Message-ID: <20100319145006.GW18995@nokia.com>
References: <1268937891-19445-1-git-send-email-nm@ti.com>
 <1268937891-19445-2-git-send-email-nm@ti.com>
 <87tysdi6tq.fsf@deeprootsystems.com>
 <4BA3886E.9070906@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:56540 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab0CSOvr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 10:51:47 -0400
Content-Disposition: inline
In-Reply-To: <4BA3886E.9070906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Linux-Omap <linux-omap@vger.kernel.org>, "K, Ambresh" <ambresh@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "Carmody Phil.2 (EXT-Ixonos/Helsinki)" <ext-phil.2.carmody@nokia.com>, "Premi, Sanjeev" <premi@ti.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>, "Gopinath, Thara" <thara@ti.com>

On Fri, Mar 19, 2010 at 03:21:34PM +0100, ext Nishanth Menon wrote:
>Kevin Hilman had written, on 03/18/2010 05:49 PM, the following:
>> Nishanth Menon <nm@ti.com> writes:
>>
>>> BUG_ON should not ideally contain a functional code. Remove it out.
>>
>> True.  But this code should not be using BUG_ON() in the first place.
>>
>> We should not crash the whole kernel in this case, just fail
>> with a warning.
>>
>> If you're cleaning this up, can you make it fail more gracefully.
>I agree  if this was a preipheral driver or a non-critical path. but in
>this case:
>
>a) we are speaking of a core description of the h/w - OPPs frequencies
>and voltages which out which the functionality of the system is at
>stake. I am not speaking of just having a basic kernel boot up to shell
>prompt - we need the kernel to do much better than that.
>
>b) Is there any reason why the registration could fail - if it did fail
>at this point, there is something catastrophic happening - some other
>driver is going beserk OR Opp layer is by itself screwed up - why
>continue if we can warn the system and force a fix of the code?

I agree with Nishanth here. If it fails at this point, we deserve the 
BUG().

-- 
balbi
