From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 0/3] gpio-twl4030: add new device tree properties
Date: Mon, 3 Sep 2012 16:28:09 +0200
Message-ID: <5044BE79.4040100@ti.com>
References: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44022 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131Ab2ICO23 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Sep 2012 10:28:29 -0400
In-Reply-To: <1346680491-4211-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

+ Vaibhav for the omap3-evm

Hi Florian,

On 09/03/2012 03:54 PM, Florian Vaussard wrote:
> A number of platform data are missing when using twl4030/gpio from a
> device tree.

Yeah, I know, I was too lazy when I did the DT conversion at that time :-)

Many thanks for completing the work.

>  This patchset adds the missing properties, updates
> existing device trees and updates the documentation of bindings.
> It mainly enables LEDA and LEDB outputs, as well as pullups /
> pulldowns on GPIOs.
> 
> The 1st patch changes the device driver.
> The 2nd patch updates the device trees for BeagleBoard and omap3-evm.
> The 3rd patch updates the documentation of bindings.

OK, that's a nit, but in general, you'd better introduce the binding
before using it.

The binding documentation could/should be updated along with the driver
change that does introduce the binding. You could just merged patch #1
and #3.

> Tested:
> - Boot tested on Gumstix Overo for "ti,use-leds". Corresponding
>   patch is not provided, as the device tree is not yet merged.
>   The support can be found in the git tree [1], branch
>   omap3-devel-dt-overo.
> - Device trees for BeagleBoard and omap3-evm were compiled, but not
>   tested on hardware.
> 
> Would someone be willing to test on BeagleBoard / omap3-evm?

I'll try to do it on Beagle. This is the least I can do since I did not
do the job myself :-)

I added vaibhav as well since I do not have any omap3-evm board.

> 
> Regards,
> Florian
> 
> [1] https://github.com/vaussard/linux.git (not safe for merge)
> 
> 
> Florian Vaussard (3):
>   gpio-twl4030: get platform data from device tree
>   gpio-twl4030: new dt properties for BeagleBoard and omap3-EVM

Nit #2: the DTS file does not belong to the gpio subsystem. So you
should prefix them using the *convention* for ARM DTS patches:

arm/dts: omap3: Add gpio-twl4030 properties for BeagleBoard and omap3-EVM

Or maybe "ARM: dts: " because it looks like most people are using that
nowadays.

The convention for the gpio directory is similar:
gpio/twl4030: get platform data from device tree

>   gpio-twl4030: updates the bindings for new dt properties
> 
>  .../devicetree/bindings/gpio/gpio-twl4030.txt      |    6 ++
>  arch/arm/boot/dts/omap3-beagle.dts                 |   20 +++++
>  arch/arm/boot/dts/omap3-evm.dts                    |   13 +++
>  drivers/gpio/gpio-twl4030.c                        |   86 +++++++++++++------
>  4 files changed, 98 insertions(+), 27 deletions(-)

Thanks,
Benoit

