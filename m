From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [BUG] omap: mfd/regulator: twl/core: init order
Date: Tue, 16 Apr 2013 11:33:48 +0300
Message-ID: <516D0CEC.2060306@ti.com>
References: <1365877659.3812.110.camel@mars> <516BD479.2020904@ti.com> <1366023401.957.5.camel@mars> <516BDDAC.8040905@ti.com> <20130415162541.GO10155@atomide.com> <516D01A4.8080301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38694 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139Ab3DPIet (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Apr 2013 04:34:49 -0400
In-Reply-To: <516D01A4.8080301@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Christoph Fritz <chf.fritz@googlemail.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Samuel Ortiz <sameo@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, devicetree-discuss@lists.ozlabs.org, Daniel Mack <daniel@zonque.org>, "Hans J. Koch" <hjk@hansjkoch.de>

On 04/16/2013 10:45 AM, Peter Ujfalusi wrote:
> On 04/15/2013 06:25 PM, Tony Lindgren wrote:
>> This fix should not be needed. It just means the real
>> problem is somewhere else. Pinctrl is already before the i2c
>> in drivers/Makefile. Maybe one of the MFD drivers has
>> a wrong initcall level?
> FYI; I just sent a patch which I believe is the correct way to fix this issue.
>
Hi Tony, Peter

OMAP i2c/pin-control initialization isn't controlled by Makefiles now (:
- i2c initialized at subsys_initcall(omap_i2c_init_driver);
- pinctrl-single at module_platform_driver(pcs_driver) => module_init => 
device_initcall (if built-in)

And pls, pay attention on overall BUG description - twl-regulators
initialization has been delayed as result all Regulators consumers
(drivers which use regulators) will need to defer it's probe correctly too.
For now it isn't true for many drivers and, for example,
omap_hsmmc driver's probe will just fail if it can't get regulator.
(+ problems with DSS - most probably Panel/DSI driver probe can't handle 
pin configuration)

Before, on early kernel versions, the OMAP pinmux was ready to work at 
arch_initcall time
and most of the code has been created with this assumption.

Unfortunately, RTC is just a small part of problem.

-grygorii
