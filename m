From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC PATCH 6/6] hwmon: OMAP4: On die temperature sensor driver
Date: Wed, 24 Aug 2011 09:37:50 +0530
Message-ID: <4E547916.9090106@ti.com>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com> <1312979122-5896-7-git-send-email-j-keerthy@ti.com> <20110810124629.GJ12882@legolas.emea.dhcp.ti.com> <CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com> <20110811103658.GG27742@legolas.emea.dhcp.ti.com> <CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com> <20110811141248.GK28500@legolas.emea.dhcp.ti.com> <CAJ6a13b7qu3K4YJPTYych_NQxLuuUxZOQg6PPC_=XA+qiwn2RA@mail.gmail.com> <20110811185408.GB15970@legolas.emea.dhcp.ti.com> <20110811185558.GC15970@legolas.emea.dhcp.ti.com> <4E444B8F.9060908@ti.com> <4E449D65.9000004@ti.com> <874o19gfrr.fsf@ti.com> <4E532A28.60103@ti.com> <87ei0chwwz.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:48171 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750788Ab1HXEIB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 00:08:01 -0400
Received: by mail-gx0-f173.google.com with SMTP id 26so696854gxk.18
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 21:07:59 -0700 (PDT)
In-Reply-To: <87ei0chwwz.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, balbi@ti.com, "J, KEERTHY" <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>, lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, Russell King <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, khali@linux-fr.org, guenter.roeck@ericsson.com

On 8/23/2011 10:45 PM, Kevin Hilman wrote:
> Rajendra Nayak<rnayak@ti.com>  writes:
>
>> On 8/23/2011 5:28 AM, Kevin Hilman wrote:
>>> Rajendra Nayak<rnayak@ti.com>   writes:
>>>
>>> [...]
>>>
>>>> FWIK, its a one time requirement to set the clock rate to the
>>>> right rate the device can operate in based on what a platform
>>>> supports.
>>>
>>> Except $SUBJECT patch hard-codes the clock rate for all platforms in the
>>> driver.
>>
>> The device has a requirement to operate in a 1Mhz to 2Mhz range.
>
> You mean the device on OMAP4 has this requirement.
>
> Will this requirement exist on every platform that uses any version of
> this IP (or future similar IPs)?  I suspect not.

I agree, the current limitation is specific to the IP rev used, and
might change for a never version of the IP.

>
>> So the driver is using a clk_round_rate() to get the closest rate
>> supported and sets it using a clk_set_rate().
>>
>>>
>>> If the clock rate is to be platform-specific, it should be done in
>>> platform-specific code.
>>
>> I am fine if this needs to be moved to platform-specific code, but I
>> wasn't quite sure this needs to be done in clock framework as was
>> suggested.
>
> No, it should't be in clock framework.  But since the frequency range is
> platform-specific, it should be initialized in platform-specific code.
> Having min/max parameters passed by platform data as suggested by
> J. Keerthy is fine.
>
> Probably even better is to have the driver have a default min/max rang
> which can be overridden by platform_data only if needed.

This sounds better since if the same IP rev is used on other platforms
which does not change the min/max, the driver can do with the default
and that would avoid duplications of same min/max having to be passed
for multiple platforms.

>
> Kevin

