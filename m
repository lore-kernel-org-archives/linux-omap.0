From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 1/1] Allow I2C_OMAP to compile as a module.
Date: Sun, 15 Feb 2009 21:45:01 +0200
Message-ID: <20090215214501.c7386464.jhnikula@gmail.com>
References: <ba2e7dbd53e76bb21bbb95fc026df11787cbd798.1234447641.git.ext-atal.shargorodsky@nokia.com>
	<20090213085827.d516d6aa.jarkko.nikula@nokia.com>
	<20090213222100.GJ7562@atomide.com>
	<20090215213559.0a6653a1.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:61296 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755955AbZBOTme (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Feb 2009 14:42:34 -0500
Received: by ewy14 with SMTP id 14so1649577ewy.13
        for <linux-omap@vger.kernel.org>; Sun, 15 Feb 2009 11:42:32 -0800 (PST)
In-Reply-To: <20090215213559.0a6653a1.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, "Shargorodsky Atal (EXT-Teleca/Helsinki)" <ext-atal.shargorodsky@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sun, 15 Feb 2009 21:35:59 +0200
Jarkko Nikula <jhnikula@gmail.com> wrote:

> Tony's version does not fix the issue since obj-$(CONFIG_I2C_OMAP)
> below still tries to compile arch/arm/plat-omap/i2c.c as a module.
> 
> -obj-$(CONFIG_I2C_OMAP) += i2c.o
> +
> +ifneq ($(CONFIG_I2C_OMAP),)
> +	obj-$(CONFIG_I2C_OMAP)		+= i2c.o
> +endif
> 
And build works if obj-y rule is used instead

-obj-$(CONFIG_I2C_OMAP) += i2c.o
+
+ifneq ($(CONFIG_I2C_OMAP),)
+	obj-y	+= i2c.o
+endif

Good. Patch can be made to touch only single file and add only three new
lines.

-- 
Jarkko
