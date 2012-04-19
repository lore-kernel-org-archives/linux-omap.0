From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] OMAP4: Adding ID for OMAP4460 ES1.1
Date: Thu, 19 Apr 2012 10:23:25 +0300
Message-ID: <4F8FBD6D.1040400@ti.com>
References: <1333357197-6354-1-git-send-email-rogerq@ti.com> <4F7AC721.4020205@ti.com> <20120418165008.GI21106@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56676 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790Ab2DSHX3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 03:23:29 -0400
In-Reply-To: <20120418165008.GI21106@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Chris Lalancette <clalancette@gmail.com>

Hi,

On 04/18/2012 07:50 PM, Tony Lindgren wrote:
> Hi,
> 
> * Roger Quadros <rogerq@ti.com> [120403 02:50]:
>> Hi Tony,
>>
>> Could you please take this patch for the next merge? Thanks.
> 
> Yes, it seems that this is not needed as a fix for the -rc cycle?

Right, it is not needed for this -rc cycle.
> 
> If it's needed as a fix, please let me know and also describe
> what breaks.

It does not fix anything but is just for the sake of correctness.

regards,
-roger

>  
>> On 04/02/2012 11:59 AM, Roger Quadros wrote:
>>> From: Chris Lalancette <clalancette@gmail.com>
>>>
>>> Signed-off-by: Chris Lalancette <clalancette@gmail.com>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/id.c              |    5 ++++-
>>>  arch/arm/plat-omap/include/plat/cpu.h |    1 +
>>>  2 files changed, 5 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
>>> index 0e79b7b..f139817 100644
>>> --- a/arch/arm/mach-omap2/id.c
>>> +++ b/arch/arm/mach-omap2/id.c
>>> @@ -478,9 +478,12 @@ void __init omap4xxx_check_revision(void)
>>>  	case 0xb94e:
>>>  		switch (rev) {
>>>  		case 0:
>>> -		default:
>>>  			omap_revision = OMAP4460_REV_ES1_0;
>>>  			break;
>>> +		case 2:
>>> +		default:
>>> +			omap_revision = OMAP4460_REV_ES1_1;
>>> +			break;
>>>  		}
>>>  		break;
>>>  	case 0xb975:
>>> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
>>> index dc6a86b..4bdf14e 100644
>>> --- a/arch/arm/plat-omap/include/plat/cpu.h
>>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
>>> @@ -445,6 +445,7 @@ IS_OMAP_TYPE(3517, 0x3517)
>>>  
>>>  #define OMAP446X_CLASS		0x44600044
>>>  #define OMAP4460_REV_ES1_0	(OMAP446X_CLASS | (0x10 << 8))
>>> +#define OMAP4460_REV_ES1_1	(OMAP446X_CLASS | (0x11 << 8))
>>>  
>>>  #define OMAP447X_CLASS		0x44700044
>>>  #define OMAP4470_REV_ES1_0	(OMAP447X_CLASS | (0x10 << 8))
>>

