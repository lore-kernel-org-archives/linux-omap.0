From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] Include TPS6235x based Power regulator support
Date: Wed, 14 Jan 2009 11:57:30 +0000
Message-ID: <20090114115729.GC24895@sirena.org.uk>
References: <1231832468-7132-1-git-send-email-mani.pillai@ti.com> <20090113220738.GA13227@sirena.org.uk> <19F8576C6E063C45BE387C64729E739403ECF70CC7@dbde02.ent.ti.com> <20090114110133.GA24895@sirena.org.uk> <19F8576C6E063C45BE387C64729E739403ECF70CCE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3328 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542AbZANL5b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 06:57:31 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403ECF70CCE@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pillai, Manikandan" <mani.pillai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Jan 14, 2009 at 04:34:35PM +0530, Pillai, Manikandan wrote:

> > The platform data is part of the struct device so you with your current
> > code your driver can just assign directly to it.
> [Pillai, Manikandan]  The platform_data is now initialized to clkrate.
> (arch/arm/plat-omap2/i2c.c

If you don't want to overwrite it then as previously discussed you
should allocate a child platform device in your probe function and use
that as the immediate argument when calling regulator_register().

I'm currently doing a patch to regulator_register() which will make the
init data an explicit argument.  With the current code using the
platform data of your I2C device or allocating a child device are your
options.
