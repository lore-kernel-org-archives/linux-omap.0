From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 3/5] gpio/omap: Add DT support to GPIO driver
Date: Tue, 26 Feb 2013 09:33:24 -0700
Message-ID: <512CE3D4.7040101@wwwdotorg.org>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com> <1329321854-24490-4-git-send-email-b-cousson@ti.com> <4F44FA56.7020000@gmail.com> <4F44FC37.2000701@ti.com> <4F452484.5080503@gmail.com> <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC6C1@HQMAIL01.nvidia.com> <4F47AD08.4030504@ti.com> <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:47065 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495Ab3BZQd2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Feb 2013 11:33:28 -0500
In-Reply-To: <CAAwP0s0cB368R2mtbJpTZJreR-5GSRLfxC+8DJLo5nw3_OwBuA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 02/26/2013 03:01 AM, Javier Martinez Canillas wrote:
...
> I was wondering if the level/edge settings for gpios is working on OMAP.
...
> Reading the gpio-omap.txt documentation it says that #interrupt-cells
> should be <2> and that a value of 8 is "active low level-sensitive".
> 
> So I tried this:
> 
> &gpmc {
> 	ethernet@5,0 {
...
> 		interrupt-parent = <&gpio6>;
> 		interrupts = <16 8>; /* gpio line 176 */
> 		interrupt-names = "smsc911x irq";
...
> 
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
...
>                         #interrupt-cells = <1>;
...
> So, even when the documentation says that all the GPIO device nodes in
> OMAP2+ should use a #interrupt-cells property value of <2>, they are
> only using <1>. Changing that value to 2 makes hangs the kernel and it
> does not boot.

Take a look at what the OMAP GPIO driver is plugging in for the of_xlate
function; does it correctly handle the case where there are two cells?

Is there a default for the flags when no second cell is provided, such
that when you set #interrupt-cells to <2>, you're changing away from the
default and mis-configuring things?

And, did you check for any other interrupts hooked through the GPIO
module, for which you'll need to add the second cell into their GPIO
specifier throughout the entire device tree?
