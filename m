From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv5 1/4] regulator: omap smps regulator driver
Date: Wed, 28 Sep 2011 09:49:21 +0300
Message-ID: <1317192561.4369.1.camel@sokoban>
References: <1314803478-15634-1-git-send-email-t-kristo@ti.com> <1314803478-15634-2-git-send-email-t-kristo@ti.com> <87bou5zr5g.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38710 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524Ab1I1GuV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Sep 2011 02:50:21 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <87bou5zr5g.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Todd Poynor <toddpoynor@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Girdwood, Liam" <lrg@ti.com>, Graeme Gregory <gg@slimlogic.co.uk>

On Tue, 2011-09-27 at 22:06 +0200, Hilman, Kevin wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > OMAP SMPS regulator driver provides access to OMAP voltage processor
> > controlled regulators. These include VDD_MPU and VDD_CORE for OMAP3 and
> > additionally VDD_IVA for OMAP4. SMPS regulators use the OMAP voltage
> > layer for the actual voltage regulation operations.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Todd Poynor <toddpoynor@google.com>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: Liam Girdwood <lrg@ti.com>
> > Cc: Graeme Gregory <gg@slimlogic.co.uk>
> 
> I believe this was already ack'd by Mark.  Have there been any
> significan changes since then?

Just the consumer supply naming was changed for this.

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

