From: Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH 07/13] Documentation: devicetree: add bindings for TI
 PRUSS
Date: Mon, 30 Jun 2014 21:36:52 +0200
Message-ID: <20140630193651.GA78749@localhost>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
 <1404058907-21112-8-git-send-email-a.heider@gmail.com>
 <20140630093332.GT7262@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:65089 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbaF3Tg7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jun 2014 15:36:59 -0400
Content-Disposition: inline
In-Reply-To: <20140630093332.GT7262@leverpostej>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, Jun 30, 2014 at 10:33:32AM +0100, Mark Rutland wrote:
> On Sun, Jun 29, 2014 at 05:21:41PM +0100, Andre Heider wrote:
> > diff --git a/Documentation/devicetree/bindings/misc/ti,pruss.txt b/Documentation/devicetree/bindings/misc/ti,pruss.txt
> > new file mode 100644
> > index 0000000..4eacc41
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/ti,pruss.txt
> > @@ -0,0 +1,19 @@
> > +TI Programmable Real-Time Unit Sub System (PRUSS)
> > +
> > +Required properties:
> > +- compatible :
> > +	- "ti,pruss-v1" - for PRUv1 as found on the OMAPL138/DA850/AM18xx SoC families
> > +	- "ti,pruss-v2" - for PRUv2 as found on the AM33xx SoC family
> > +- ti,hwmods: Name of the hwmod associated to the PRUSS
> > +- reg: Address range of rtc register set

Just noticed the "rtc" c&p error, will fix that.

> > +- interrupts: host event interrupts in order
> 
> How many of these do we expect?

Exactly 8, which correspond to the /dev/uio* devices the driver creates.
I'll change that to make it clear.

Additionally, the driver currently expects those 8 to be sequential.
In fact, it just gets the first irq and increments from there on, I'll
add a patch to the series to improve that too.

> > +- interrupt-parent: phandle for the interrupt controller
> > +
> > +Example:
> > +pruss: pruss@4a300000 {
> > +	compatible = "ti,pruss-v2";
> > +	ti,hwmods = "pruss";
> > +	reg = <0x4a300000 0x080000>;
> > +	interrupts = <20 21 22 23 24 25 26 27>;
> 
> Assuming these represent more than one interrupt, could you please
> bracket them individually? e.g.
> 
> 	interrupts = <20 21>, <22 23>, <24 25>, <26 27>;
> 
> It makes it far clearer that it's a list of multi-cell elements rather
> than a giant binary blob, and usually makes it easier to read a dts.

This interrupt controller has one cell, so I assume you meant:

	interrupts = <20>, <21>, <22>, <23>, <24>, <25>, <26>, <27>;

I can do that, but it would be out of line with the rest on the file. The
audio devices are the only ones using that format, but they also got
"interrupt-names".

Thanks,
Andre
