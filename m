From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Multiple issues with omap4 panda es in linux next
Date: Mon, 22 Apr 2013 15:21:28 +0300
Message-ID: <51752B48.50700@ti.com>
References: <20130419171318.GK10155@atomide.com> <5174FE16.6080307@ti.com> <51750FF8.6000401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59142 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818Ab3DVMWZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Apr 2013 08:22:25 -0400
In-Reply-To: <51750FF8.6000401@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Luciano Coelho <coelho@ti.com>, Roger Quadros <rogerq@ti.com>, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, Ravi Babu <ravibabu@ti.com>, Ruslan Bilovol <ruslan.bilovol@ti.com>

On 04/22/2013 01:24 PM, Tomi Valkeinen wrote:
> On 2013-04-22 12:08, Tomi Valkeinen wrote:
>> On 2013-04-19 20:13, Tony Lindgren wrote:
>>
>>> 3. DSS fails with DT booting
>>>
>>> Works with legacy booting but fails with DT. I'm almost certain
>>> the DT booting was working last week or so?
>>>
>>> This is what I now get with DT booting:
>>>
>>> omapdss DSI error: can't get VDDS_DSI regulator
>>> omapdss HDMI error: can't get VDDA_HDMI_DAC regulator
>>> omapdss HDMI error: device hdmi init failed: -517
>>> omapdss CORE error: driver probe failed: -22
>>> ...
>> I think this is the issue Christoph Fritz reported earlier, DSS is being
>> initialized before TWL, and thus DSS doesn't find the regulators.
>>
>> The proper fix is of course to make DSS support EPROBE_DEFER, but that's
>> easier said than done. I'll have a look if I can get it working enough
>> to fix this issue.
> Yes, it seems delayed regulator initialization brought up this issue.
>
> I hacked DSI driver of omapdss and Taal panel driver to somewhat work
> with EPROBE_DEFER. But then the issue was with omapfb.
>
> omapfb is currently set to start at late_initcall, so that omapdss and
> panels are loaded before omapfb. But even that's not late enough to get
> the regulators for omapdss. It seems the regulators get also initialized
> at the late_initcall level. Changing omapfb to late_initcall_sync was
> late enough to get things working.
>
> Again, making omapdss, panel drivers and omapfb support EPROBE_DEFER and
> dynamic panel driver insertion is the proper fix, but it's a big job,
> and there are "interesting" issues with it (like how to know if a panel
> device will ever get a driver loaded).
>
> But is there something wrong with the TWL and regulators? late_initcall
> sounds rather late for such a core resource. Even if all drivers
> supported EPROBE_DEFER, won't it cause extra delays in the boot as
> drivers are getting probed multiple times?
>
> As for fixing the DSS problem for 3.10, I don't have any ideas except
> pure hacks. I'll continue studying this.
Hi Tomi,
twl is not initialized because of I2C,
I2C is not initialized because of pinctrl-single,
pinctrl-single is initialized at mudule/device init time.
So, most everything will be shifted at late_initcall time.

Hack that sequence is here - https://patchwork.kernel.org/patch/2444501/


>
>   Tomi
>
>

