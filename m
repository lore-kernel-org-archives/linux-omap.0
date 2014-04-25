From: Archit Taneja <archit@ti.com>
Subject: Re: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
Date: Fri, 25 Apr 2014 18:28:50 +0530
Message-ID: <535A5C0A.7040808@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com> <1398334639-14172-7-git-send-email-tomi.valkeinen@ti.com> <535A42D6.5090107@ti.com> <535A4470.2000509@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60266 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbaDYNAP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Apr 2014 09:00:15 -0400
In-Reply-To: <535A4470.2000509@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>

On Friday 25 April 2014 04:48 PM, Tomi Valkeinen wrote:
> On 25/04/14 14:11, Archit Taneja wrote:
>> Hi,
>>
>> On Thursday 24 April 2014 03:47 PM, Tomi Valkeinen wrote:
>>> Add support to set OMAP5 DSI pin muxing.
>>>
>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> ---
>>>    arch/arm/mach-omap2/display.c | 35 ++++++++++++++++++++++++++++++++++-
>>>    1 file changed, 34 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/display.c
>>> b/arch/arm/mach-omap2/display.c
>>> index 16d33d831287..974461441fc3 100644
>>> --- a/arch/arm/mach-omap2/display.c
>>> +++ b/arch/arm/mach-omap2/display.c
>>> @@ -137,11 +137,42 @@ static int omap4_dsi_mux_pads(int dsi_id,
>>> unsigned lanes)
>>>        return 0;
>>>    }
>>>
>>> +#define CONTROL_PAD_BASE    0x4A002800
>>> +#define CONTROL_DSIPHY        0x614
>>> +
>>
>> I guess this is something we can move to our driver, and use sysconf to
>> get the register from DT.
>
> I just copied the same method as used for OMAP4.
>
> I guess sysconf is an option. But I really dislike the idea of moving
> omap control module code to a display driver... I'm not sure what other
> options we have, though. Maybe an OMAP DSI specific pinctrl driver?

OMAP4 has CONTROL_DSIPHY for configuring both lane enable/disbale, and 
pull up/down, but OMAP5 has normal PAD_CONF registers for DSI lines(2 
pins per register) for configuring pull up/down, and CONTROL_DSIPHY for 
lane enable/disable.

We would have a very messed up pinctrl driver, but it would probably be 
better than doing all this stuff in the driver.

Archit

