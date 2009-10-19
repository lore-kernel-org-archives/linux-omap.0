From: "Pandita, Vikram" <vikram.pandita@ti.com>
Subject: RE: [PATCH] omap: 3630: update is_chip variable
Date: Tue, 20 Oct 2009 03:54:48 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA174E4A@dbde02.ent.ti.com>
References: <1255989491-27088-1-git-send-email-vikram.pandita@ti.com>
 <13B9B4C6EF24D648824FF11BE8967162039B318E7E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39881 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756437AbZJSWZC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Oct 2009 18:25:02 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9JMP34b014438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 19 Oct 2009 17:25:06 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9JMP3jp004711
	for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 03:55:03 +0530 (IST)
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162039B318E7E@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Menon, Nishanth" <nm@ti.com>



>-----Original Message-----
>From: Woodruff, Richard
>Sent: Monday, October 19, 2009 5:18 PM
>To: Pandita, Vikram; linux-omap@vger.kernel.org
>Cc: Menon, Nishanth
>Subject: RE: [PATCH] omap: 3630: update is_chip variable
>
>
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Pandita, Vikram
>> Sent: Monday, October 19, 2009 4:58 PM
>
>> diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-
>> omap/include/mach/cpu.h
>> index 7cb0556..05a0a33 100644
>> --- a/arch/arm/plat-omap/include/mach/cpu.h
>> +++ b/arch/arm/plat-omap/include/mach/cpu.h
>> @@ -454,6 +454,7 @@ IS_OMAP_TYPE(3430, 0x3430)
>>  #define CHIP_IS_OMAP3430ES2		(1 << 4)
>>  #define CHIP_IS_OMAP3430ES3_0		(1 << 5)
>>  #define CHIP_IS_OMAP3430ES3_1		(1 << 6)
>
>Should we add a little space for 3430 to grow? Current TRM already defines a 3.1.2. For this version
>changes are transparent to software.  IIRC mostly internal cell tweaks to allow for expanded
>operating range.
>
>The CONTROL.CONTROL_IDCODE value is 0x0B6D 602F for OMAP34xx ES1.0.
>The CONTROL.CONTROL_IDCODE value is 0x1B7A E02F for OMAP34xx ES2.0.
>The CONTROL.CONTROL_IDCODE value is 0x2B7A E02F for OMAP34xx ES2.1.
>The CONTROL.CONTROL_IDCODE value is 0x3B7A E02F for OMAP34xx ES3.0.
>The CONTROL.CONTROL_IDCODE value is 0x4B7A E02F for OMAP34xx ES3.1.
>The CONTROL.CONTROL_IDCODE value is 0x7B7A E02F for OMAP34xx ES3.1.2.
>
>> +#define CHIP_IS_OMAP3630ES1		(1 << 7)

In that case we have to be careful.
"arch/arm/plat-omap/include/mach/cpu.h"
struct omap_chip_id {
        u8 oc;
        u8 type;
};

Type is u8 and we already are using the 8th bit now (1<<7)
So a type u8 -> u16 will also be needed.

>
>Its hard to guess how many more will come.  Ideally it will be 3630 which is growing from this point
>on.  It is faster/smaller/cheaper along with some bug fixes.
>
>Regards,
>Richard W.

