From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] Include TPS6235x based Power regulator support
Date: Wed, 14 Jan 2009 11:48:51 +0000
Message-ID: <20090114114850.GB24895@sirena.org.uk>
References: <1231832468-7132-1-git-send-email-mani.pillai@ti.com> <200901131619.28700.david-b@pacbell.net> <19F8576C6E063C45BE387C64729E739403ECF70CCA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1351 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900AbZANLsz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 06:48:55 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403ECF70CCA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pillai, Manikandan" <mani.pillai@ti.com>
Cc: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Jan 14, 2009 at 04:09:07PM +0530, Pillai, Manikandan wrote:

> The other problem which I encounter is with the function regulator_get().
> Regulator_get() requires 2 parameters - device pointer should point to the

> One passed during regulator_register. It also takes a string a second parameter

The struct device that is being checked is the struct device from the
consumer list.  It is not the struct device that is passed immediately 
in the arguments to regulator_register().  The struct device passed to
register regulator should not be being used with regulator_get().

Both parameters used with regulator_get() are being compared with the
information supplied in the consumer list.

> Which is compared with the supply string initialized in the regulator init data
> element regulator_consumer_supply.supply.

Right, just like the device that is asked for is compared with the
struct device that is specified by the dev field of the same structure.

> Passing the client->dev, invoking regulator_register() fails.

I'm not sure what you mean by "passing the client->dev" here?
