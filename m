From: Nishanth Menon <nm@ti.com>
Subject: Re: Power managment on Overo
Date: Thu, 15 Jul 2010 08:17:54 -0500
Message-ID: <4C3F0A82.50107@ti.com>
References: <loom.20100715T065056-117@post.gmane.org> <4C3EE316.5000506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39318 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933200Ab0GONSc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Jul 2010 09:18:32 -0400
In-Reply-To: <4C3EE316.5000506@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Han Wang <hw342@cornell.edu>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Nishanth Menon had written, on 07/15/2010 05:29 AM, the following:
> On 07/15/2010 12:00 AM, Han Wang wrote:
>> Hi, All,
>>
>>     I am running the linux-pm-kernel v2.35.rc3 on Overo Earth. I have managed to
>> suspend the system using "echo mem>  /sys/power/state" with "enable_off_mode"
>> and "sleep_while_idle" enabled. Currently, I am able to achieve 200mW in suspend
>> mode. However, I am seen in other posts, such as this  one  (http://old.nabble.com/
>> Overo-boot-time--power-management-ts28402656.html#a28463135), that
>> people are able to achieve a much lower power signature.
> 
> Did you check if you have actually shut off the voltages on vdd1 and 
> vdd2 when you hit OFF? easy to check with a voltmeter/scope on vdd1&vdd2 
> capcacitors.

Just some addon info, in case you'd like to dig further. I have'nt 
personally looked at overo board, but given that it uses TWL variant 
PMIC and OMAP3, the concepts should remain same, in a simplistic form:

OMAP is divided into powerdomains which power clock domains,

when the clock domains hit off, power domains switch off, if all the 
domains hit off, core domain (the thing that drives sdram etc) goes to 
OFF, this triggers an interesting sequence from h/w perspective -> it 
toggles couple of lines - one that tells pmic that it is going to off, 
and also tells the pmic that it does not need a sysclk.

twl pmic has internal scripts that can be linked to these signals- these 
are called resources in PMIC terminology -> for sysoff, we have twl 
scripts which tell which LDOs to switch off completely

so at OFF mode, ideally you supply 0v to vdd1,vdd2. vio_1.8 is active 
and drives a domain called wakeup domain inside OMAP, this keeps a few 
signals from omap and blocks within OMAP active - such as the one to 
detect a wakeup event(yeah we need some mechanism to wakeup right-aka 
some voltage ;) ).. the struggle is always to find the optimal 
configuration for the platform at hand which minimizes the blocks and 
signals active - we save a few uAmps here and there but they all add up.

Further at OFF, other than OMAP and the PMIC, there are other 
peripherals on the board -e.g. if you dont need to wakeup from 
Touchscreen, do we keep it on, is wlan ON? remember when you switch off 
a peripheral, you need to reconfigure it to bring it back on - aka 
latency tradeoff.. on a real product, there are a lot of investigations 
folks do to optimize, improve the designs to achieve as little 
peripherals as needed to be kept on at any given time Vs responsiveness.

in short it is usually an interesting challenge to consume as little as 
possible in OFF - to use automotive language - based on the usage model, 
your milage may vary ;)..

> 
>>     I am particularly interested to know what mode has the SDRAM on Overo  been set to
>> during suspend mode? Is it auto-refresh or self-refresh? And whether the TPS/TWL
>> power management chip is set to low power mode during suspend mode by the pm
>> kernel, if not, how to set it?
>>
>> Thanks,
>> Han
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Regards,
Nishanth Menon
