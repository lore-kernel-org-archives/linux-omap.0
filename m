From: Tony Lindgren <tony@atomide.com>
Subject: Re: [BUG] omap: mfd/regulator: twl/core: init order
Date: Mon, 15 Apr 2013 09:25:42 -0700
Message-ID: <20130415162541.GO10155@atomide.com>
References: <1365877659.3812.110.camel@mars>
 <516BD479.2020904@ti.com>
 <1366023401.957.5.camel@mars>
 <516BDDAC.8040905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57007 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751385Ab3DOQ0D (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Apr 2013 12:26:03 -0400
Content-Disposition: inline
In-Reply-To: <516BDDAC.8040905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Liam Girdwood <lrg@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree-discuss@lists.ozlabs.org, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>

* Grygorii Strashko <grygorii.strashko@ti.com> [130415 04:05]:
> On 04/15/2013 01:56 PM, Christoph Fritz wrote:
> >On Mon, 2013-04-15 at 13:20 +0300, Grygorii Strashko wrote:
> >>--- a/drivers/pinctrl/pinctrl-single.c
> >>+++ b/drivers/pinctrl/pinctrl-single.c
> >>@@ -1014,7 +1014,18 @@ static struct platform_driver pcs_driver = {
> >>          },
> >>   };
> >>
> >>-module_platform_driver(pcs_driver);
> >>+static int __init pcs_driver_drv_init(void)
> >>+{
> >>+       return platform_driver_register(&pcs_driver);
> >>+}
> >>+postcore_initcall(pcs_driver_drv_init);
> >>+
> >>+static void __exit pcs_driver_drv_exit(void)
> >>+{
> >>+       platform_driver_unregister(&pcs_driver);
> >>+}
> >>+module_exit(pcs_driver_drv_exit);
> >>+
> >Hi Grygorii,
> >  thanks - indeed it does fix the problem. I checked at least the rtc
> >which is now configured right and working :-)
> >
> >Do you consider the patch above as a hack or will it go mainline?
> I think, need more opinions on this from community )
> I'm just trying to solve my problem and found similar issue.

This fix should not be needed. It just means the real
problem is somewhere else. Pinctrl is already before the i2c
in drivers/Makefile. Maybe one of the MFD drivers has
a wrong initcall level?

Regards,

Tony
