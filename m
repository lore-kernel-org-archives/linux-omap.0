From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [Resending - PATCH 1/3] Triton BCI driver device setup for OMAP3430
Date: Thu, 3 Jul 2008 19:23:51 +0530
Message-ID: <00a901c8dd14$3be88e00$69f6180a@ent.ti.com>
References: <44944.192.168.10.88.1215086750.squirrel@dbdmail.itg.ti.com> <60b6f36a0c398d87284f428bc42c7a79@felipebalbi.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42732 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760786AbYGCNyv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 09:54:51 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org


----- Original Message ----- 
From: "Felipe Balbi" <me@felipebalbi.com>
To: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Cc: <tony@atomide.com>; <linux-omap@vger.kernel.org>
Sent: Thursday, July 03, 2008 6:38 PM
Subject: Re: [Resending - PATCH 1/3] Triton BCI driver device setup for OMAP3430


> 
> 
> On Thu, 3 Jul 2008 17:35:50 +0530 (IST), "Madhusudhan Chikkature"
> <madhu.cr@ti.com> wrote:
> 
>> Index: linux-omap-2.6/arch/arm/mach-omap2/bci.c
>> ===================================================================
>> --- /dev/null 1970-01-01 00:00:00.000000000 +0000
>> +++ linux-omap-2.6/arch/arm/mach-omap2/bci.c 2008-07-03
> 16:59:40.000000000
>> +0530
>> @@ -0,0 +1,34 @@
>> +/*
>> + * linux/arch/arm/mach-omap2/board-3430sdp-bci.c
> 
> just fix this name please.
Okay. I missed this one. I will correct it.
> 
> Style only.
What does this mean?
> 
> 
>> +
>> +static struct platform_device twl4030_bci_battery_device = {
>> + .name           = "twl4030-bci-battery",
>> + .id             = 1,
> 
> use -1. There will be no other twl4030-bci-battery in the system :-)
> 
> -- 
> Best Regards,
> 
> Felipe Balbi
> http://blog.felipebalbi.com
> me@felipebalbi.com
> 
>
