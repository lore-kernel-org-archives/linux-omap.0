From: Henry Chan <enli.chan@gmail.com>
Subject: Re: Incorrect Register Offsets in OMAP Mailbox
Date: Thu, 08 Mar 2012 00:04:58 -0800
Message-ID: <4F58682A.7010908@gmail.com>
References: <4F3165F0.2010306@gmail.com> <20120305193417.GL12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:35730 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754456Ab2CHIE6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 03:04:58 -0500
Received: by obbuo6 with SMTP id uo6so324822obb.19
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 00:04:58 -0800 (PST)
In-Reply-To: <20120305193417.GL12083@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Sorry about that. Kind of new at this.
-H

Signed-off-by: Henry Chan <enli.chan@gmail.com>

On 03/05/12 11:34, Tony Lindgren wrote:
> Hi Henry,
> 
> * Henry Chan <enli.chan@gmail.com> [120207 09:25]:
>> Hi,
>>
>> Looks like the register offsets are incorrect in the OMAP mailbox code
>> (arch/arm/mach-omap2/mailbox.c) for the OMAP4_MAILBOX_IRQ* macros. The
>> discrepancy is with p.224 of TI document SPRUGX9 and p3891 of SWPU231K.
>> Patch attached.
>>
>> My hardware hasn't come in yet, so I would appreciate it if anyone can
>> share their experience using this code.
> 
> Can you please reply with your Signed-off-by, it's missing from the
> patch.
> 
> Thanks,
> 
> Tony
> 
>> --- a/arch/arm/mach-omap2/mailbox.c
>> +++ b/arch/arm/mach-omap2/mailbox.c
>> @@ -26,9 +26,9 @@
>>  #define MAILBOX_IRQSTATUS(u)		(0x100 + 8 * (u))
>>  #define MAILBOX_IRQENABLE(u)		(0x104 + 8 * (u))
>>  
>> -#define OMAP4_MAILBOX_IRQSTATUS(u)	(0x104 + 10 * (u))
>> -#define OMAP4_MAILBOX_IRQENABLE(u)	(0x108 + 10 * (u))
>> -#define OMAP4_MAILBOX_IRQENABLE_CLR(u)	(0x10c + 10 * (u))
>> +#define OMAP4_MAILBOX_IRQSTATUS(u)	(0x104 + 0x10 * (u))
>> +#define OMAP4_MAILBOX_IRQENABLE(u)	(0x108 + 0x10 * (u))
>> +#define OMAP4_MAILBOX_IRQENABLE_CLR(u)	(0x10c + 0x10 * (u))
>>  
>>  #define MAILBOX_IRQ_NEWMSG(m)		(1 << (2 * (m)))
>>  #define MAILBOX_IRQ_NOTFULL(m)		(1 << (2 * (m) + 1))
>>
> 
-- 
Henry Chan
