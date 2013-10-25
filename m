From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2: omap4-sdp: remove unneeded gpios from
 dss-common
Date: Fri, 25 Oct 2013 06:21:17 -0500
Message-ID: <526A542D.8060801@ti.com>
References: <1382695658-18757-1-git-send-email-tomi.valkeinen@ti.com> <1382695658-18757-3-git-send-email-tomi.valkeinen@ti.com> <526A4585.30403@ti.com> <526A4708.7010309@ti.com> <526A4DEA.3050505@ti.com> <526A526D.3010108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42636 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542Ab3JYLVk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 07:21:40 -0400
In-Reply-To: <526A526D.3010108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>

On 10/25/2013 06:13 AM, Tomi Valkeinen wrote:
> On 25/10/13 13:54, Nishanth Menon wrote:

[..]
> 
>>>> Could we not use Documentation/devicetree/bindings/gpio/gpio.txt
>>>> binding to map to the right GPIO and drive it using the GPIO module?
>>>
>>> Hmm, what do you mean?
>>>
>>> I do mux the pins to gpios, but there's nothing in the kernel that would
>>> use those gpios. That's why we had the hack above, but I'd love to get
>>> rid of it.
>>>
>>> Can I set the pins to GPIO mode, and set the GPIO to high/low in the .dts?
>>>
>>> If things were perfect, we probably would have a driver for the "switch"
>>> part. I have no idea what kind of driver that would be, though, so at
>>> the moment we've just gone with the use-LCD2-by-default route.
>>
>> I meant you could, in theory provide the gpio numbers and pull
>> directions in dts and allow the init to drive them as needed.
>>
>> Something like:
>> drivers/i2c/busses/i2c-gpio.c as a reference and use
>> of_get_named_gpio/of_get_gpio to pick themup..
> 
> I'm still not quite following... What init are you referring to?
> 
> The problem here is that the gpios don't really belong to anyone in the
> kernel, as we don't have a driver for the switch.
> 
> Or did you mean that we'd still have the code in dss-common.c, but just
> get the gpio numbers from the .dts instead? That makes sense, although
> I'd want to get rid of that code altogether.
> 
> Should we have support in the gpio-controller to define default values
> for gpios? I don't think we can rely on the boot loader to set things
> correctly.
> 

I am unfortunately, not in a position to know how you plan to
architect dss_common or the various panels associated with it. if you
model these as panels and a generic driver which controls the panel
could request and control pins and gpios as needed I suppose.

gpio controller cannot drive default pull direction, that is the job
of the driver using the gpio.

Simplest example that I can think of to use to point as reference is [1]

[1]
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/leds/leds-gpio.c#n173
-- 
Regards,
Nishanth Menon
