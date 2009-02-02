From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/2] Adding and building TPS6235x based PR785 board support
Date: Mon, 2 Feb 2009 11:16:07 +0000
Message-ID: <20090202111607.GB16510@sirena.org.uk>
References: <1233307390-14974-1-git-send-email-mani.pillai@ti.com> <20090130115313.GB18825@sirena.org.uk> <19F8576C6E063C45BE387C64729E739403FA790614@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:1866 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbZBBLQJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Feb 2009 06:16:09 -0500
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403FA790614@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pillai, Manikandan" <mani.pillai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Feb 02, 2009 at 09:22:30AM +0530, Pillai, Manikandan wrote:

> > Ditto.  It's important to remember that this I2C driver is going to be
> > used by all OMAP systems using I2C - patching in ifdefs for setting up
> > each board isn't going to scale, they would end up obscuring the code
> > for the I2C controller itself.

> [Pillai, Manikandan] I can move this to board-omap3evm.c. I shall be using
> static struct platform_device omap_i2c_devices[]  as extern in board-omap3evm.c
> to register the child platform device.

I'm not sure what devices you're registering as children here but note
that consumers do not need to be children of the regulator in the device
tree.
