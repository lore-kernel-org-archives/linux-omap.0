From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [Suggestion] ARM: allmodconfig: about cross compiling failure
 under i386 ubuntu.
Date: Thu, 22 Aug 2013 18:15:04 +0800
Message-ID: <5215E4A8.1010802@asianux.com>
References: <521479B4.8030604@asianux.com> <52147AC6.9040300@asianux.com> <52147E12.4060401@asianux.com> <20130822074524.GS7656@atomide.com> <5215D7B9.50105@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:28806 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab3HVKQH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Aug 2013 06:16:07 -0400
In-Reply-To: <5215D7B9.50105@asianux.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 08/22/2013 05:19 PM, Chen Gang wrote:
> On 08/22/2013 03:45 PM, Tony Lindgren wrote:
>> * Chen Gang <gang.chen@asianux.com> [130821 01:53]:
>>> Hello Maintainers:
>>>
>>> When build arm with allmodconfig under ubuntu i386 with arm-linux-
>>> gnueabi-gcc 4.7, as 2.22, it report the errors.
>>>
>>> Please help check, thanks (the related config file in attachment).
>>
>> It seems that some make flags may need to be specified separately
>> in some makefiles. See the following for some examples:
>>
>> $ find arch/arm -name Makefile | xargs grep -i flags
>>
>> I'm getting different errors though, I'm getting:
>>
>> arch/arm/mach-zynq/hotplug.c:1: error: bad value (cortex-a9) for -mcpu= switch
>>
>> As probably my compiler does not support the cortex-a9 switch,
>> I have gcc version 4.3.5 (Debian 4.3.5-4), tried with v3.11-rc5.
>>

Maybe your case is different with my case (but may be the same solving
ways).

After compare the 'flags', for my case, the root cause is:

  "for allmodconfig, it will enable CPU_V6 which VEXPRESS doesn't support".

  after disable CPU_V6 after allmodconfig, it can pass compiling:
    ("System type" -> "Multiple platform selection" -> "ARMv6 based platforms").

Welcome any additional suggestions or completions, if no additional
reply, I will try to send the related patch tomorrow. :-)

Thanks.

> 
> Thank you for your valuable reply, I followed what you said above, and
> now it seems really related the compiler's flags.
> 
> I have passed compiling for the VEXPRESS with dcscb, I will compare the
> difference between the 2 building flags.
> 
> It seems we need add the related dependency for ARCH_VEXPRESS (I am just
> analyzing, may get final result today).
> 
> 
> Thanks.
> 
> 
>> Regards,
>>
>> Tony
>>
>>
> 
> 


-- 
Chen Gang

-- 
Chen Gang
