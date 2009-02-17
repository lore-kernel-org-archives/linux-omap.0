From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/1] Allow I2C_OMAP to compile as a module.
Date: Tue, 17 Feb 2009 11:25:13 +0200
Message-ID: <20090217112513.303d62e6.jhnikula@gmail.com>
References: <ba2e7dbd53e76bb21bbb95fc026df11787cbd798.1234447641.git.ext-atal.shargorodsky@nokia.com>
	<20090213085827.d516d6aa.jarkko.nikula@nokia.com>
	<20090213222100.GJ7562@atomide.com>
	<20090215213559.0a6653a1.jhnikula@gmail.com>
	<20090215214501.c7386464.jhnikula@gmail.com>
	<499996EC.4030108@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:20555 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbZBQJWk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Feb 2009 04:22:40 -0500
Received: by ey-out-2122.google.com with SMTP id 25so356784eya.37
        for <linux-omap@vger.kernel.org>; Tue, 17 Feb 2009 01:22:38 -0800 (PST)
In-Reply-To: <499996EC.4030108@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>, "Shargorodsky Atal (EXT-Teleca/Helsinki)" <ext-atal.shargorodsky@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 16 Feb 2009 18:40:12 +0200
Aaro Koskinen <aaro.koskinen@nokia.com> wrote:

> Taking example from fs/Makefile (nfsd):
> 
> -obj-$(CONFIG_I2C_OMAP) += i2c.o
> +i2c-omap-$(CONFIG_I2C_OMAP) := i2c.o
> +obj-y += $(i2c-omap-m) $(i2c-omap-y)
> 
This is getting shorter and shorter :-)

> Also arch/arm/plat-omap/include/mach/common.h should be updated to
> check for CONFIG_I2C_OMAP_MODULE.
> 
Good catch, that's true!


Jarkko
