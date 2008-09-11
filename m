From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 07/12] System Control Module context save/restore
Date: Thu, 11 Sep 2008 08:33:59 +0300
Message-ID: <48C8ADC7.9020109@deeprootsystems.com>
References: <012e01c913cb$6e5c6e90$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.184]:27233 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbYIKFeE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 01:34:04 -0400
Received: by gv-out-0910.google.com with SMTP id e6so128807gvc.37
        for <linux-omap@vger.kernel.org>; Wed, 10 Sep 2008 22:34:03 -0700 (PDT)
In-Reply-To: <012e01c913cb$6e5c6e90$LocalHost@wipultra1382>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Rajendra Nayak wrote:
>  
> 
>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>> Sent: Wednesday, September 10, 2008 8:18 PM
>> To: Rajendra Nayak
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH 07/12] System Control Module context save/restore
>>
>> "Rajendra Nayak" <rnayak@ti.com> writes:
>>
>>> This patch adds the System control module context save/restore
>>>
>>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/control.c             |  105 
>> ++++++++++++++++++++++++++++++
>>>  arch/arm/plat-omap/include/mach/control.h |   61 +++++++++++++++++
>>>  2 files changed, 165 insertions(+), 1 deletion(-)
>>>
>>> Index: linux-omap-2.6/arch/arm/mach-omap2/control.c
>>> ===================================================================
>>> --- linux-omap-2.6.orig/arch/arm/mach-omap2/control.c	
>> 2008-09-01
>>> 18:11:34.000000000 +0530
>>> +++ linux-omap-2.6/arch/arm/mach-omap2/control.c	
>> 2008-09-01 18:11:54.000000000
>>> +0530
>>> @@ -73,6 +73,8 @@ void omap_ctrl_writel(u32 val, u16 offse
>>>
>>>  #define OMAP3430_PRM_RSTST \
>>>  		OMAP34XX_PRM_REGADDR(OMAP3430_GR_MOD, RM_RSTST)
>>> +static struct omap3_control_module_regs control_ctx;
>>> +
>> I'm not sure what this patch was generated against, but it doesn't
>> apply against linux-omap.  The PRM_RSTST definition above is not in
>> linux-omap code.
>>
>> Kevin
> 
> There is no reference to PRM_RSTST in this patch. It uses RM_RSTST which
> can be found in arch/arm/mach-omap2/prm.h.

You can see in the above quoted text that your 7/12 patch adds some code
immediately after a line which defines OMAP3430_PRM_RSTST.   Since this 
existing code is not in linux-omap, and I couldn't find it in previous 
patches, it's not clear what this patch was generated against.

Kevin
