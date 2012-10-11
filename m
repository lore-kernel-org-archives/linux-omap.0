From: Ricardo Neri <ricardo.neri@ti.com>
Subject: Re: [PATCH] ARM: OMAP4: hwmod data: Add McASP data port address space
Date: Thu, 11 Oct 2012 12:30:48 -0500
Message-ID: <50770248.7000704@ti.com>
References: <1348763614-4298-1-git-send-email-ricardo.neri@ti.com> <5074319B.10903@ti.com> <50769F87.80104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52779 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932758Ab2JKRcw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Oct 2012 13:32:52 -0400
In-Reply-To: <50769F87.80104@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: tony@atomide.com, jon-hunter@ti.com, linux-omap@vger.kernel.org

Hi Benoit,

Thanks for reviewing!

On 10/11/2012 05:29 AM, Benoit Cousson wrote:
> Hi Ricardo,
>
> On 10/09/2012 04:15 PM, Ricardo Neri wrote:
>> Hi Benoit,
>>
>> Have you had a chance to look at this patch? Maybe you want me to submit
>> it differently or to a different list?
>
> Sorry, I missed it. It looks fine and aligned with what I have done for
> OMAP5. I just have few minors comments.
>
>>
>> Thanks!
>>
>> Ricardo
>>
>> On 09/27/2012 11:33 AM, Ricardo Neri wrote:
>>> McASP has a configuration port and a data port. This patch adds the
>>> address
>>> space entry for the data port as described in the OMAP4 TRM.
>>>
>>> Also, add names to the address spaces.
>>>
>>> Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
>>> ---
>>>    arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    6 ++++++
>>>    1 files changed, 6 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> index f31f3bc..cb5b463 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> @@ -4951,10 +4951,16 @@ static struct omap_hwmod_ocp_if
>>> omap44xx_l4_abe__mcasp = {
>>>
>>>    static struct omap_hwmod_addr_space omap44xx_mcasp_dma_addrs[] = {
>>>        {
>>> +        .name        = "cfg",
>>>            .pa_start    = 0x49028000,
>>>            .pa_end        = 0x490283ff,
>>>            .flags        = ADDR_TYPE_RT
>>>        },
>>> +    {
>>> +        .name        = "dat",
>>> +        .pa_start    = 0x4902A000,
>
> You should use lower case for hex number.

Ok, I'll do it.
>
>>> +        .pa_end        = 0x4902Afff,
>
> In the data I have, the end is 0x4012a3ff.
> Do we need to extend it to fff?

Not sure. I took this number from the Table 2-7 of OMAP4 TRM. In 
general, I see that the .pa_end values for several modules in 
omap_hwmod_44xx_data.c do not match the Chapter 2 of OMAP4 TRM. Examples 
of this are omap44xx_aess_addrs, omap44xx_mcbsp1/2/3_addrs, 
omap44xx_dmic_addrs, omap44xx_dss_addrs, omap44xx_dss_dsi1_addrs, 
omap44xx_dss_dsi2_addrs. Is there any reason for this? Maybe your data 
is more accurate.

BR,

Ricardo


>
> Regards,
> Benoit
>
