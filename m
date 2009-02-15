From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 1/1] Allow =?UTF-8?Q?I=32C=5FOMAP=20to=20compile=20as=20a=20mo?=
 =?UTF-8?Q?dule=2E?=
Date: Sun, 15 Feb 2009 14:47:15 -0600
Message-ID: <61a7513ea2a517e5866e1ca10d8f7690@felipebalbi.com>
References: <ba2e7dbd53e76bb21bbb95fc026df11787cbd798.1234447641.git.ext-atal.shargorodsky@nokia.com> <20090213085827.d516d6aa.jarkko.nikula@nokia.com> <20090213222100.GJ7562@atomide.com> <20090215213559.0a6653a1.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:55622 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755576AbZBOUrZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Feb 2009 15:47:25 -0500
In-Reply-To: <20090215213559.0a6653a1.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, "Shargorodsky Atal (EXT-Teleca/Helsinki)" <ext-atal.shargorodsky@nokia.com>, linux-omap@vger.kernel.org

Hi,

On Sun, 15 Feb 2009 21:35:59 +0200, Jarkko Nikula <jhnikula@gmail.com>
wrote:
> On Fri, 13 Feb 2009 14:21:00 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> 
>> > Subject needs a "ARM: OMAP: " prefix, otherwise ok from me.
>> >
>> > Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
>>
>> Sounds like a fix, except I posted a shorter version of the patch that
>> should do the trick (untested). Attached here too for reference.
>>
> Tony's version does not fix the issue since obj-$(CONFIG_I2C_OMAP) below
> still tries to compile arch/arm/plat-omap/i2c.c as a module.
> 
> -obj-$(CONFIG_I2C_OMAP) += i2c.o
> +
> +ifneq ($(CONFIG_I2C_OMAP),)
> +	obj-$(CONFIG_I2C_OMAP)		+= i2c.o
> +endif
> 
> Problem was that drivers/i2c/busses/i2c-omap.c can be module but
> arch/arm/plat-omap/i2c.c cannot since it is for early board
> initialization code.

why don't you:

-obj-$(CONFIG_I2C_OMAP) += i2c.o
+obj-y			+= i2c.o

It's quite possible that we will need i2c
anyways in most boards. And for the ones who
won't need, it's just a few extra bytes
to kernel image. I guess it should be
ok to always build i2c utilities.

-- 
Best Regards,

Felipe Balbi
http://blog.felipebalbi.com
me@felipebalbi.com

