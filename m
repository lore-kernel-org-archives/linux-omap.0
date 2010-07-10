From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH 0/3] Fix omap_type() function
Date: Sat, 10 Jul 2010 19:29:32 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305C12427@dbde02.ent.ti.com>
References: <1278745713-31255-1-git-send-email-vikram.pandita@ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C6005AB2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41391 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560Ab0GJN7i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 Jul 2010 09:59:38 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6ADxZIA028809
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 10 Jul 2010 08:59:37 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o6ADxZrt022265
	for <linux-omap@vger.kernel.org>; Sat, 10 Jul 2010 19:29:35 +0530 (IST)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C6005AB2@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



>-----Original Message-----
>From: Shilimkar, Santosh
>Sent: Saturday, July 10, 2010 2:32 AM
>To: Pandita, Vikram; linux-omap@vger.kernel.org
>Subject: RE: [PATCH 0/3] Fix omap_type() function
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Pandita, Vikram
>> Sent: Saturday, July 10, 2010 12:39 PM
>> To: linux-omap@vger.kernel.org
>> Cc: Pandita, Vikram
>> Subject: [PATCH 0/3] Fix omap_type() function
>>
>> Aim was to get omap_type() function work on omap4.
>> In doing so, fixing an issue with is_sram_locked() function.
>>
>> Patches tested/verified on omap4 sdp.
>> Patches based of latest linus commit: e467e10
>>
>> Vikram Pandita (3):
>>   omap: sram: fix is_sram_locked check
>>   omap4: fix omap_type() function
>>   omap4: SRAM start and size change for EMU/HS devices
>>
>>  arch/arm/plat-omap/include/plat/omap44xx.h |    2 +-
>>  arch/arm/plat-omap/sram.c                  |   28 ++++++++++++++--------
>-
>In summary only fixing " is_sram_locked()" and adding the OMAP_2PLUS is
>enough.

All Valid comments. Thanks for the review.

>
>The control module needs to be fixed in right way because with different
>bases in wakeup and core control modules makes
>the current omap_control_read/write break on OMAP4. This is similar problem
>what we have on powerdomain base offsets and needs a proper handling.
>
>Fixing one base will break other register acceses

Yes I can now see how my patch 2 has broken the MMC part in: omap4_hsmmc1_before_set_reg(...)

Will post a saner V2 with:
Patch 1 -> your ACK

Patch 2 -> 
	will fix omap_type() in right way
	by not using omap_ctrl_readl() instead using right offset

Patch 3 -> just add OMAP_2PLUS change


