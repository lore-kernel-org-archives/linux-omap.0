From: "Pedanekar, Hemant" <hemantp@ti.com>
Subject: RE: [PATCH 4/6] TI816X: Create board support for TI816X_EVM
Date: Fri, 6 Aug 2010 14:00:02 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E65BEB9@dbde02.ent.ti.com>
References: <1280523118-25118-1-git-send-email-hemantp@ti.com>
 <87bp9h2kqt.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38987 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491Ab0HFIaK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 04:30:10 -0400
In-Reply-To: <87bp9h2kqt.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Kevin Hilman wrote:
> Hemant Pedanekar <hemantp@ti.com> writes:
> 
>> This patch adds minimal support for TI816X EVM to enable kernel boot.
>> 
>> Signed-off-by: Hemant Pedanekar <hemantp@ti.com>
> 
> [...]
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/device.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/spi/flash.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/gpio.h>
>> +#include <linux/i2c.h>
>> +#include <linux/i2c/pcf857x.h>
>> +#include <linux/i2c/at24.h>
>> +#include <linux/mtd/mtd.h>
>> +#include <linux/mtd/nand.h>
>> +#include <linux/mtd/partitions.h>
>> +#include <linux/mtd/physmap.h>
>> +#include <linux/phy.h>
> 
> Looks like most of these headers are not needed for this minimal
> support.  It's preferred to have a minimal set of headers here and add
> them later as needed when the devices are added.
> 
>> +#include <mach/hardware.h>
>> +#include <asm/mach-types.h>
>> +#include <asm/mach/arch.h>
>> +#include <asm/mach/map.h>
>> +
>> +#include <plat/irqs.h>
>> +#include <plat/mux.h>
>> +#include <plat/board.h>
>> +#include <plat/common.h>
>> +#include <plat/timer-gp.h>
>> +
>> +static void __init ti8168_evm_init_irq(void)
>> +{
>> +	omap2_gp_clockevent_set_gptimer(2);
> 
> Just curious why GPT2 is used here.
> 
>> +	omap2_init_common_hw(NULL, NULL);
>> +	omap_init_irq();
>> +}
> 
> Kevin

Currently, first timer is reserved on TI816X.

I will cleanup the includes and add timer comment.

Thanks
-
Hemant

