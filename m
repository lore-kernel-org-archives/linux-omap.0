From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] TPS6235x based Power regulator support added
Date: Tue, 6 Jan 2009 10:00:07 +0000
Message-ID: <20090106100003.GA6783@sirena.org.uk>
References: <1229421966-11414-1-git-send-email-mani.pillai@ti.com> <20081217173503.GF22204@sirena.org.uk> <19F8576C6E063C45BE387C64729E739403ECEDD319@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2672 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbZAFKAZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 05:00:25 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403ECEDD319@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pillai, Manikandan" <mani.pillai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Jan 06, 2009 at 10:11:42AM +0530, Pillai, Manikandan wrote:

> Except the comment from Mark, I have so far not received any comments on
> these patch set of 2 for TPS6235x support. As attached below, there are problems
> with implementing Mark's comments. Suggestions are welcome.

The consumer data should be passed into the driver as platform-specific
data and passed straight through to the regulator API.  The struct
devices that are used in the consumer array should be those for the
consumer devices so the regulator driver is not in a position to know
what the appropriate device to use is.

Both tps62352_core_consumers and tps62352_mpu_consumers and their I2C
addresses are board specific - if references to them are included in
your driver then other boards will not be able to use your driver. 
