From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH resend 1/3] AM35x: Add musb support
Date: Mon, 05 Jul 2010 14:02:50 +0400
Message-ID: <4C31ADCA.40607@ru.mvista.com>
References: <1278053879-6850-1-git-send-email-ajay.gupta@ti.com> <20100705095015.GP15951@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42373 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0GEKD4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 06:03:56 -0400
In-Reply-To: <20100705095015.GP15951@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, felipe.balbi@nokia.com

Hello.

Tony Lindgren wrote:

>> AM35x has musb interface (version 1.8) and uses CPPI41 DMA engine.
>> It has USB phy built inside the IP itself.
>>
>> Also added ARCH_AM35x which is required to differentiate musb ips
>> between OMAP3x and AM35x. This config would be used for below purposes,
>>         - Select am35x.c instead of omap2430.c for compilation
>>           at drivers/usb/musb directory. Please note there are
>>           significant differneces in these two files as musb ip
>>           in quite different on AM35x.
>>         - Select workaround codes applicable for AM35x musb issues.
>>           one such workaround is for bytewise read issue on AM35x.

> <snip>

>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>> index b31b6f1..52a6752 100644
>> --- a/arch/arm/mach-omap2/Kconfig
>> +++ b/arch/arm/mach-omap2/Kconfig
>> @@ -84,6 +84,7 @@ config MACH_OMAP3517EVM
>>  	bool "OMAP3517/ AM3517 EVM board"
>>  	depends on ARCH_OMAP3
>>  	select OMAP_PACKAGE_CBB
>> +	select ARCH_AM35x
>>  
>>  config MACH_OMAP3_PANDORA
>>  	bool "OMAP3 Pandora"

> No thanks..

>> --- a/arch/arm/plat-omap/Kconfig
>> +++ b/arch/arm/plat-omap/Kconfig
>> @@ -5,6 +5,14 @@ menu "TI OMAP Implementations"
>>  config ARCH_OMAP_OTG
>>  	bool
>>  
>> +config ARCH_AM35x
>> +	bool
>> +	help
>> +	  Select this option if your platform is based on AM35x. As
>> +	  AM35x has an updated MUSB with CPPI4.1 DMA so this config
>> +	  is introduced to differentiate musb ip between OMAP3x and
>> +	  AM35x platforms.
>> +
>>  choice
>>  	prompt "OMAP System Type"
>>  	default ARCH_OMAP2PLUS

> ..this should not be needed.

    I think Ajay has explained why it's needed. The option is necessary in one 
or another form.

> Regards,
> Tony

WBR, Sergei
