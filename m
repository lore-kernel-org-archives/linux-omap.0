From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH v2 1/2] OMAP3:Zoom2: Add TWL4030 support
Date: Mon, 22 Jun 2009 22:02:15 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F5461976@dbde02.ent.ti.com>
References: <1245363264-6162-1-git-send-email-vikram.pandita@ti.com>
 <20090622125136.GF7352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56274 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753108AbZFVQc0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Jun 2009 12:32:26 -0400
In-Reply-To: <20090622125136.GF7352@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


>-----Original Message-----
>From: Tony Lindgren [mailto:tony@atomide.com]
>Sent: Monday, June 22, 2009 7:52 AM
>To: Pandita, Vikram
>Cc: linux-omap@vger.kernel.org
>Subject: Re: [PATCH v2 1/2] OMAP3:Zoom2: Add TWL4030 support
>
>* Vikram Pandita <vikram.pandita@ti.com> [090619 01:18]:
>> Add TWL4030 CORE and TWL4030 drivers to Zoom2 board file
>> TWL drivers enabled are:
>> 	bci
>> 	madc
>> 	usb
>> 	keypad
>> 	mmc
>>
>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>> ---
>>  arch/arm/mach-omap2/board-zoom2.c |  209 +++++++++++++++++++++++++++++++++++--
>>  1 files changed, 198 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
>> index bcc0f76..443859c 100644
>> --- a/arch/arm/mach-omap2/board-zoom2.c
>> +++ b/arch/arm/mach-omap2/board-zoom2.c
>>
>>  #include "mmc-twl4030.h"
>>
>> +#ifndef CONFIG_TWL4030_CORE
>> +#error "no power companion board defined!"
>> +#endif
>
>This does not look right. You should still be able to boot the board even without
>twl compiled in. Or compile twl as a module. Currently we do have a bug where
>mmc-twl4030.c forces mmc core to be compiled in because of the regulator fwk, but
>that should be fixed by moving the regulator fwk calls to drivers/mmc/host/omap_hsmmc.c.

Correcting this is v3 of patch.
Posting it out today.

>
>Regards,
>
>Tony

