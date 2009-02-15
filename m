From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/1] Allow I2C_OMAP to compile as a module.
Date: Sun, 15 Feb 2009 21:35:59 +0200
Message-ID: <20090215213559.0a6653a1.jhnikula@gmail.com>
References: <ba2e7dbd53e76bb21bbb95fc026df11787cbd798.1234447641.git.ext-atal.shargorodsky@nokia.com>
	<20090213085827.d516d6aa.jarkko.nikula@nokia.com>
	<20090213222100.GJ7562@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:63484 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbZBOTdb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Feb 2009 14:33:31 -0500
Received: by ey-out-2122.google.com with SMTP id 25so263541eya.37
        for <linux-omap@vger.kernel.org>; Sun, 15 Feb 2009 11:33:28 -0800 (PST)
In-Reply-To: <20090213222100.GJ7562@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, "Shargorodsky Atal (EXT-Teleca/Helsinki)" <ext-atal.shargorodsky@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 13 Feb 2009 14:21:00 -0800
Tony Lindgren <tony@atomide.com> wrote:

> > Subject needs a "ARM: OMAP: " prefix, otherwise ok from me.
> > 
> > Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> 
> Sounds like a fix, except I posted a shorter version of the patch that
> should do the trick (untested). Attached here too for reference.
> 
Tony's version does not fix the issue since obj-$(CONFIG_I2C_OMAP) below
still tries to compile arch/arm/plat-omap/i2c.c as a module.

-obj-$(CONFIG_I2C_OMAP) += i2c.o
+
+ifneq ($(CONFIG_I2C_OMAP),)
+	obj-$(CONFIG_I2C_OMAP)		+= i2c.o
+endif

Problem was that drivers/i2c/busses/i2c-omap.c can be module but
arch/arm/plat-omap/i2c.c cannot since it is for early board
initialization code.

-- 
Jarkko
