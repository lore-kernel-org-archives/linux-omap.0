From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v4 1/9] OMAP3: PM: Adding voltage driver support for
 OMAP3
Date: Thu, 2 Dec 2010 11:43:07 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03736F43CB@dbde02.ent.ti.com>
References: <1288195856-11011-1-git-send-email-thara@ti.com>
	<1288195856-11011-2-git-send-email-thara@ti.com>
 <87hbfp9gli.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40931 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756959Ab0LBGNO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 01:13:14 -0500
In-Reply-To: <87hbfp9gli.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>



>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>>Sent: Thursday, November 11, 2010 12:00 AM
>>To: Gopinath, Thara
>>Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>Vishwanath; Sawant, Anand
>>Subject: Re: [PATCH v4 1/9] OMAP3: PM: Adding voltage driver support for
>>OMAP3
>>
>>Thara Gopinath <thara@ti.com> writes:
>>
>>> This patch adds voltage driver support for OMAP3. The driver
>>> allows  configuring the voltage controller and voltage
>>> processors during init and exports APIs to enable/disable
>>> voltage processors, scale voltage and reset voltage.
>>> The driver also maintains the global voltage table on a per
>>> VDD basis which contains the various voltages supported by the
>>> VDD along with per voltage dependent data like smartreflex
>>> n-target value, errminlimit and voltage processor errorgain.
>>> The driver allows scaling of VDD voltages either through
>>> "vc bypass method" or through "vp forceupdate method" the
>>> choice being configurable through the board file.
>>>
>>> This patch contains code originally in linux omap pm branch
>>> smartreflex driver.  Major contributors to this driver are
>>> Lesly A M, Rajendra Nayak, Kalle Jokiniemi, Paul Walmsley,
>>> Nishant Menon, Kevin Hilman.
>>>
>>> Signed-off-by: Thara Gopinath <thara@ti.com>
>>
>>All comments below are cut-and-paste from v3 review, and were not
>>addressed in this update.
>>
>>> ---
>>>  arch/arm/mach-omap2/Makefile              |    3 +-
>>>  arch/arm/mach-omap2/voltage.c             | 1158
>>+++++++++++++++++++++++++++++
>>>  arch/arm/plat-omap/include/plat/voltage.h |  141 ++++
>>>  3 files changed, 1301 insertions(+), 1 deletions(-)
>>>  create mode 100644 arch/arm/mach-omap2/voltage.c
>>>  create mode 100644 arch/arm/plat-omap/include/plat/voltage.h
>>>
>>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>>> index 0b6d9af..bfdabcc 100644
>>> --- a/arch/arm/mach-omap2/Makefile
>>> +++ b/arch/arm/mach-omap2/Makefile
>>> @@ -51,7 +51,8 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
>>>  ifeq ($(CONFIG_PM),y)
>>>  obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
>>>  obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o
>>> -obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
>>pm_bus.o
>>> +obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o voltage.o \
>>> +					   cpuidle34xx.o pm_bus.o
>>>  obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o pm_bus.o
>>>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>>>
>>> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
>>> new file mode 100644
>>> index 0000000..5aa5109
>>> --- /dev/null
>>> +++ b/arch/arm/mach-omap2/voltage.c
>>> @@ -0,0 +1,1158 @@
>>> +/*
>>> + * OMAP3/OMAP4 Voltage Management Routines
>>> + *
>>> + * Author: Thara Gopinath	<thara@ti.com>
>>> + *
>>> + * Copyright (C) 2007 Texas Instruments, Inc.
>>> + * Rajendra Nayak <rnayak@ti.com>
>>> + * Lesly A M <x0080970@ti.com>
>>> + *
>>> + * Copyright (C) 2008 Nokia Corporation
>>> + * Kalle Jokiniemi
>>> + *
>>> + * Copyright (C) 2010 Texas Instruments, Inc.
>>> + * Thara Gopinath <thara@ti.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License version 2 as
>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include <linux/delay.h>
>>> +#include <linux/io.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/err.h>
>>> +#include <linux/debugfs.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#include <plat/common.h>
>>> +#include <plat/voltage.h>
>>> +
>>> +#include "prm-regbits-34xx.h"
>>> +
>>> +#define VP_IDLE_TIMEOUT		200
>>> +#define VP_TRANXDONE_TIMEOUT	300
>>> +#define VOLTAGE_DIR_SIZE	16
>>> +
>>> +static struct dentry *voltage_dir;
>>> +/* PRM voltage module */
>>> +static u32 volt_mod;
>>
>>There's no need for this to be a global, this should be a member of
>>vdd_info (or the voltage domain.)  That means the read/write functions
>>will have to take an additional argument (vdd or voltdm) but that's
>>cleaner to me.

Kevin,

The voltage_read and voltage_write APIs are used not only for the per vdd registers. We also access the vc registers through them and passing vdd or voltdm is not an option. Two options we have are 
	1. Keep the existing implementation
	2. Have volt_mod/prm_mod per vdd basis in the omap_vdd_info struct. Introduce a new struct for storing vc parameters per SoC basis and have a prm_mod there also. Scrap voltage_read and voltage_write APIs and use prm_read and prm_write instead. The last step is because we do not want a voltage_read / voltage_write which looks exactly similar to prm_read/prm_write and do nothing but call into prm_read/prm_write.

Do let me know your thoughts as I m in the midst of the rework. I am assuming you would prefer option 2 and proceeding :-)! 

Regards
Thara
