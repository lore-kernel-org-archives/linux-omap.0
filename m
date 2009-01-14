From: "Pillai, Manikandan" <mani.pillai@ti.com>
Subject: RE: [PATCH 1/2] Include TPS6235x based Power regulator support
Date: Wed, 14 Jan 2009 16:34:35 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403ECF70CCE@dbde02.ent.ti.com>
References: <1231832468-7132-1-git-send-email-mani.pillai@ti.com>
 <20090113220738.GA13227@sirena.org.uk>
 <19F8576C6E063C45BE387C64729E739403ECF70CC7@dbde02.ent.ti.com>
 <20090114110133.GA24895@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49319 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672AbZANLGD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 06:06:03 -0500
In-Reply-To: <20090114110133.GA24895@sirena.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Mark Brown [mailto:broonie@sirena.org.uk]
> Sent: Wednesday, January 14, 2009 4:32 PM
> To: Pillai, Manikandan
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/2] Include TPS6235x based Power regulator support
> 
> On Wed, Jan 14, 2009 at 03:32:17PM +0530, Pillai, Manikandan wrote:
> 
> > > From: Mark Brown [mailto:broonie@sirena.org.uk]
> 
> > > With current mainline this should be rewritten as:
> > >
> > > 	rdev = regulator_register(&regulators[id->driver_data],
> > > 				  &client->dev, client);
> > >
> > > though I'm not sure what's currently merged up into the OMAP trees.
> 
> > The issue is that passing the initial value for regulators is done by
> 
> > struct regulator_init_data *init_data = dev->platform_data;
> 
> > in regulator_register() function. Do we have a way to initialize the
> > platform data for the i2c client struct.
> 
> The platform data is part of the struct device so you with your current
> code your driver can just assign directly to it.
[Pillai, Manikandan]  The platform_data is now initialized to clkrate.
(arch/arm/plat-omap2/i2c.c


