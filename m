From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] Allow I2C_OMAP to compile as a module.
Date: Tue, 17 Feb 2009 15:50:18 -0800
Message-ID: <20090217235018.GF11928@atomide.com>
References: <ba2e7dbd53e76bb21bbb95fc026df11787cbd798.1234447641.git.ext-atal.shargorodsky@nokia.com> <20090213085827.d516d6aa.jarkko.nikula@nokia.com> <20090213222100.GJ7562@atomide.com> <20090215213559.0a6653a1.jhnikula@gmail.com> <20090215214501.c7386464.jhnikula@gmail.com> <499996EC.4030108@nokia.com> <20090217112513.303d62e6.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55899 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbZBQXuW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2009 18:50:22 -0500
Content-Disposition: inline
In-Reply-To: <20090217112513.303d62e6.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>, "Shargorodsky Atal (EXT-Teleca/Helsinki)" <ext-atal.shargorodsky@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Jarkko Nikula <jhnikula@gmail.com> [090217 01:22]:
> On Mon, 16 Feb 2009 18:40:12 +0200
> Aaro Koskinen <aaro.koskinen@nokia.com> wrote:
> 
> > Taking example from fs/Makefile (nfsd):
> > 
> > -obj-$(CONFIG_I2C_OMAP) += i2c.o
> > +i2c-omap-$(CONFIG_I2C_OMAP) := i2c.o
> > +obj-y += $(i2c-omap-m) $(i2c-omap-y)
> > 
> This is getting shorter and shorter :-)
> 
> > Also arch/arm/plat-omap/include/mach/common.h should be updated to
> > check for CONFIG_I2C_OMAP_MODULE.
> > 
> Good catch, that's true!

Aaro, can you please send a proper patch with Signed-off-by and I'll
add it to omap-fixes?

Thanks

Tony
