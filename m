From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Tue, 26 Feb 2013 17:08:44 -0600
Message-ID: <512D407C.6090006@ti.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <1329321854-24490-4-git-send-email-b-cousson@ti.com> <4F44FA56.7020000@gmail.com> <4F44FC37.2000701@ti.com> <4F452484.5080503@gmail.com> <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com> <4F47AD08.4030504@ti.com> <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51471 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753029Ab3BZXIx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Feb 2013 18:08:53 -0500
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

By the way, reg-io-width for omap does not look correct. The GPMC only
supports 8-bit or 16-bit devices IIRC. I believe all my omap boards use
16-bit.

Cheers
Jon
