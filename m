From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 23/35] ARM: OMAP2+: id: cache omap_type value
Date: Thu, 19 Mar 2015 09:23:19 +0200
Message-ID: <550A7967.5070409@ti.com>
References: <1426689860-17537-1-git-send-email-t-kristo@ti.com> <1426689860-17537-24-git-send-email-t-kristo@ti.com> <5509C2E0.8010705@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60311 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751234AbbCSHXp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Mar 2015 03:23:45 -0400
In-Reply-To: <5509C2E0.8010705@cogentembedded.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

On 03/18/2015 08:24 PM, Sergei Shtylyov wrote:
> Hello.
>
> On 03/18/2015 05:44 PM, Tero Kristo wrote:
>
>> There is no need to read the register with every invocation of the
>> function,
>> as the value is constant. Thus, cache the value in a static variable.
>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   arch/arm/mach-omap2/id.c |    5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>
>> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
>> index 2a2f4d5..1f5949f 100644
>> --- a/arch/arm/mach-omap2/id.c
>> +++ b/arch/arm/mach-omap2/id.c
>> @@ -52,7 +52,10 @@ EXPORT_SYMBOL(omap_rev);
>>
>>   int omap_type(void)
>>   {
>> -    u32 val = 0;
>> +    static u32 val = OMAP2_DEVICETYPE_MASK + 1;
>> +
>> +    if (val < OMAP2_DEVICETYPE_MASK)
>
>     <=, perhaps?

Hmm right, there is something fishy with this patch. Basically either 
comparison works as the MASK is a shifted value which is always several 
magnitudes larger than the resulting omap_type value itself. The +1 part 
in the init value is completely unnecessary though.

-Tero

>
>> +        return val;
> [...]
>
> WBR, Sergei
>

