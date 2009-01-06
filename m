From: "Pillai, Manikandan" <mani.pillai@ti.com>
Subject: RE: [PATCH 1/2] TPS6235x based Power regulator support added
Date: Tue, 6 Jan 2009 15:43:13 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403ECEDD448@dbde02.ent.ti.com>
References: <1229421966-11414-1-git-send-email-mani.pillai@ti.com>
 <20081217173503.GF22204@sirena.org.uk>
 <19F8576C6E063C45BE387C64729E739403ECEDD319@dbde02.ent.ti.com>
 <20090106100003.GA6783@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34938 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbZAFKN2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 05:13:28 -0500
In-Reply-To: <20090106100003.GA6783@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


-----Original Message-----
From: Mark Brown [mailto:broonie@sirena.org.uk] 
Sent: Tuesday, January 06, 2009 3:30 PM
To: Pillai, Manikandan
Cc: linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/2] TPS6235x based Power regulator support added

On Tue, Jan 06, 2009 at 10:11:42AM +0530, Pillai, Manikandan wrote:

> Except the comment from Mark, I have so far not received any comments on
> these patch set of 2 for TPS6235x support. As attached below, there are problems
> with implementing Mark's comments. Suggestions are welcome.

The consumer data should be passed into the driver as platform-specific
data and passed straight through to the regulator API.  The struct
devices that are used in the consumer array should be those for the
consumer devices so the regulator driver is not in a position to know
what the appropriate device to use is.
[Pillai, Manikandan] The consumer data is being passed through the struct tps_6235x_i2c_board_info in board specific file board-omap3evm.c.
But for struct regulator_consumer_supply tps62352_core_consumers the
Member dev needs to be inited. .dev is not available at this point of time.
If dev is not initialized, the regulator_register() is failing.

Both tps62352_core_consumers and tps62352_mpu_consumers and their I2C
addresses are board specific - if references to them are included in
your driver then other boards will not be able to use your driver. 
[Pillai, Manikandan] Agreed - this makes the driver unusable for other boards.

