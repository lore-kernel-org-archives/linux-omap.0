From: Nishanth Menon <nm@ti.com>
Subject: Re: PM: VDD2 OPPs
Date: Tue, 26 Jan 2010 14:41:28 -0600
Message-ID: <4B5F5378.9020800@ti.com>
References: <0C997DD87CC88A4F86C897F52650B52B02807701@MOLSON.mpc-data.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47615 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974Ab0AZUlm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 15:41:42 -0500
In-Reply-To: <0C997DD87CC88A4F86C897F52650B52B02807701@MOLSON.mpc-data.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Murray <amurray@mpc-data.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Andrew Murray had written, on 01/26/2010 02:34 PM, the following:
> Hello,
> 
> With regards to the OMAP2 (or at least the 3530 EVM) -the TRM and
> various whitepapers suggest that they are 3 OPP levels available for
> VDD2 (L3). However, from looking at the sources (linux-omap-pm / pm
> branch) it seems that only 2 OPP levels are supported (@166Mhz and
> @83Mhz) and used. I also notice that these rates are different to those
> in a whitepaper (166, 100 and 41.5). Is there any particular reason why
on OMAP34/35xx, I believe it should be s/100/83/.
> only 2 OPPs are used? 
to my knowledge 41.5Mhz is not known to provide any performance 
benefits. you can also see [1] and add 41.5 (pm-wip-opp is the new 
branch where we are introducing opp layer.

> 
> I understand that the OPP level of VDD2 may be set by changes to the OPP
> level of VDD1 (i.e. resource34xx.c:set_opp) - and modifying VDD1's OPP
> via cpufreq seems to be the only way to adjust the VDD2 OPP from
> user-land - is this correct?
The old /sys/power/vdd2_[opp|lock] was deprecated out. currently the 
control is for vdd1 OPP using cpufreq and indirect dependency for VDD2, 
is there a need for direct control of VDD2 freq?
-- 
Regards,
Nishanth Menon

Ref:
[1] 
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=blob;f=arch/arm/mach-omap2/cpufreq34xx.c;h=07873e87ffc0fef97b4554efc3f17dc696cb25e3;hb=4f54a09e0ed9b2ee8e1adfe1716297792310d1c6#l46
