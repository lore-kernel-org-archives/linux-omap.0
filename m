From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] Allow I2C_OMAP to compile as a module.
Date: Mon, 16 Feb 2009 15:09:35 -0800
Message-ID: <20090216230935.GN7562@atomide.com>
References: <ba2e7dbd53e76bb21bbb95fc026df11787cbd798.1234447641.git.ext-atal.shargorodsky@nokia.com> <20090213085827.d516d6aa.jarkko.nikula@nokia.com> <20090213222100.GJ7562@atomide.com> <20090215213559.0a6653a1.jhnikula@gmail.com> <20090215214501.c7386464.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56523 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbZBPXJl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2009 18:09:41 -0500
Content-Disposition: inline
In-Reply-To: <20090215214501.c7386464.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, "Shargorodsky Atal (EXT-Teleca/Helsinki)" <ext-atal.shargorodsky@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Jarkko Nikula <jhnikula@gmail.com> [090215 11:44]:
> On Sun, 15 Feb 2009 21:35:59 +0200
> Jarkko Nikula <jhnikula@gmail.com> wrote:
> 
> > Tony's version does not fix the issue since obj-$(CONFIG_I2C_OMAP)
> > below still tries to compile arch/arm/plat-omap/i2c.c as a module.
> > 
> > -obj-$(CONFIG_I2C_OMAP) += i2c.o
> > +
> > +ifneq ($(CONFIG_I2C_OMAP),)
> > +	obj-$(CONFIG_I2C_OMAP)		+= i2c.o
> > +endif
> > 
> And build works if obj-y rule is used instead
> 
> -obj-$(CONFIG_I2C_OMAP) += i2c.o
> +
> +ifneq ($(CONFIG_I2C_OMAP),)
> +	obj-y	+= i2c.o
> +endif
> 
> Good. Patch can be made to touch only single file and add only three new
> lines.

Ah sorry for the typo :)

Tony
