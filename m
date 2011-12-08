From: David Anders <x0132446@ti.com>
Subject: Re: [PATCH] omap: id: add chip id recognition for omap4430 es2.3
Date: Wed, 7 Dec 2011 18:01:43 -0600
Message-ID: <4EDFFE67.7090807@ti.com>
References: <1320689874-9179-1-git-send-email-x0132446@ti.com> <20111207234325.GR31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44187 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754200Ab1LHABq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Dec 2011 19:01:46 -0500
In-Reply-To: <20111207234325.GR31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: danders.dev@gmail.com, linux-omap@vger.kernel.org, nm@ti.com, aneesh@ti.com, jayabharath@ti.com

Tony,

On 12/07/2011 05:43 PM, Tony Lindgren wrote:
> * David Anders<x0132446@ti.com>  [111107 09:43]:
>    
>> allow for the omap4430 es2.3 revision to be recognized in the
>> omap4_check_revision() function.
>>
>> most aspects of all omap4430 es2.x versions are identical, however
>> a number of small variations such as default pullup or pulldown
>> resistor configurations vary between revisions.
>>
>> detailed information on silicon errata for omap4430 revisions can
>> be found at http://focus.ti.com/pdfs/wtbu/swpz009D.pdf
>>      
> Thanks applying into soc branch.
>
>    

i have a v2 of this patch that corrects a missing break. please apply v2 
instead

> Tony
>
>    

thanks
Dave

>> Signed-off-by: David Anders<x0132446@ti.com>
>> ---
>>   arch/arm/mach-omap2/id.c              |    6 ++++--
>>   arch/arm/plat-omap/include/plat/cpu.h |    1 +
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
>> index d27daf9..6681238 100644
>> --- a/arch/arm/mach-omap2/id.c
>> +++ b/arch/arm/mach-omap2/id.c
>> @@ -386,8 +386,10 @@ static void __init omap4_check_revision(void)
>>   			omap_revision = OMAP4430_REV_ES2_1;
>>   			break;
>>   		case 4:
>> -		default:
>>   			omap_revision = OMAP4430_REV_ES2_2;
>> +		case 6:
>> +		default:
>> +			omap_revision = OMAP4430_REV_ES2_3;
>>   		}
>>   		break;
>>   	case 0xb94e:
>> @@ -400,7 +402,7 @@ static void __init omap4_check_revision(void)
>>   		break;
>>   	default:
>>   		/* Unknown default to latest silicon rev as default */
>> -		omap_revision = OMAP4430_REV_ES2_2;
>> +		omap_revision = OMAP4430_REV_ES2_3;
>>   	}
>>
>>   	pr_info("OMAP%04x ES%d.%d\n", omap_rev()>>  16,
>> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
>> index 649b370..a2fc6d3 100644
>> --- a/arch/arm/plat-omap/include/plat/cpu.h
>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
>> @@ -416,6 +416,7 @@ IS_OMAP_TYPE(3517, 0x3517)
>>   #define OMAP4430_REV_ES2_0	(OMAP443X_CLASS | (0x20<<  8))
>>   #define OMAP4430_REV_ES2_1	(OMAP443X_CLASS | (0x21<<  8))
>>   #define OMAP4430_REV_ES2_2	(OMAP443X_CLASS | (0x22<<  8))
>> +#define OMAP4430_REV_ES2_3	(OMAP443X_CLASS | (0x23<<  8))
>>
>>   #define OMAP446X_CLASS		0x44600044
>>   #define OMAP4460_REV_ES1_0	(OMAP446X_CLASS | (0x10<<  8))
>> -- 
>> 1.7.0.4
>>
>>      

