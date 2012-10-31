From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [RFC-v2 2/7] capebus: Add beaglebone board support
Date: Wed, 31 Oct 2012 20:06:26 +0200
Message-ID: <C075528B-2CA0-4435-8CE2-3D0FB7596B35@antoniou-consulting.com>
References: <1351783952-11804-1-git-send-email-panto@antoniou-consulting.com> <1351783952-11804-3-git-send-email-panto@antoniou-consulting.com> <20121031175546.GI12739@atomide.com>
Mime-Version: 1.0 (Apple Message framework v1085)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121031175546.GI12739@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On Oct 31, 2012, at 7:55 PM, Tony Lindgren wrote:

> * Pantelis Antoniou <panto@antoniou-consulting.com> [121031 10:41]:
>> Introduce beaglebone capebus board support.
> ...
> 
>> --- /dev/null
>> +++ b/drivers/capebus/boards/Kconfig
>> @@ -0,0 +1,6 @@
>> +config CAPEBUS_BONE_CONTROLLER
>> +	bool "Beaglebone capebus board controller"
>> +	depends on CAPEBUS && ARCH_OMAP2PLUS && OF && I2C
>> +	default n
> 
> The default is n, so you can remove "default n" from your
> patches.

You're right.

> 
>> +++ b/drivers/capebus/boards/capebus-bone-generic.c
>> @@ -0,0 +1,237 @@
>> +/*
>> + * TI Beaglebone capebus controller - Generic devices
>> + *
>> + * Copyright (C) 2012 Pantelis Antoniou <panto@antoniou-consulting.com>
>> + * Copyright (C) 2012 Texas Instruments Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/string.h>
>> +#include <linux/timer.h>
>> +#include <linux/errno.h>
>> +#include <linux/init.h>
>> +#include <linux/delay.h>
>> +#include <linux/bitops.h>
>> +#include <linux/err.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_gpio.h>
>> +#include <video/da8xx-fb.h>
>> +#include <linux/pinctrl/pinctrl.h>
>> +#include <linux/pinctrl/pinmux.h>
>> +#include <linux/pinctrl/consumer.h>
>> +#include <linux/atomic.h>
>> +#include <linux/clk.h>
>> +#include <asm/barrier.h>
>> +#include <plat/clock.h>
>> +#include <plat/omap_device.h>
> 
> You need to check your patches to make sure you don't need
> any #include <plat/*.h> or #include <mach/*.h> as those are
> already not available for drivers in linux next.
> 

Right again. Missed this


> Regards,
> 
> Tony
