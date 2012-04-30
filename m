From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH/RFT 6/8] ARM: OMAP: remove unused cpu_is_omap3505()
Date: Mon, 30 Apr 2012 11:35:43 +0200
Message-ID: <2D046CE0-37F1-4C35-B7B1-1B75203DE147@dominion.thruhere.net>
References: <1335482993-14035-1-git-send-email-khilman@ti.com> <1335482993-14035-7-git-send-email-khilman@ti.com> <CAORVsuVYXooj5CPzZZhOL8asmoX5X1bB=D-7pyf4McgKOATmyg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:39748 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133Ab2D3Jfr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 05:35:47 -0400
Received: by wgbdr13 with SMTP id dr13so364193wgb.1
        for <linux-omap@vger.kernel.org>; Mon, 30 Apr 2012 02:35:46 -0700 (PDT)
In-Reply-To: <CAORVsuVYXooj5CPzZZhOL8asmoX5X1bB=D-7pyf4McgKOATmyg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Op 30 apr. 2012, om 11:07 heeft Jean Pihet het volgende geschreven:

> Kevin,
> 
> On Fri, Apr 27, 2012 at 1:29 AM, Kevin Hilman <khilman@ti.com> wrote:
>> The 3505 check is now unused and can be removed.
>> 
>> There are no longer any cpu_is_* checks that depend on specific IP
>> detection.
>> 
>> Acked-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> Tested-by: Vaibhav Hiremath <hvaibhav@ti.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>>  arch/arm/plat-omap/include/plat/cpu.h |    8 +-------
>>  1 file changed, 1 insertion(+), 7 deletions(-)
>> 
>> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
>> index 41f3e5a..b34bf6c 100644
>> --- a/arch/arm/plat-omap/include/plat/cpu.h
>> +++ b/arch/arm/plat-omap/include/plat/cpu.h
>> @@ -250,8 +250,7 @@ IS_AM_SUBCLASS(335x, 0x335)
>>  * cpu_is_omap2423():  True for OMAP2423
>>  * cpu_is_omap2430():  True for OMAP2430
>>  * cpu_is_omap3430():  True for OMAP3430
>> - * cpu_is_omap3505():  True for OMAP3505
>> - * cpu_is_omap3517():  True for OMAP3517
>> + * cpu_is_omap3517():  True for AM35x: OMAP3517, OMAP3505
> Is cpu_is_omap35xx() a better name for it?

No, since 3530 is the same as 3430 :(

regards,

Koen