From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 01/11] arm:omap:am33xx: Add voltage domain data
Date: Thu, 01 Dec 2011 06:53:01 -0800
Message-ID: <8739d4tkc2.fsf@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
	<1321809555-13833-2-git-send-email-hvaibhav@ti.com>
	<87ipm1w3pz.fsf@ti.com>
	<79CD15C6BA57404B839C016229A409A8047586@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:37470 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754707Ab1LAOxG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Dec 2011 09:53:06 -0500
Received: by mail-yx0-f179.google.com with SMTP id m6so2270340yen.24
        for <linux-omap@vger.kernel.org>; Thu, 01 Dec 2011 06:53:04 -0800 (PST)
In-Reply-To: <79CD15C6BA57404B839C016229A409A8047586@DBDE01.ent.ti.com>
	(Vaibhav Hiremath's message of "Thu, 1 Dec 2011 11:25:10 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Mohammed, Afzal" <afzal@ti.com>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

>> -----Original Message-----
>> From: Hilman, Kevin
>> Sent: Thursday, December 01, 2011 5:41 AM
>> To: Hiremath, Vaibhav
>> Cc: linux-omap@vger.kernel.org; tony@atomide.com; paul@pwsan.com; linux-
>> arm-kernel@lists.infradead.org; Cousson, Benoit; Mohammed, Afzal
>> Subject: Re: [RFC PATCH 01/11] arm:omap:am33xx: Add voltage domain data
>> 
>> Vaibhav Hiremath <hvaibhav@ti.com> writes:
>> 
>> > From: Afzal Mohammed <afzal@ti.com>
>> >
>> > Currently dummy voltage domain data is being created
>> > in order to succeed boot process.
>> > Nothing has been done w.r.t actual hardware (voltage control).
>> >
>> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
>> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> 
>> [...]
>> 
>> > --- /dev/null
>> > +++ b/arch/arm/mach-omap2/voltagedomains33xx_data.c
>> > @@ -0,0 +1,37 @@
>> > +/*
>> > + * AM33XX voltage domain data
>> > + *
>> > + * Copyright (C) 2011 Texas Instruments, Inc.
>> > + *
>> > + * This program is free software; you can redistribute it and/or modify
>> > + * it under the terms of the GNU General Public License version 2 as
>> > + * published by the Free Software Foundation.
>> > + */
>> > +#include <linux/kernel.h>
>> > +#include <linux/init.h>
>> > +
>> > +#include "voltage.h"
>> > +
>> > +static struct voltagedomain am33xx_voltdm_mpu = {
>> > +	.name = "mpu",
>> > +};
>> 
>> According to the TRM, there is no MPU voltage domain.  Only CORE and RTC
>> exist.
>> 
>> However, looking at the data manual (SPRS717 Oct 2011), it seems that
>> some packages have a separate VDD_MPU while others have a combined
>> VDD_MPU and VDD_CORE.
>> 
>> This should be clarified and documented in the changelog.
>> 
>
>
> No, we do have VDD_MPU specifically documented in TRM (SPRUH73 - October2011).
>
> The TRM is accessible at - http://www.ti.com/lit/ug/spruh73/spruh73.pdf

That link doesn't work for me, I think you meant

     http://www.ti.com/lit/ug/spruh73a/spruh73a.pdf

which is the document I'm reading.  Specifically it says:

8.1.1.10 Voltage and Power Domains

The following table shows how the device core logic is partitioned into
two core logic voltage domains and four power domains. The table lists
which voltage and power domain a functional module belongs.

Table 8-25. Core Logic Voltage and Power Domains
      Logic Voltage Domain Name    |  Module
      ---------------------------------------------
      CORE                         |  All Core Modules
      RTC                          |  RTC

8.1.1.10.1 Voltage Domains

The core logic is divided into two voltage domains: VDD_CORE and
VDD_RTC.



However, in reading other parts of the TRM, it clearly references
VDD_MPU and the data manual also references a separate VDD_MPU.

My point in this comment was that since the TRM is rather unclear on
this, the changelog should be more verbose, and take care to clear up
any thing that's wrong or unclear in the TRM.

Kevin
