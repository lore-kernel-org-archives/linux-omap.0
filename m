From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Trying to understand how to use regulator supplies
Date: Wed, 10 Feb 2010 19:21:06 +0000
Message-ID: <20100210192106.GG27173@sirena.org.uk>
References: <738b3f7e1002101107k4deaeec9ka6c2bc91348289a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:50985 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab0BJTVI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 14:21:08 -0500
Content-Disposition: inline
In-Reply-To: <738b3f7e1002101107k4deaeec9ka6c2bc91348289a8@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter.barada@gmail.com>
Cc: linux-omap@vger.kernel.org, lrg@slimlogic.co.uk

On Wed, Feb 10, 2010 at 02:07:04PM -0500, Peter Barada wrote:
> I've got a OMAP3530 board with a tsc2004 touch controller that is
> powered off of VAUX1(VAUX1_30 on my schematic) at 3V, and I'm trying to
> understand how to code it up so that vaux1 power comes up before the i2c
> code tries to probe for the touch controller.

You really should ask this question on linux-kernel and/or CC the
regulator API maintainers - there's nothing OMAP specific here.

> static struct regulator_init_data omap3logic_vaux1 = {
>         .constraints = {
>                 .min_uV                 = 3000000,
>                 .max_uV                 = 3000000,
>                 .name                   = "VAUX1_30"
>                 .apply_uV               = true,
>                 .valid_modes_mask       = REGULATOR_MODE_NORMAL
>                                         | REGULATOR_MODE_STANDBY,
>                 .valid_ops_mask         = REGULATOR_CHANGE_MODE
>                                         | REGULATOR_CHANGE_STATUS,
>         },
> };

> as well as a corresponding:

>         .vaux1          = &omap3logic_vaux1,

> in the twl4030_platform_data structure, but the voltage doesn't come up.
> How do I tell the kernel to turn on vaux1 so I can detect the tsc2004
> chip?

If you want to do it purely via constraints set always_on (and drop the
CHANGE_STATUS option) though ideally the driver for the chip would have
regulator support and be set as a consumer, in which case it would get()
and enable() the supplies it needs before interacting with the chip.
The constraints you have set above allow drivers to turn on the power
but will leave it in the default state unless any of them do so.

Explicit support in the driver would allow it to disable the supplies
while the touchscreen is not in use, saving some power.
