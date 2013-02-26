From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 0/2] ARM: dts: omap3-overo: Add pwm-leds and audio support
Date: Tue, 26 Feb 2013 17:19:09 +0100
Message-ID: <512CE07D.2050107@ti.com>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch> <5101273A.9090800@ti.com> <510F7BEB.1020408@epfl.ch> <51125AFC.10704@ti.com> <51135EAC.7010406@ti.com> <512CDDC8.6030307@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42837 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758046Ab3BZQTV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Feb 2013 11:19:21 -0500
In-Reply-To: <512CDDC8.6030307@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: florian.vaussard@epfl.ch
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

Hi Florian,

On 02/26/2013 05:07 PM, Florian Vaussard wrote:
> Hi,
> 
> On 02/07/2013 08:58 AM, Peter Ujfalusi wrote:
>> Hi,
>>
>> On 02/06/2013 02:30 PM, Benoit Cousson wrote:
>>>> So a patch is being merged to handle triggers in the case of pwm
>>>> leds [1].
>>>> When done, we will be able to add back the default trigger. Do you want
>>>> to wait on it to merge this series?
>>>
>>> What kind of dependency do we have between these two series? I mean what
>>> will happen if the DTS is merged before the pwm subsystem?
>>>
>>> If that does not generate any regression / crash, then it is OK, if not,
>>> we should take care of the order.
>>
>> In this series the 'linux,default-trigger' property is not added to the
>> pwm-leds node, so it is safe to take this series.
>> I'm sure Florian will send the update to add this flag back for 3.10
>> or for
>> 3.9-rc (the needed patches for PWM and leds-pwm will be in 3.9).
>>
> 
> Yes, it is safe to take this series. I will provide a patch to add back
> the trigger when it is safe to.

OK, great, I'll take the series then.

Thanks,
Benoit

