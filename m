From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: hwmod data: Add McASP data port address space
Date: Thu, 11 Oct 2012 12:29:27 +0200
Message-ID: <50769F87.80104@ti.com>
References: <1348763614-4298-1-git-send-email-ricardo.neri@ti.com> <5074319B.10903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43080 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758453Ab2JKK3d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Oct 2012 06:29:33 -0400
In-Reply-To: <5074319B.10903@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: tony@atomide.com, jon-hunter@ti.com, linux-omap@vger.kernel.org

Hi Ricardo,

On 10/09/2012 04:15 PM, Ricardo Neri wrote:
> Hi Benoit,
> 
> Have you had a chance to look at this patch? Maybe you want me to submit
> it differently or to a different list?

Sorry, I missed it. It looks fine and aligned with what I have done for
OMAP5. I just have few minors comments.

> 
> Thanks!
> 
> Ricardo
> 
> On 09/27/2012 11:33 AM, Ricardo Neri wrote:
>> McASP has a configuration port and a data port. This patch adds the
>> address
>> space entry for the data port as described in the OMAP4 TRM.
>>
>> Also, add names to the address spaces.
>>
>> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
>> ---
>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 ++++++
>>   1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> index f31f3bc..cb5b463 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -4951,10 +4951,16 @@ static struct omap_hwmod_ocp_if
>> omap44xx_l4_abe__mcasp = {
>>
>>   static struct omap_hwmod_addr_space omap44xx_mcasp_dma_addrs[] = {
>>       {
>> +        .name        = "cfg",
>>           .pa_start    = 0x49028000,
>>           .pa_end        = 0x490283ff,
>>           .flags        = ADDR_TYPE_RT
>>       },
>> +    {
>> +        .name        = "dat",
>> +        .pa_start    = 0x4902A000,

You should use lower case for hex number.

>> +        .pa_end        = 0x4902Afff,

In the data I have, the end is 0x4012a3ff.
Do we need to extend it to fff?

Regards,
Benoit

