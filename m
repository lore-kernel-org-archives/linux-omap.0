From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] TPS6235x based Power regulator support added
Date: Tue, 6 Jan 2009 10:44:25 +0000
Message-ID: <20090106104424.GD6783@sirena.org.uk>
References: <1229421966-11414-1-git-send-email-mani.pillai@ti.com> <20081217173503.GF22204@sirena.org.uk> <19F8576C6E063C45BE387C64729E739403ECEDD319@dbde02.ent.ti.com> <20090106100003.GA6783@sirena.org.uk> <19F8576C6E063C45BE387C64729E739403ECEDD448@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2641 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbZAFKoa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2009 05:44:30 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403ECEDD448@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pillai, Manikandan" <mani.pillai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, Jan 06, 2009 at 03:43:13PM +0530, Pillai, Manikandan wrote:

> [Pillai, Manikandan] The consumer data is being passed through the struct tps_6235x_i2c_board_info in board specific file board-omap3evm.c.
> But for struct regulator_consumer_supply tps62352_core_consumers the
> Member dev needs to be inited. .dev is not available at this point of time.

Please note what I said about the value you're configuring here: the
struct device that is provided for the consumer is the struct device
for the *consumer*.  You are setting it to the struct device for the
regulator itself.

Think what happens when a consumer calls regulator_get(): it passes in
its own struct device and the supply name.

> If dev is not initialized, the regulator_register() is failing.

That's OMAP-specific.

[BTW, Your e-mails are extremely difficult to read since you don't
distinguish between new and quoted text at all.  You should at the very
least prefix a quote character to quoted text (Outlook can be configured
to do that).]
