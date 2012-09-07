From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH v2 0/2] gpio-twl4030: add new device tree properties
Date: Fri, 7 Sep 2012 10:55:43 +0200
Message-ID: <5049B68F.4040003@ti.com>
References: <1346831186-29947-1-git-send-email-florian.vaussard@epfl.ch> <50476496.7050107@ti.com> <20120906205123.GL1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56550 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753066Ab2IGI4B (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Sep 2012 04:56:01 -0400
In-Reply-To: <20120906205123.GL1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, Vaibhav Hiremath <hvaibhav@ti.com>, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org

On 09/06/2012 10:51 PM, Tony Lindgren wrote:
> * Benoit Cousson <b-cousson@ti.com> [120905 07:42]:
>> Hi Florian,
>>
>> On 09/05/2012 09:46 AM, Florian Vaussard wrote:
>>> Hello,
>>>
>>> A number of platform data are missing when using twl4030/gpio from a
>>> device tree. This patchset adds the missing properties, updates the 
>>> documentation with the new bindings, and updates existing device trees.
>>> It mainly enables LEDA and LEDB outputs, as well as pullups /
>>> pulldowns on GPIOs.
>>>
>>> The 1st patch changes the device driver and updates the documentation.
>>> The 2nd patch updates the device trees for BeagleBoard and omap3-evm.
>>>
>>> Changes since v1: 
>>> - Patches on driver and documentation merged into the same patch
>>> - Put device trees' values in hexadecimal
>>> - Handle bool property using of_property_read_bool()
>>> - Prefix the patches with the correct convention
>>
>> Thanks for the update.
>>
>>> Tested on Gumstix Overo. V1 was tested on omap3-evm by Vaibhav Hiremath.
>>
>> I've just tested it on beagle xM. I can play with D12 led using:
>>
>> echo 255 > /sys/class/leds/beagleboard\:\:pmu_stat/brightness
>>
>> Tested-by: Benoit Cousson <b-cousson@ti.com>
>>
>>
>>> BTW: who will merge this?
>>
>> Since Linus already acked it, Tony can merge it.
>>
>>
>> Tony,
>>
>> I can add that series in my DTS series for 3.7 if you want.
> 
> Yes please do thanks.

On top of that series, I realized that beagle was missing the other
LEDs. So I've just posted the support for the two missing ones.

[PATCH] ARM: dts: omap3-beagle: Add heartbeat and mmc LEDs support

Regards,
Benoit

