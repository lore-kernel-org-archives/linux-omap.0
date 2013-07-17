From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: omap_device: add pinctrl handling
Date: Wed, 17 Jul 2013 19:56:22 +0300
Message-ID: <51E6CCB6.2000907@ti.com>
References: <1374061312-25469-1-git-send-email-grygorii.strashko@ti.com> <1374061312-25469-3-git-send-email-grygorii.strashko@ti.com> <20130717153838.GJ7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47692 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755507Ab3GQRFk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jul 2013 13:05:40 -0400
In-Reply-To: <20130717153838.GJ7656@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Linus Walleij <linus.walleij@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>

On 07/17/2013 06:38 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [130717 04:49]:
>> Before switching to DT pinctrl states of OMAP IPs have been handled by hwmod
>> framework. After switching to DT-boot the pinctrl handling was dropped from
>> hwmod framework and, as it was recommended, OMAP IP's drivers have to be updated
>> to handle pinctrl states by itself using pinctrl_pm_select_xx() helpers
>> (see http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/173514.html)
>>
>> But this is not right for OMAP2+ SoC where real IPs state is controlled
>> by omap_device core which enables/disables modules & clocks actually.
>
> I'm not convinced we should try to handle this in a generic way
> as only some devices need dynamic remuxing of some pins.
>
>> For example, if OMAP I2C driver will handle pinctrl state during system wide
>> suspend the following issue may occure:
>> - suspend_noirq - I2C device can be still active because of PM auto-suspend
>>    |-_od_suspend_noirq
>>       |- omap_i2c_suspend_noirq
>>          |- PINs state set to SLEEP
>>    |- pm_generic_runtime_suspend
>>       |- omap_i2c_runtime_suspend()
>>          |- PINs state set to IDLE  <--- *oops* PINs state is IDLE and not SLEEP
>>    |- omap_device_idle()
>>       |- omap_hwmod_idle()
>>          |- _idle()
>>             |- disbale module (sysc&clocks)
>
> And in this example you are assuming that you need separate idle and
> sleep states, which is not true at least for most cases I've seen.

I don't need both states (at least right now) :), but
- if any OMAP2+ driver will have two states defined: "idle" and "sleep"
- and if it will try to manage them from drivers callbacks only using
   pure calls to pinctrl_pm_select_xx() helpers

the "idle" state will be selected during suspend and *not* "sleep".

>
> It is possible that am33xx needs separate idle and sleep states, but
> most likely only for some pins. For omap[345] we can get away with
> just the default state for most cases.
>


In case, if only "default" state is defined for device - nothing will
  be done by OMAP device framework for it (I mean any call to
pinctrl_pm_select_xx() will do nothing - it just checks that there is
no state and returns 0).

> Regards,
>
> Tony
>

Regards,
- grygorii
