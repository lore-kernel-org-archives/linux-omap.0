From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PM-WIP-OPP] [PATCH] cleaner ceil function for uv to vsel conversion
Date: Tue, 12 Jan 2010 06:08:09 -0600
Message-ID: <4B4C6629.2040100@gmail.com>
References: <1263189218.16324.3.camel@boson> <876378mg2a.fsf@deeprootsystems.com> <4B4C39BB.5090409@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:38149 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab0ALMIN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 07:08:13 -0500
Received: by yxe17 with SMTP id 17so21262632yxe.33
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 04:08:12 -0800 (PST)
In-Reply-To: <4B4C39BB.5090409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Romit Dasgupta <romit@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Romit Dasgupta said the following on 01/12/2010 02:58 AM:
> Kevin Hilman wrote:
>   
>> Romit Dasgupta <romit@ti.com> writes:
>>
>>     
>>> Cleaner ceil function.
>>>       
>> Needs better subject and better changelog.
>>
>> Subject should probably be something like: OMAP: 
>>
>>   [PATCH] OPP: TWL/TPS: optimize uv to vsel function
>>
>> And changelog should describe the motiviation for the patch or a
>> description of the problem you're trying to solve.
>>     
> The description of the problem is "Cleaner ceil function for uv to vsel
> conversion".
>
> I think this patch is simple enough for people on this list to understand the
> optimization. I am sorry I cant be more descriptive.
>
>   
here is a try:
-----

 From patchwork Thu Dec 31 13:29:05 2009
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [pm-wip-opp] [PATCH] opp: twl/tps: optimize uv to vsel function
Date: Thu, 31 Dec 2009 13:29:05 -0000
From: Dasgupta, Romit <romit@ti.com>
X-Patchwork-Id: 70374


For integer values x and y; int div x / y causes truncation. Current
omap_twl_uv_to_vsel function implements an equivalent of ceil which
is based on an if condition to check truncation and round up.
We can do this in a more optimal manner without the if condition.
The round up is handled by adding the round off factor prior to
truncation as:
(x + (y - 1)) / y

---
Currently putting signed-off in --- section. If Romit is ok, please 
re-send as needed.
Signed-off-by: Dasgupta, Romit <romit@ti.com>

diff --git a/arch/arm/plat-omap/opp_twl_tps.c 
b/arch/arm/plat-omap/opp_twl_tps.c
index e0db39b..43dee2d 100644
--- a/arch/arm/plat-omap/opp_twl_tps.c
+++ b/arch/arm/plat-omap/opp_twl_tps.c
@@ -36,14 +36,7 @@ unsigned long omap_twl_vsel_to_uv(const u8 vsel)
  */
 u8 omap_twl_uv_to_vsel(unsigned long uv)
 {
-    u8 vsel;
+    /* Takes care of precision loss due to integer division */
+    return (((uv + 99) / 100 - 6000) + 124) / 125;
 
-    vsel = ((uv / 100) - 6000) / 125;
-
-    /* round off to higher voltage */
-    /* XXX Surely not the best way to handle this. */
-    if (uv > omap_twl_vsel_to_uv(vsel))
-        vsel++;
-
-    return vsel;
 }
