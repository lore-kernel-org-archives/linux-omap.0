From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] Allow I2C_OMAP to compile as a module.
Date: Mon, 16 Feb 2009 15:09:59 -0800
Message-ID: <20090216230959.GO7562@atomide.com>
References: <ba2e7dbd53e76bb21bbb95fc026df11787cbd798.1234447641.git.ext-atal.shargorodsky@nokia.com> <20090213085827.d516d6aa.jarkko.nikula@nokia.com> <20090213222100.GJ7562@atomide.com> <20090215213559.0a6653a1.jhnikula@gmail.com> <20090215214501.c7386464.jhnikula@gmail.com> <499996EC.4030108@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56745 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbZBPXKF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Feb 2009 18:10:05 -0500
Content-Disposition: inline
In-Reply-To: <499996EC.4030108@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: ext Jarkko Nikula <jhnikula@gmail.com>, "Nikula Jarkko (Nokia-D/Helsinki)" <jarkko.nikula@nokia.com>, "Shargorodsky Atal (EXT-Teleca/Helsinki)" <ext-atal.shargorodsky@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Aaro Koskinen <aaro.koskinen@nokia.com> [090216 08:40]:
> Hello,
>
> ext Jarkko Nikula wrote:
>> Jarkko Nikula <jhnikula@gmail.com> wrote:
>>> Tony's version does not fix the issue since obj-$(CONFIG_I2C_OMAP)
>>> below still tries to compile arch/arm/plat-omap/i2c.c as a module.
>>>
>>> -obj-$(CONFIG_I2C_OMAP) += i2c.o
>>> +
>>> +ifneq ($(CONFIG_I2C_OMAP),)
>>> +     obj-$(CONFIG_I2C_OMAP)          += i2c.o
>>> +endif
>>>
>> And build works if obj-y rule is used instead
>>
>> -obj-$(CONFIG_I2C_OMAP) += i2c.o
>> +
>> +ifneq ($(CONFIG_I2C_OMAP),)
>> +       obj-y   += i2c.o
>> +endif
>>
>> Good. Patch can be made to touch only single file and add only three new
>> lines.
>
> Taking example from fs/Makefile (nfsd):
>
> -obj-$(CONFIG_I2C_OMAP) += i2c.o
> +i2c-omap-$(CONFIG_I2C_OMAP) := i2c.o
> +obj-y += $(i2c-omap-m) $(i2c-omap-y)
>
> Also arch/arm/plat-omap/include/mach/common.h should be updated to check  
> for CONFIG_I2C_OMAP_MODULE.

That seems cleaner to me.

Tony
