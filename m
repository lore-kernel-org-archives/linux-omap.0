From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V3 3/3] rtc: omap: Support regulator supply for RTC
Date: Fri, 24 Oct 2014 10:47:53 -0500
Message-ID: <544A74A9.9090807@ti.com>
References: <1414126425-13198-1-git-send-email-lokeshvutla@ti.com> <1414126425-13198-4-git-send-email-lokeshvutla@ti.com> <544A5393.6090504@ti.com> <20141024154312.GL26941@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37203 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755412AbaJXPsw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Oct 2014 11:48:52 -0400
In-Reply-To: <20141024154312.GL26941@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Lokesh Vutla <lokeshvutla@ti.com>, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, a.zummo@towertech.it, johan@kernel.org, tony@atomide.com, bcousson@baylibre.com, akpm@linux-foundation.org, linux@roeck-us.net, nsekhar@ti.com, t-kristo@ti.com, j-keerthy@ti.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 10/24/2014 10:43 AM, Felipe Balbi wrote:
> On Fri, Oct 24, 2014 at 08:26:43AM -0500, Nishanth Menon wrote:
>> On 10/23/2014 11:53 PM, Lokesh Vutla wrote:
>>> On some Soc's RTC is powered by an external power regulator.
>> SoC ? -> could you rephrase this to indicate "certain SoCs such as
>> DRA7, RTC is an independent voltage domain of it's own and on
>> platforms such as DRA7-evm, this may be supplied by individual
>> regulator on it's own.
>>
>>> e.g. RTC on DRA7 SoC. Make the OMAP RTC driver support a
>>> power regulator.
>>
>> Question ofcourse is what voltage would you like that regulator to be
>> at? As you are aware, certain LDOs and SMPS can drive varying voltage
>> and just enable/disable would do just the default voltage of the
>> SMPS/LDO, right? OR am i missing something here?
> 
> just pass the correct voltage through DTS as we do for all other
> regulators ? It's only tricky when we have a range of acceptable
> voltages but for RTC, IIRC, it's always a set voltage (1.0V or 1.8V).
> 
you mean min=max=1.8V board constraint - sure it will work, except I
might expect to see that in the example? OR expect the driver to
explicitly set it.

-- 
Regards,
Nishanth Menon
