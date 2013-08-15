From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
Subject: Re: [PATCH v4 0/4] ARM: OMAP2+: AM33XX: VDD CORE OPP50 support
Date: Thu, 15 Aug 2013 10:00:40 +0200
Message-ID: <1376553640.3889.70.camel@coredoba.hi.pengutronix.de>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
	 <1376487480.3889.64.camel@coredoba.hi.pengutronix.de>
	 <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44733 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754321Ab3HOH7k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Aug 2013 03:59:40 -0400
In-Reply-To: <CA+Bv8XYe0UzBkjqtO7bNkgNVTQtxiM7Hv93BOu8Lw1=pESOwLA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, devicetree@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 2013-08-14 at 15:21 -0700, Russ Dill wrote:
> > The CM3 driver needs to figure out where the core regulator is connected
> > using using either DT or the regulator framework and ask the TPS (via a
> > new interface) for register writes for sleep/wake sequences. Then those
> > sequences will actually match the correct voltages configured using
> > DT/DVFS.
> 
> That seems like it'd add a lot of complexity to the regulator
> subsystem, as well as all the PMIC and other I2C regulators that any
> users of these device tree properties may end up using for not a lot
> of gain. There would be two separate code paths for any used
> I2C regulator or PMIC for setting voltages.

Yes, it would be additional complexity, but it would avoid duplicating
information which is already in the DT (location&address of the PMIC,
type of pmic) and in the kernel (how to program voltages for a given
regulator). As DT is supposed to describe the hardware, duplicate
information should be unnecessary.

One different way to look at this is that the CM3 firmware is a separate
consumer of the DT. DT being OS-indepentent, the CM3 firmware should be
able to get all the information it needs from the DT (maybe with help
from the CM3 driver).

Regards,
Jan 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

