From: Tony Lindgren <tony@atomide.com>
Subject: Re: [BUG] omap: mfd/regulator: twl/core: init order
Date: Tue, 16 Apr 2013 10:54:39 -0700
Message-ID: <20130416175438.GR10155@atomide.com>
References: <1365877659.3812.110.camel@mars>
 <516BD479.2020904@ti.com>
 <1366023401.957.5.camel@mars>
 <516BDDAC.8040905@ti.com>
 <20130415162541.GO10155@atomide.com>
 <516D01A4.8080301@ti.com>
 <516D0CEC.2060306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:35395 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965031Ab3DPRys (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Apr 2013 13:54:48 -0400
Content-Disposition: inline
In-Reply-To: <516D0CEC.2060306@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Christoph Fritz <chf.fritz@googlemail.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Samuel Ortiz <sameo@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree-discuss@lists.ozlabs.org, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>

* Grygorii Strashko <grygorii.strashko@ti.com> [130416 01:39]:
> On 04/16/2013 10:45 AM, Peter Ujfalusi wrote:
> >On 04/15/2013 06:25 PM, Tony Lindgren wrote:
> >>This fix should not be needed. It just means the real
> >>problem is somewhere else. Pinctrl is already before the i2c
> >>in drivers/Makefile. Maybe one of the MFD drivers has
> >>a wrong initcall level?
> >FYI; I just sent a patch which I believe is the correct way to fix this issue.
> >
> Hi Tony, Peter
> 
> OMAP i2c/pin-control initialization isn't controlled by Makefiles now (:
> - i2c initialized at subsys_initcall(omap_i2c_init_driver);

AFAIK there should be no reason to have this as subsys_initcall
any longer. It should be just regular module init.

> - pinctrl-single at module_platform_driver(pcs_driver) =>
> module_init => device_initcall (if built-in)

Yes but still, the deferred probe should handle this case too,
I wonder why we're not seeing this issue on omap4 for example?
 
> And pls, pay attention on overall BUG description - twl-regulators
> initialization has been delayed as result all Regulators consumers
> (drivers which use regulators) will need to defer it's probe correctly too.
> For now it isn't true for many drivers and, for example,
> omap_hsmmc driver's probe will just fail if it can't get regulator.
> (+ problems with DSS - most probably Panel/DSI driver probe can't
> handle pin configuration)

Sounds like there are a few places to fix. Got something available
for these?
 
> Before, on early kernel versions, the OMAP pinmux was ready to work
> at arch_initcall time
> and most of the code has been created with this assumption.

Yes. In general we've been moving to initializing things later
on rather than earlier so we have a real console available for
error messages instead of earlyprintk if something goes wrong.

BTW, the legacy omap pinmux code will be going away as soon as
we have moved platforms to use DT only booting. I think we can
make omap4 DT only after v3.10, omap3 later on.
 
> Unfortunately, RTC is just a small part of problem.

Can you try just setting the related drivers to be regular
module initcalls and see if that solves the problem?

Regards,

Tony
