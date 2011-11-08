From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] OMAP2+: Fix Compilation error on current mainline
Date: Tue, 08 Nov 2011 16:24:26 +0530
Message-ID: <4EB90A62.7010206@ti.com>
References: <4EB7E50D.40406@ti.com> <1320733698-23411-1-git-send-email-govindraj.raja@ti.com> <4EB908A1.40404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:60309 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750892Ab1KHKyd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Nov 2011 05:54:33 -0500
Received: by mail-yw0-f42.google.com with SMTP id 26so428123ywb.29
        for <linux-omap@vger.kernel.org>; Tue, 08 Nov 2011 02:54:32 -0800 (PST)
In-Reply-To: <4EB908A1.40404@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Tuesday 08 November 2011 04:16 PM, Cousson, Benoit wrote:
> Hi Govind,
> 
> On 11/8/2011 7:28 AM, Govindraj.R wrote:
>> Patch to fix below compilation error on latest mainline commit
>> b32fc0a0629bf5894b35f33554c118aacfd0d1e2 with omap2plus_defconfig.
>>
>> arch/arm/mach-omap2/omap_l3_noc.c:250: error: 'THIS_MODULE' undeclared
>> here (not in a function)
>> make[1]: *** [arch/arm/mach-omap2/omap_l3_noc.o] Error 1
>>
>> Signed-off-by: Govindraj.R<govindraj.raja@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_l3_noc.c |    1 +
>>   1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_l3_noc.c
>> b/arch/arm/mach-omap2/omap_l3_noc.c
>> index c8b1bef..c2cc196 100644
>> --- a/arch/arm/mach-omap2/omap_l3_noc.c
>> +++ b/arch/arm/mach-omap2/omap_l3_noc.c
>> @@ -26,6 +26,7 @@
>>   #include<linux/interrupt.h>
>>   #include<linux/kernel.h>
>>   #include<linux/slab.h>
>> +#include<linux/module.h>
> 
> That one is already fixed by Axel Lin, and already pulled by Tony.
> 
> http://www.spinics.net/lists/linux-omap/msg59847.html
> 
> This is the missing semi-colon that still need to be fixed.
> 
Opps. I missed that one while acking the patch.
Indeed the semi-colon one was agreed to be the left over
in the last patch discussion.

Regards
Santosh
