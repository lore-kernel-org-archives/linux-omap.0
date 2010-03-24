From: Thomas Weber <thomas.weber.linux@googlemail.com>
Subject: Re: [PATCH 2/9] OMAP: Devkit8000: Add missing package selection
Date: Wed, 24 Mar 2010 21:29:04 +0100
Message-ID: <4BAA7610.2060004@gmail.com>
References: <1269435138-27192-1-git-send-email-weber@corscience.de> <1269435138-27192-3-git-send-email-weber@corscience.de> <20100324125817.GJ29419@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f211.google.com ([209.85.218.211]:40572 "EHLO
	mail-bw0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756774Ab0CXU1o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 16:27:44 -0400
Received: by bwz3 with SMTP id 3so6811210bwz.29
        for <linux-omap@vger.kernel.org>; Wed, 24 Mar 2010 13:27:42 -0700 (PDT)
In-Reply-To: <20100324125817.GJ29419@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Thomas Weber <weber@corscience.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

On 24.03.2010 13:58, Felipe Balbi wrote:
> On Wed, Mar 24, 2010 at 01:52:11PM +0100, ext Thomas Weber wrote:
>> Devkit8000 uses the CUS package for OMAP3530.
>>
>> This patch adds missing package selection for CUS and enables
>> CONFIG_MUX.
>>
>> Replace whitespace with tab in Kconfig.
>>
>> Signed-off-by: Thomas Weber <weber@corscience.de>
>> ---
>> arch/arm/mach-omap2/Kconfig |    6 ++++--
>> 1 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
>> index a8a3d1e..2455dcc 100644
>> --- a/arch/arm/mach-omap2/Kconfig
>> +++ b/arch/arm/mach-omap2/Kconfig
>> @@ -59,8 +59,10 @@ config MACH_OMAP3_BEAGLE
>>     select OMAP_PACKAGE_CBB
>>
>> config MACH_DEVKIT8000
>> -        bool "DEVKIT8000 board"
>> -        depends on ARCH_OMAP3
>> +    bool "DEVKIT8000 board"
>> +    depends on ARCH_OMAP3
>> +    select OMAP_PACKAGE_CUS
>> +    select OMAP_MUX
>
> keep the formating, please.
>

Hello Felipe,

the mach_devkit8000 kconfig option is the only one of the board configs
that uses whitespaces for indention at the moment. Thatswhy I replaced
these whitespaces with  one tab.

Thomas
