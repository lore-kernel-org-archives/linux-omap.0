From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH 3/7] mfd: menelaus: add initial DT support
Date: Mon, 29 Dec 2014 01:34:45 +0200
Message-ID: <20141228233445.GD582@fuloong-minipc.musicnaut.iki.fi>
References: <1419702779-16001-1-git-send-email-aaro.koskinen@iki.fi>
 <1419702779-16001-4-git-send-email-aaro.koskinen@iki.fi>
 <20141227212553.GA21729@saruman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:52973 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaL1Xey (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Dec 2014 18:34:54 -0500
Content-Disposition: inline
In-Reply-To: <20141227212553.GA21729@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Sat, Dec 27, 2014 at 03:25:53PM -0600, Felipe Balbi wrote:
> On Sat, Dec 27, 2014 at 07:52:55PM +0200, Aaro Koskinen wrote:
> > Add initial DT support.
> > 
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > ---
> >  Documentation/devicetree/bindings/mfd/menelaus.txt | 30 +++++++++++++
> >  drivers/mfd/menelaus.c                             | 52 ++++++++++++++++++++--
> >  2 files changed, 78 insertions(+), 4 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/menelaus.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/menelaus.txt b/Documentation/devicetree/bindings/mfd/menelaus.txt
> > new file mode 100644
> > index 0000000..5f69f23
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/menelaus.txt
> > @@ -0,0 +1,30 @@
> > +Menelaus (Texas Instruments TWL92330) Power Management chip
> > +
> > +Menelaus provides facilities to control the power resources.
> > +
> > +Required properties:
> > +- compatible: must be "menelaus"
> > +- reg: I2C address of the chip
> > +
> > +Optional properties:
> > +- interrupts: the interrupt
> > +- ti,autosleep: All regulators are put to sleep by default.
> > +- ti,vcore-min-microvolt: Range floor for the HW controlled VCORE
> > +- ti,vcore-max-microvolt: Range roof for the HW controlled VCORE
> > +
> > +The use of ti,autosleep is recommended at least on Nokia N800/N810.
> > +
> > +Example:
> > +
> > +&i2c1 {
> > +	clock-frequency = <400000>;
> > +
> > +	pmic@72 {
> > +		compatible = "menelaus";
> > +		reg = <0x72>;
> > +		interrupts = <7 IRQ_TYPE_EDGE_RISING>;
> > +		ti,autosleep;
> > +		ti,vcore-min-microvolt = <1050000>;
> > +		ti,vcore-max-microvolt = <1400000>;
> 
> looks like these should be first converted to actual regulators
> otherwise we will have to maintain this binding forever which means that
> any effort of adding regulator fwk support for menelaus will become a
> lot more difficult because it'll have to cope with the legacy/bogus
> binding.

I was thinking such conversion could be done with incremental patches...
There's basically only one board (n8x0) that uses this and not likely
to be any others. Is there a way to declare bindings unstable?

> I started doing irqchip/irqdomain conversion but I don't have where to
> test and got side-tracked by other stuff. I'll see if I can restart that
> work early next year.
> 
> Then, if you change your series so that first you add proper regulator
> fwk support, we should be pretty good with menelaus.

Ok, let's see.

A.
