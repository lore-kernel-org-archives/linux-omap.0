From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4 4/7] OMAP3630: PM: Erratum i608: disable RTA
Date: Mon, 20 Dec 2010 05:23:46 -0600
Message-ID: <4D0F3CC2.3010407@ti.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com> <1292712817-24999-5-git-send-email-nm@ti.com> <c8819161924787cb5de43492278c4e36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:54698 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754715Ab0LTLY1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 06:24:27 -0500
Received: by ywl5 with SMTP id 5so1247600ywl.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 03:24:27 -0800 (PST)
In-Reply-To: <c8819161924787cb5de43492278c4e36@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jean Pihet <jean.pihet@newoldbits.com>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

Santosh Shilimkar wrote, on 12/20/2010 12:59 AM:
[..]
>> index 3fbd1e5..cc3507b 100644
>> --- a/arch/arm/mach-omap2/sleep34xx.S
>> +++ b/arch/arm/mach-omap2/sleep34xx.S
>> @@ -45,6 +45,8 @@
>>   #define CM_IDLEST_CKGEN_V	OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST)
>>   #define SRAM_BASE_P		0x40200000
>>   #define CONTROL_STAT		0x480022F0
>> +#define CONTROL_MEM_RTA_CTRL	(OMAP343X_CTRL_BASE\
>> +					+ OMAP36XX_CONTROL_MEM_RTA_CTRL)
> Just a clarification. This register is not part of HW SAR SCM
> Registers, right ?
Right.

[..]
-- 
Regards,
Nishanth Menon
