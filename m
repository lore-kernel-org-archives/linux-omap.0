From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] omap4: hwmod: Enable the keypad
Date: Thu, 19 May 2011 16:17:07 +0530
Message-ID: <4DD4F52B.5070209@ti.com>
References: <1298526157-2856-1-git-send-email-shubhrajyoti@ti.com> <4D6639DF.2040009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:49811 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753911Ab1ESKrP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 06:47:15 -0400
Received: by yia27 with SMTP id 27so1130656yia.5
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 03:47:14 -0700 (PDT)
In-Reply-To: <4D6639DF.2040009@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 24 February 2011 04:28 PM, Cousson, Benoit wrote:
> On 2/24/2011 6:42 AM, Datta, Shubhrajyoti wrote:
>> From: Shubhrajyoti D<shubhrajyoti@ti.com>
>>
>> Enable the keypad in the hwmod database.
>>
>> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
>> Cc: Benoit Cousson<b-cousson@ti.com>
>
> Acked-by: Benoit Cousson<b-cousson@ti.com>
Could this patch be queued for the next merge window. If there are no 
further comments.
Thanks and regards,

>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c 
>> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> index 79a8601..5af80d6 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -5056,7 +5056,7 @@ static __initdata struct omap_hwmod 
>> *omap44xx_hwmods[] = {
>> &omap44xx_iva_seq1_hwmod,
>>
>>       /* kbd class */
>> -/* &omap44xx_kbd_hwmod, */
>> + &omap44xx_kbd_hwmod,
>>
>>       /* mailbox class */
>> &omap44xx_mailbox_hwmod,
>

