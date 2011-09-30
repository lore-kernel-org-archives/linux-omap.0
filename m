From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract
 regulator_init_data
Date: Fri, 30 Sep 2011 11:48:20 +0100
Message-ID: <20110930104820.GE2085@sirena.org.uk>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
 <1317118372-17052-3-git-send-email-rnayak@ti.com>
 <20110927121003.GB4289@opensource.wolfsonmicro.com>
 <4E81E224.2070408@ti.com>
 <20110927150511.GM4289@opensource.wolfsonmicro.com>
 <4E854532.6080605@ti.com>
 <20110930102849.GA4195@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:35830 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755493Ab1I3KsZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Sep 2011 06:48:25 -0400
Content-Disposition: inline
In-Reply-To: <20110930102849.GA4195@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: b-cousson@ti.com, patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org

On Fri, Sep 30, 2011 at 11:28:49AM +0100, Mark Brown wrote:
> On Fri, Sep 30, 2011 at 09:57:30AM +0530, Rajendra Nayak wrote:

>>>> +  init_data->supply_regulator = (char *)of_get_property(dev->of_node,
>>>> +                                          "regulator-supplies", NULL);

> > Mark, I still seem to be a little confused with this one as to why
> > we would need a phandle *and* a supply-name to reference a parent
> > regulator/supply.
> > The phandle would point to a regulator dt node and that node internally
> > would have just one name associated with it.

> To repeat: the supply name is for the consumer.  It is needed so that
> the consumer can tell which supply is provided by which regulator.
> Almost all devices have more than one supply and if the device does
> anything more complicated than just turning on all the supplies when the
> device is active it's going to need to figure out which supply is which.

Hang on, I now have no idea what this is supposed to be doing.  Later on
in the series you had examples in your commit logs with perfectly
sensible bindings for supplies:

                vmmc-supply = <&regulator1>;
                vpll-supply = <&regulator1>;

which have both a unique name and a direct reference to the supplying
regulator.  What are these "regulator-supplies" properties supposed to
be?
