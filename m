From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [RFC PATCH 6/6] hwmon: OMAP4: On die temperature sensor driver
Date: Tue, 23 Aug 2011 09:48:48 +0530
Message-ID: <4E532A28.60103@ti.com>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com> <1312979122-5896-7-git-send-email-j-keerthy@ti.com> <20110810124629.GJ12882@legolas.emea.dhcp.ti.com> <CAJ6a13Z=u=exWUHLotw8jpHMv-hKpE+fvg_1hq7=gtMiuJKxOA@mail.gmail.com> <20110811103658.GG27742@legolas.emea.dhcp.ti.com> <CAJ6a13bxg8po-Csc10LsFH-oES4YOKkqFoTm3kG4XzS=b2boMw@mail.gmail.com> <20110811141248.GK28500@legolas.emea.dhcp.ti.com> <CAJ6a13b7qu3K4YJPTYych_NQxLuuUxZOQg6PPC_=XA+qiwn2RA@mail.gmail.com> <20110811185408.GB15970@legolas.emea.dhcp.ti.com> <20110811185558.GC15970@legolas.emea.dhcp.ti.com> <4E444B8F.9060908@ti.com> <4E449D65.9000004@ti.com> <874o19gfrr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:59933 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750698Ab1HWETF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 00:19:05 -0400
Received: by mail-gw0-f54.google.com with SMTP id 15so5530168gwb.27
        for <linux-omap@vger.kernel.org>; Mon, 22 Aug 2011 21:19:03 -0700 (PDT)
In-Reply-To: <874o19gfrr.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Roger Quadros <rogerq@ti.com>, balbi@ti.com, "J, KEERTHY" <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>, lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, Russell King <linux@arm.linux.org.uk>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, khali@linux-fr.org, guenter.roeck@ericsson.com

On 8/23/2011 5:28 AM, Kevin Hilman wrote:
> Rajendra Nayak<rnayak@ti.com>  writes:
>
> [...]
>
>> FWIK, its a one time requirement to set the clock rate to the
>> right rate the device can operate in based on what a platform
>> supports.
>
> Except $SUBJECT patch hard-codes the clock rate for all platforms in the
> driver.

The device has a requirement to operate in a 1Mhz to 2Mhz range. So the
driver is using a clk_round_rate() to get the closest rate supported and
sets it using a clk_set_rate().

>
> If the clock rate is to be platform-specific, it should be done in
> platform-specific code.

I am fine if this needs to be moved to platform-specific code, but I
wasn't quite sure this needs to be done in clock framework as was
suggested.

>
> Kevin

