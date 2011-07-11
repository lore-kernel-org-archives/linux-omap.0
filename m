From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [RFC 0/4] TWL external controller support
Date: Mon, 11 Jul 2011 16:06:32 +0300
Message-ID: <1310389592.4331.53.camel@sokoban>
References: <1310140588-26078-1-git-send-email-t-kristo@ti.com> <20110708162531.GE31978@legolas.emea.dhcp.ti.com> <20110709012407.GG18860@opensource.wolfsonmicro.com> <20110709104007.GM31978@legolas.emea.dhcp.ti.com> <20110709105649.GA17036@opensource.wolfsonmicro.com> <1310372591.4331.27.camel@sokoban> <20110711100509.GC5092@opensource.wolfsonmicro.com> <1310381339.4331.45.camel@sokoban> <20110711121111.GL5092@opensource.wolfsonmicro.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56331 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756767Ab1GKNGh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 09:06:37 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20110711121111.GL5092@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, linux-omap@vger.kernel.org, "Girdwood, Liam" <lrg@ti.com>

On Mon, 2011-07-11 at 14:11 +0200, Mark Brown wrote:
> On Mon, Jul 11, 2011 at 01:48:59PM +0300, Tero Kristo wrote:
> > On Mon, 2011-07-11 at 12:05 +0200, Mark Brown wrote:
> 
> > > No.  Why do you want these regulators to have anything to do with the
> > > TWL4030?
> 
> > So, a completely new driver should be made for these? The reason I
> > wanted to put them within TWL4030 code is that they reside inside
> > TWL4030, and there is already some code for accessing these regulators
> > (in the standard I2C access method) from the twl-regulator.c.
> 
> Well, if they're not perceptibly part of the same chip from a control
> point of view and need you to provide board specific callbacks it would
> seem logical...

Ok sounds fair enough, I'll rework this series to something like this
and re-post for commenting once I hear from Graeme also. I'll add a
compile time switch (or most likely use something existing) for
selecting which implementation to use for VDD1 and VDD2.

Thanks for comments.

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

