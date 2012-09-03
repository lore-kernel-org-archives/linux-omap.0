From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 0/3] gpio-twl4030: add new device tree properties
Date: Mon, 03 Sep 2012 22:45:11 +0200
Message-ID: <504516D7.3060101@epfl.ch>
References: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch> <5044BE79.4040100@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.218]:52187 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753214Ab2ICUpP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Sep 2012 16:45:15 -0400
In-Reply-To: <5044BE79.4040100@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

Hi Benoit,

> Nit #2: the DTS file does not belong to the gpio subsystem. So you
> should prefix them using the *convention* for ARM DTS patches:
>
> arm/dts: omap3: Add gpio-twl4030 properties for BeagleBoard and omap3-EVM
>
> Or maybe "ARM: dts: " because it looks like most people are using that
> nowadays.
>
> The convention for the gpio directory is similar:
> gpio/twl4030: get platform data from device tree
>
>>    gpio-twl4030: updates the bindings for new dt properties
>>
>>   .../devicetree/bindings/gpio/gpio-twl4030.txt      |    6 ++
>>   arch/arm/boot/dts/omap3-beagle.dts                 |   20 +++++
>>   arch/arm/boot/dts/omap3-evm.dts                    |   13 +++
>>   drivers/gpio/gpio-twl4030.c                        |   86 +++++++++++++------
>>   4 files changed, 98 insertions(+), 27 deletions(-)
> Thanks,
> Benoit
>
Thank you for your review, I will send a new version soon.

Regards,
Florian

