From: Koen Kooi <koen@beagleboard.org>
Subject: Re: [PATCH 2/2] OMAP3: beagle xm: enable upto 800MHz OPP
Date: Thu, 6 Jan 2011 15:01:10 +0100
Message-ID: <FAF33A33-767F-45DD-B0E4-1C173342CFB1@beagleboard.org>
References: <1294260576-20237-1-git-send-email-nm@ti.com>	<1294260576-20237-3-git-send-email-nm@ti.com> <874o9nvskt.fsf@ti.com> <4D25B482.3080709@ti.com> <579AA000-EB86-4DD3-B3B7-29F7A72E0415@beagleboard.org> <4D25C745.7060600@ti.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58037 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920Ab1AFOBT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 09:01:19 -0500
Received: by wyb28 with SMTP id 28so16413722wyb.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 06:01:17 -0800 (PST)
In-Reply-To: <4D25C745.7060600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>


Op 6 jan 2011, om 14:44 heeft Nishanth Menon het volgende geschreven:

> Koen Kooi had written, on 01/06/2011 07:00 AM, the following:
>> Op 6 jan 2011, om 13:24 heeft Nishanth Menon het volgende geschreven:
>>> Kevin Hilman wrote, on 01/05/2011 05:28 PM:
>>>> Nishanth Menon<nm@ti.com>  writes:
>>>> 
>>>>> Beagle XM uses 3730 and the board design allows enabling 800MHz and 1GHz
>>>>> OPPs. However, We need Smart reflex class 1.5 and ABB to enable 1GHz safely.
>>>>> For the moment, we tweak the default table to allow for 800Mhz OPP usage.
>>>> Isn't this common to any board using 3730 (or 3630?)
>>> no it is not. only certain boards are capable of higher frequencies - there is a procedure called PDN analysis and vmin search that needs to be performed to guarentee this.
>> What about the "new" 3530s that can run at 720MHz? Those have been speed binned and given a different SKU. I'm using the attached 4 patches (Tony master + beagle patches _+ dvfs: http://dominion.thruhere.net/git/cgit.cgi/linux-omap/log/?h=koen/beagle-next) on my beagle C4 and overo tide to get 720MHz. They don't really work:
> for 3530, keep in mind that not *all* boards can support 720MHz (esp the old 3430 boards, like my poor SDP3430).

Right, that's why it's a different SKU and we can probe for it, see the 0002 patch I attached.

> since we consider 3530 as 3430 as well, add a default disabled 720MHz OPP in the 3430 table

That's what 0001 does :)

> and enable it:
> a) if this has anything to do with board behavior (which, unlike 36xx, I dont think is the case for 35xx), enable similar to this patch on the required boards on a need basis (e.g. based on board rev)

That's what 0003 and 0004 are doing for overo and beagle

> b) if this is a silicon behavior, then, you should modify the omap3_opp_init to ensure that for the right silicon this is enabled (e.g. only for 3530 rev X onwards or something similar) - but you will need some way to detect it in s/w (not through bootargs please!)

See 0002, it does it as an omap feature.

> 
>> root@usrp-e1xx:~# cpufreq-set -f 720000
>> [  104.976318] platform iva.0: omap_voltage_scale: Already at the requestedrate 430000000
>> [  104.986236] platform mpu.0: omap_voltage_scale: Already at the requestedrate 600000000
>> [  104.996032] platform iva.0: omap_voltage_scale: Already at the requestedrate 430000000
>> [  105.006408] platform mpu.0: omap_voltage_scale: Already at the requestedrate 600000000
> This is coz we dont have 720MHz and max enabled freq is 600MHz so it falls back to that freq.

Even after 0001 adds it to the table and 0004 enables it?

regards,

Koen