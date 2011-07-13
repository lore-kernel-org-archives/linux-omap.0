From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv2 2/5] regulator: omap smps regulator driver
Date: Wed, 13 Jul 2011 18:53:45 +0300
Message-ID: <1310572425.4331.96.camel@sokoban>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com> <1310565638-13140-3-git-send-email-t-kristo@ti.com> <20110713144019.GA7861@opensource.wolfsonmicro.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43357 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754596Ab1GMPyx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 11:54:53 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <20110713144019.GA7861@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, "Girdwood, Liam" <lrg@ti.com>, "Hilman, Kevin" <khilman@ti.com>

On Wed, 2011-07-13 at 16:40 +0200, Mark Brown wrote:
> On Wed, Jul 13, 2011 at 05:00:35PM +0300, Tero Kristo wrote:
> 
> > +config REGULATOR_OMAP_SMPS
> > +	tristate "TI OMAP SMPS Power Regulators"
> > +	depends on (ARCH_OMAP3 || ARCH_OMAP4) && PM && TWL4030_CORE
> 
> What is the dependency on the TWL4030?  I see no references to it in the
> code...

Hmm, true... I was mainly thinking about the HW setup where we usually
have a TWL family chip which is controlled by the SMPS regulator driver.
I think that one can actually be dropped as it might be possible to use
some other power IC behind the SMPS channels. I think I'll remove all
the references to TWL4030 / TWL6030 from this patch.

> 
> > +	for (i = 0; i < pdata->num_regulators; i++) {
> > +		initdata = pdata->regulators[i];
> > +
> 
> I do strongly prefer the idiom of just registering all the regulators
> even if they're read only.

Number of available SMPS regulators is kind of board specific issue.
OMAP3 has 2 available, OMAP4 has 3. If we are using some custom powering
solution, we might have even different amounts for these.

> 
> > +		c = &initdata->constraints;
> > +		c->valid_modes_mask &= REGULATOR_MODE_NORMAL;
> > +		c->valid_ops_mask &= REGULATOR_CHANGE_VOLTAGE;
> > +		c->always_on = true;
> 
> No, this is bad.  We *always* pay attention to the constraints the user
> set even if they're nuts or won't work, the machine driver has the final
> say on what is or isn't allowed on a given board.  The mode setting is
> especially suspect as there's no mode support in the driver.

Just a clarification on this one that I have understood your comment
right... Do you mean that I should be checking the constraints user sets
more thoroughly to see if there is something bogus? I was looking at
some of the other regulator drivers and they seem to be fiddling with
the constraints in similar manner.

-Tero


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

