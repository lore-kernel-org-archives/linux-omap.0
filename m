From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] OMAP3: MMC: Add mux for pins
Date: Thu, 18 Jun 2009 00:08:01 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702F53D18C6@dbde02.ent.ti.com>
References: <1244846488-28313-1-git-send-email-vikram.pandita@ti.com>
	<20090615081242.GE4474@atomide.com>
	<5C07676A-0A93-48DE-B4C0-5A6709BE34A8@gmail.com>
	<20090615110431.GO4474@atomide.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F53D146A@dbde02.ent.ti.com>
	<87y6rs2nu0.fsf@deeprootsystems.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F53D14A4@dbde02.ent.ti.com>
	<20090617081206.GD6605@atomide.com>
	<FCCFB4CDC6E5564B9182F639FC35608702F53D18B1@dbde02.ent.ti.com>
 <87my86yau1.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46959 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760122AbZFQSiO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 14:38:14 -0400
In-Reply-To: <87my86yau1.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>, Hugo Vincent <hugo.vincent@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>



>-----Original Message-----
>From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>
>>>If some pins are always needed, and don't have alternative pinouts, then
>>>the common pins could be muxed in devices.c.
>>
>> This is the algo we can use for MMC pin muxing in that case:
>>
>> MMC1: No pin has mux clash
>> 	Mux all 10 pins in devices.c
>
>Is this common across 34xx and 35xx?

Yes this is common.
Both are same OMAP3 marketed differently.

>
>> MMC2: MUX CLK,CMD,D0-D3 in devices.c: D4-D7 have mux clash
>> 	In case board needs 8 bit support,
>> 	then in devices.c print KERN_WARNING "Configure MMC2:D4-D7 mux in board file"
>
>I don't think you need a KERN_WARNING, what if the board code does this
>later?  Probably a comment in the code would suffice.

Given this split of common MMC mux in devices.c
and non-common MMC mux in board file, 
for someone starting new, a warning message helps a lot...

The idea is to warn only MMC2-8bit and MMC3 user to setup the mux.

If already done in uboot/board file, purpose is solved... 

>
>> MMC3: All pins have mux clash: No mux done in devices.c
>> 	In case board specifies MMC3 usage,
>> 	then in devices.c print KERN_WARNING "Configure MMC3 mux in board file"
>>
>> Let me know if this is final and I can submit a patch.
>
>Kevin
>
>

