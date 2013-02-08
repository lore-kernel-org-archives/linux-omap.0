From: "AnilKumar" <anilk4.v@gmail.com>
Subject: RE: [PATCH] ARM: dts: add minimal DT support for DevKit8000
Date: Fri, 8 Feb 2013 19:05:32 +0530
Message-ID: <007b01ce0601$2f46b4e0$8dd41ea0$@gmail.com>
References: <1360246297-5500-1-git-send-email-anilk4.v@gmail.com> <20130207173949.GA21723@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130207173949.GA21723@e106331-lin.cambridge.arm.com>
Content-Language: en-in
Sender: linux-kernel-owner@vger.kernel.org
To: 'Mark Rutland' <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux@arm.linux.org.uk, b-cousson@ti.com, tony@atomide.com, grant.likely@secretlab.ca, thomas@tomweber.eu
List-Id: linux-omap@vger.kernel.org

Hi Mark,

Thanks for the review comments. Please find my comments inline.

On Thu, Feb 07, 2013 at 23:09:49, Mark Rutland wrote:
> Hello,
> 
> I have a couple of minor comments.
> 
> On Thu, Feb 07, 2013 at 02:11:37PM +0000, Anil Kumar wrote:
> > DevKit8000 is a beagle board clone from Timll, sold by armkits.com.
> > The DevKit8000 has RS232 serial port, LCD, DVI-D, S-Video, Ethernet, 
> > SD/MMC, keyboard, camera, SPI, I2C, USB and JTAG interface.
> >
> > This patch adds the basic DT support for devkit8000. At this time, 
> > Information of twl4030, MMC1, I2C1, leds and there pim mux 
> > information are
> added.
> >
> > Signed-off-by: Anil Kumar <anilk4.v@gmail.com>
> > Tested-by: Thomas Weber <thomas@tomweber.eu>
> > ---
> >
> >  -This patch is based on top of kernel 3.8-rc5.
> >
> >  -Tested on Devkit8000.
> >
> 
> [...]
> 
> > diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts
> > b/arch/arm/boot/dts/omap3-devkit8000.dts
> > new file mode 100644
> > index 0000000..9864fd7
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/omap3-devkit8000.dts
> > @@ -0,0 +1,125 @@
> > +/*
> > + * Anil Kumar <anilk4.v@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or 
> > +modify
> > + * it under the terms of the GNU General Public License version 2 
> > +as
> > + * published by the Free Software Foundation.
> > + */
> > +/dts-v1/;
> > +
> > +/include/ "omap3.dtsi"
> > +/ {
> > +	model = "TI OMAP3 Devkit8000";
> 
> Should this not be "TimLL Devkit8000" ?

Hmm..  I think it will be better as  "TimLL OMAP3 Devkit8000"  as this board
is omap3 based.

> 
> > +	compatible = "ti,omap3-devkit8000", "ti,omap3";
> 
> "timll,devkit8000" ?

I think it will be better  as  "timll,omap3-devkit8000"  as this board is
omap3 based.
 
Thanks,
Anil
[...]
