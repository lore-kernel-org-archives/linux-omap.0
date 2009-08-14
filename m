From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH 8/9] OMAP2: add board file for Nokia N800 and N810
Date: Fri, 14 Aug 2009 09:01:17 +0300
Message-ID: <87vdkrhr2q.fsf@litku.valot.fi>
References: <20090811094348.32577.81307.stgit@localhost>
	<20090811095558.32577.26177.stgit@localhost>
	<20090813091510.GK6132@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:56016 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755568AbZHNGBT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Aug 2009 02:01:19 -0400
Received: by bwz22 with SMTP id 22so970460bwz.18
        for <linux-omap@vger.kernel.org>; Thu, 13 Aug 2009 23:01:20 -0700 (PDT)
In-Reply-To: <20090813091510.GK6132@n2100.arm.linux.org.uk> (Russell King's message of "Thu\, 13 Aug 2009 10\:15\:10 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Tue, Aug 11, 2009 at 12:55:58PM +0300, Tony Lindgren wrote:
>> +#include <mach/gpio.h>
>
> linux/gpio.h
>
>> +#include <mach/io.h>
>
> linux/io.h

Thanks, will fix.

>> +static struct musb_hdrc_platform_data tusb_data = {
>> +	.mode		= BOARD_MODE,
>> +	.set_power	= tusb_set_power,
>> +	.set_clock	= tusb_set_clock,
>> +	.min_power	= 25,	/* x2 = 50 mA drawn from VBUS as peripheral */
>> +	.power		= 100,	/* Max 100 mA VBUS for host mode */
>> +	.clock		= "osc_ck",
>
> Still passing clock names around?

Sorry, I'm not familiar with this. How should I fix it?

Tony, do you want me to send v2?

-- 
Kalle Valo
