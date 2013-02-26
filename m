From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Tue, 26 Feb 2013 16:40:26 -0600
Message-ID: <512D39DA.7020306@ti.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <1329321854-24490-4-git-send-email-b-cousson@ti.com> <4F44FA56.7020000@gmail.com> <4F44FC37.2000701@ti.com> <4F452484.5080503@gmail.com> <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com> <4F47AD08.4030504@ti.com> <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60805 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029Ab3BZWkg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Feb 2013 17:40:36 -0500
In-Reply-To: <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Rob Herring <robherring2@gmail.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>


On 02/26/2013 04:01 AM, Javier Martinez Canillas wrote:

[snip]

> I was wondering if the level/edge settings for gpios is working on OMAP.
> 
> I'm adding DT support for an SMSC911x ethernet chip connected to the
> GPMC for an OMAP3 SoC based board.
> 
> In the smsc911x driver probe function (smsc911x_drv_probe() in
> drivers/net/ethernet/smsc/smsc911x.c), a call to request_irq() with
> the flag IRQF_TRIGGER_LOW is needed because of the wiring on my board.
> 
> Reading the gpio-omap.txt documentation it says that #interrupt-cells
> should be <2> and that a value of 8 is "active low level-sensitive".
> 
> So I tried this:
> 
> &gpmc {
> 	ethernet@5,0 {
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&smsc911x_pins>;
> 		compatible = "smsc,lan9221", "smsc,lan9115";
> 		reg = <5 0 0xff>; /* CS5 */
> 		interrupt-parent = <&gpio6>;
> 		interrupts = <16 8>; /* gpio line 176 */
> 		interrupt-names = "smsc911x irq";
> 		vmmc-supply = <&vddvario>;
> 		vmmc_aux-supply = <&vdd33a>;
> 		reg-io-width = <4>;
> 
> 		smsc,save-mac-address;
>       };
> };

Are you requesting the gpio anywhere? If not then this is not going to
work as-is. This was discussed fairly recently [1] and the conclusion
was that the gpio needs to be requested before we can use as an interrupt.

I have not seen your latest smsc code for omap, but when you are
requesting the gpmc chip-select you should also request the gpio.

> But in the smsc911x probe function:
> 
> irq_res->flags & IRQF_TRIGGER_MASK;
> 
> returns 0 which means that no trigger flags where set.
> 
> I took a look to the GPIOs device node definition on omap{3,4,5}.dtsi
> and all look like this:
> 
> e.g from omap3.dtsi:
> 
>                 gpio6: gpio@49058000 {
>                         compatible = "ti,omap3-gpio";
>                         ti,hwmods = "gpio6";
>                         gpio-controller;
>                         #gpio-cells = <2>;
>                         interrupt-controller;
>                         #interrupt-cells = <1>;
>                 };
> 
> So, even when the documentation says that all the GPIO device nodes in
> OMAP2+ should use a #interrupt-cells property value of <2>, they are
> only using <1>. Changing that value to 2 makes hangs the kernel and it
> does not boot.

I will need to take a look at that. Is your code available anywhere so I
can test?

Cheers
Jon

[1] http://permalink.gmane.org/gmane.linux.ports.arm.omap/92192
