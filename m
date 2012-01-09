From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC/PATCH 8/7] ARM: OMAP: AM35xx: convert 3517 detection/flags to AM35xx
Date: Mon, 09 Jan 2012 15:06:15 -0800
Message-ID: <87zkdwxyqg.fsf@ti.com>
References: <1325726206-11199-1-git-send-email-khilman@ti.com>
	<1325876023-7040-1-git-send-email-khilman@ti.com>
	<79CD15C6BA57404B839C016229A409A80752F2@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:42300 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755858Ab2AIXGY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jan 2012 18:06:24 -0500
Received: by ghbg19 with SMTP id g19so2031301ghb.37
        for <linux-omap@vger.kernel.org>; Mon, 09 Jan 2012 15:06:17 -0800 (PST)
In-Reply-To: <79CD15C6BA57404B839C016229A409A80752F2@DBDE01.ent.ti.com>
	(Vaibhav Hiremath's message of "Sun, 8 Jan 2012 07:02:03 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

>> -----Original Message-----
>> From: Hilman, Kevin
>> Sent: Saturday, January 07, 2012 12:24 AM
>> To: linux-omap@vger.kernel.org
>> Cc: Paul Walmsley; Hiremath, Vaibhav
>> Subject: [RFC/PATCH 8/7] ARM: OMAP: AM35xx: convert 3517 detection/flags
>> to AM35xx
>> 
>> Currently cpu_is_omap3517() actually detects any device in the AM35x
>> family (3517 and no-SGX version 3505.)  To make it more clear what is
>> being detected, convert the names from 3517 to AM35xx.
>> 
>> For the same reason, replace the CK_3517 flag used in the clock data
>> to CK_AM35XX.
>> 
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>>  arch/arm/mach-omap2/clock3xxx_data.c          |    8 ++++----
>>  arch/arm/mach-omap2/hsmmc.c                   |    8 ++++----
>>  arch/arm/mach-omap2/id.c                      |    7 +++----
>>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |    2 +-
>>  arch/arm/mach-omap2/powerdomains3xxx_data.c   |    2 +-
>>  arch/arm/mach-omap2/usb-musb.c                |    2 +-
>>  arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 +-
>>  arch/arm/plat-omap/include/plat/clkdev_omap.h |    3 +--
>>  arch/arm/plat-omap/include/plat/cpu.h         |   15 +++++++--------
>>  9 files changed, 23 insertions(+), 26 deletions(-)
>> 
> Is this also right time to change Makefile and Kconfig files???
> Change in board/mach-types/Makefile/Kconfig files will bring
> consistency across...

Probably, yes.  Although Tony might thing that is too much churn.

Feel free to spin up a patch and I'll add it to this series and we'll
see what Tony thinks.

Kevin
