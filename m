From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFC 0/4] TWL external controller support
Date: Mon, 11 Jul 2011 11:23:11 +0300
Message-ID: <1310372591.4331.27.camel@sokoban>
References: <1310140588-26078-1-git-send-email-t-kristo@ti.com> <20110708162531.GE31978@legolas.emea.dhcp.ti.com> <20110709012407.GG18860@opensource.wolfsonmicro.com> <20110709104007.GM31978@legolas.emea.dhcp.ti.com> <20110709105649.GA17036@opensource.wolfsonmicro.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58984 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757350Ab1GKIXR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 04:23:17 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20110709105649.GA17036@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, linux-omap@vger.kernel.org, "Girdwood, Liam" <lrg@ti.com>

On Sat, 2011-07-09 at 12:56 +0200, Mark Brown wrote:
> On Sat, Jul 09, 2011 at 01:40:08PM +0300, Felipe Balbi wrote:
> 
> > a hack for a hack... what's the difference ? If it's only to solve a
> > limitation temporarily anyways... although it would be better to discuss
> > how to add such support to the framework already.
> 
> I'm completely unable to identify an issue in the framework that this
> patch addresses - the API already supports multiple devices supplying
> regulators, it's extremely difficult to understand what motivates the
> change.

Hi,

So if I understood the comments right, what you are saying is that I
should probably implement a new regulator subset for the twl-regulator.
I.e. we have currently TWL4030_ADJUSTABLE_LDO etc., so I could add a
TWL4030_ADJUSTABLE_SMPS for example. These regulators would then use the
appropriate interface according to board specific setup. How would you
propose to use / register the alternate ops to access the omap_voltage
layer from here though for set/get voltage?

The main thing is that VDD1 and VDD2 regulators in TWL4030 can be
controlled through the typical TWL control interface (I2C), like the
rest of the TWL regulators, or it can be controlled through the voltage
processor interface which uses a dedicated I2C bus and is not accessible
to anything but the voltage processor. The used interface can be
configured from the TWL side. The voltage processor support is currently
provided by the omap platform code, and regulator code knows nothing
about this. It might also be possible to do compile time switch for the
interface here if that is acceptable, however a runtime interface for
doing this would provide more flexibility.

I'll also contact Graeme and check what he is doing on this front.

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

