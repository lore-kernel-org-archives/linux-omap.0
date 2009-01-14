From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] Include TPS6235x based Power regulator support
Date: Wed, 14 Jan 2009 11:01:34 +0000
Message-ID: <20090114110133.GA24895@sirena.org.uk>
References: <1231832468-7132-1-git-send-email-mani.pillai@ti.com> <20090113220738.GA13227@sirena.org.uk> <19F8576C6E063C45BE387C64729E739403ECF70CC7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3124 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722AbZANLBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 06:01:36 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403ECF70CC7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pillai, Manikandan" <mani.pillai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Jan 14, 2009 at 03:32:17PM +0530, Pillai, Manikandan wrote:

> > From: Mark Brown [mailto:broonie@sirena.org.uk]

> > With current mainline this should be rewritten as:
> > 
> > 	rdev = regulator_register(&regulators[id->driver_data],
> > 				  &client->dev, client);
> > 
> > though I'm not sure what's currently merged up into the OMAP trees.

> The issue is that passing the initial value for regulators is done by

> struct regulator_init_data *init_data = dev->platform_data;

> in regulator_register() function. Do we have a way to initialize the
> platform data for the i2c client struct.

The platform data is part of the struct device so you with your current
code your driver can just assign directly to it.
