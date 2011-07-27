From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH] OMAP: ctrl: Fix CONTROL_DSIPHY register fields
Date: Wed, 27 Jul 2011 11:06:11 +0200
Message-ID: <4E2FD503.7080505@ti.com>
References: <1311747632-26899-1-git-send-email-archit@ti.com> <4E2FAE64.7020806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56620 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab1G0JGO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jul 2011 05:06:14 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6R96DVQ018982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 27 Jul 2011 04:06:13 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p6R96DUG010123
	for <linux-omap@vger.kernel.org>; Wed, 27 Jul 2011 04:06:13 -0500 (CDT)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6R96DBF023533
	for <linux-omap@vger.kernel.org>; Wed, 27 Jul 2011 04:06:13 -0500 (CDT)
In-Reply-To: <4E2FAE64.7020806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "Taneja, Archit" <archit@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 7/27/2011 8:21 AM, Shilimkar, Santosh wrote:
> + Benoit

Thanks Santosh,


Archit,

Could you please send your patch to all the authors of the file, including the maintainers?

Without Santosh, I would have missed that one, that seems to highlight a bug in the HW description DB. So it is quite critical to capture such issue ASAP with HW designers.

> On 7/27/2011 11:50 AM, Archit Taneja wrote:
>> Fix the shift and mask macros for DSIx_PPID fields in CONTROL_DSIPHY. The Latest
>> TRM mentions the correct fields in the register.
> You can mention the TRM version instead of 'latest'
> Latest is very much relative :)
> 
>>
>> Signed-off-by: Archit Taneja<archit@ti.com>
> Change looks good to me.
> Autogen scripts needs to be checked as well.
> 
>> ---
>>    .../include/mach/ctrl_module_pad_core_44xx.h       |    8 ++++----
>>    1 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h b/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
>> index c88420d..8321add 100644
>> --- a/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
>> +++ b/arch/arm/mach-omap2/include/mach/ctrl_module_pad_core_44xx.h
>> @@ -941,10 +941,10 @@
>>    #define OMAP4_DSI2_LANEENABLE_MASK				(0x7<<   29)
>>    #define OMAP4_DSI1_LANEENABLE_SHIFT				24
>>    #define OMAP4_DSI1_LANEENABLE_MASK				(0x1f<<   24)
>> -#define OMAP4_DSI1_PIPD_SHIFT					19
>> -#define OMAP4_DSI1_PIPD_MASK					(0x1f<<   19)
>> -#define OMAP4_DSI2_PIPD_SHIFT					14
>> -#define OMAP4_DSI2_PIPD_MASK					(0x1f<<   14)
>> +#define OMAP4_DSI1_PIPD_SHIFT					14
>> +#define OMAP4_DSI1_PIPD_MASK					(0x1f<<   14)
>> +#define OMAP4_DSI2_PIPD_SHIFT					19
>> +#define OMAP4_DSI2_PIPD_MASK					(0x1f<<   19)

Minor comment, but since this is sorted per shift value, the order should be:

+#define OMAP4_DSI2_PIPD_SHIFT                                  19
+#define OMAP4_DSI2_PIPD_MASK                                   (0x1f << 19)
+#define OMAP4_DSI1_PIPD_SHIFT                                  14
+#define OMAP4_DSI1_PIPD_MASK                                   (0x1f << 14)

Once you fix the changelog with Santosh comment, put the proper people in the TO list, and fix the order, you can add:

Acked-by: Benoit Cousson <b-cousson@ti.com>

Regards,
Benoit
