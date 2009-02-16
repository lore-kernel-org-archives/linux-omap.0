From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH 1/1] Allow I2C_OMAP to compile as a module.
Date: Mon, 16 Feb 2009 18:40:12 +0200
Message-ID: <499996EC.4030108@nokia.com>
References: <ba2e7dbd53e76bb21bbb95fc026df11787cbd798.1234447641.git.ext-atal.shargorodsky@nokia.com>	<20090213085827.d516d6aa.jarkko.nikula@nokia.com>	<20090213222100.GJ7562@atomide.com>	<20090215213559.0a6653a1.jhnikula@gmail.com> <20090215214501.c7386464.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:50184 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbZBPQk5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2009 11:40:57 -0500
In-Reply-To: <20090215214501.c7386464.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>, "Shargorodsky Atal (EXT-Teleca/Helsinki)" <ext-atal.shargorodsky@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello,

ext Jarkko Nikula wrote:
> Jarkko Nikula <jhnikula@gmail.com> wrote:
>> Tony's version does not fix the issue since obj-$(CONFIG_I2C_OMAP)
>> below still tries to compile arch/arm/plat-omap/i2c.c as a module.
>>
>> -obj-$(CONFIG_I2C_OMAP) += i2c.o
>> +
>> +ifneq ($(CONFIG_I2C_OMAP),)
>> +     obj-$(CONFIG_I2C_OMAP)          += i2c.o
>> +endif
>>
> And build works if obj-y rule is used instead
> 
> -obj-$(CONFIG_I2C_OMAP) += i2c.o
> +
> +ifneq ($(CONFIG_I2C_OMAP),)
> +       obj-y   += i2c.o
> +endif
> 
> Good. Patch can be made to touch only single file and add only three new
> lines.

Taking example from fs/Makefile (nfsd):

-obj-$(CONFIG_I2C_OMAP) += i2c.o
+i2c-omap-$(CONFIG_I2C_OMAP) := i2c.o
+obj-y += $(i2c-omap-m) $(i2c-omap-y)

Also arch/arm/plat-omap/include/mach/common.h should be updated to check 
for CONFIG_I2C_OMAP_MODULE.

A.
