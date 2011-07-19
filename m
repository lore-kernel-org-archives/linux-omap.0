From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 3/6] regulator: omap smps regulator driver
Date: Tue, 19 Jul 2011 18:52:56 +0300
Message-ID: <1311090776.10230.68.camel@sokoban>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com> <1311010522-5868-4-git-send-email-t-kristo@ti.com> <20110719153818.GJ9652@opensource.wolfsonmicro.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44647 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481Ab1GSPxC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jul 2011 11:53:02 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20110719153818.GJ9652@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, "Hilman, Kevin" <khilman@ti.com>, tony@atomide.com, toddpoynor@google.com, "Girdwood, Liam" <lrg@ti.com>

On Tue, 2011-07-19 at 17:38 +0200, Mark Brown wrote:
> On Mon, Jul 18, 2011 at 08:35:19PM +0300, Tero Kristo wrote:
> > OMAP SMPS regulator driver provides access to OMAP voltage processor
> > controlled regulators. These include VDD_MPU and VDD_CORE for OMAP3 and
> > additionally VDD_IVA for OMAP4. SMPS regulators use the OMAP voltage
> > layer for the actual voltage regulation operations.
> 
> 
> > +config REGULATOR_OMAP_SMPS
> > +	tristate "TI OMAP SMPS Power Regulators"
> > +	depends on (ARCH_OMAP3 || ARCH_OMAP4) && PM && TWL4030_CORE
> 
> Why does this depend on TWL4030_CORE or PM?

Oh forgot that one, TWL_CORE can be removed, PM must be there because
the depending libraries are only built when PM is enabled.



Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

