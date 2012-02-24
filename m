From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and
 vdd3 regulators
Date: Fri, 24 Feb 2012 16:25:12 +0200
Message-ID: <1330093512.4102.552.camel@sokoban>
References: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
	 <20120223153422.GF4553@opensource.wolfsonmicro.com>
	 <1330076289.4102.517.camel@sokoban>
	 <20120224114940.GB5450@opensource.wolfsonmicro.com>
	 <1330089398.4102.539.camel@sokoban>
	 <20120224132408.GF5450@opensource.wolfsonmicro.com>
	 <1330091765.4102.547.camel@sokoban>
	 <20120224140109.GG5450@opensource.wolfsonmicro.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60135 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248Ab2BXOZV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Feb 2012 09:25:21 -0500
In-Reply-To: <20120224140109.GG5450@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Kevin Hilman <khilman@ti.com>

On Fri, 2012-02-24 at 14:01 +0000, Mark Brown wrote:
> On Fri, Feb 24, 2012 at 03:56:05PM +0200, Tero Kristo wrote:
> 
> > So, do you want me to also change the num_voltages value for the
> > regulator from zero to be the same as max_uV, as we have this check
> > within regulator/core:
> 
> >        if (!ops->list_voltage || selector >= rdev->desc->n_voltages)
> >                 return -EINVAL;
> 
> > This will also potentially make some code to iterate over regulator
> > voltages for ~1.5M times. I still don't think adding list_voltage for
> > the SMPS regulators makes any sense, unless either the API for
> > regulator_list_voltage is changed, or we change the control for these
> > regulators completely from set_voltage() based to set_voltage_sel()
> > based implementation.
> 
> Well, the important thing here is to fill in something useful for the
> returned selector rather than just leaving it undefined.  Providing a
> list_voltage() would be nice and make things more robust.

Still, setting selector in this case does nothing, as it is immediately
overwritten by the regulator core by -1. This looks like a perfectly
acceptable way to implement a regulator, as everything checks for the
presence of list_voltage anyway.

If you really insist, I could probably make something that does a
list_voltage and shows min and max voltages for the regulator, but I
don't know about the usefulness of that.

-Tero

