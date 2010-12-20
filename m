From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4 2/7] OMAP3: PM: Erratum i581 support: dll kick strategy
Date: Mon, 20 Dec 2010 08:16:55 -0600
Message-ID: <4D0F6557.2090101@ti.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com> <1292712817-24999-3-git-send-email-nm@ti.com> <ff992259ca9324925ce680a11cae0245@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:59124 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757445Ab0LTOQ7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Dec 2010 09:16:59 -0500
Received: by yxs7 with SMTP id 7so1667194yxs.24
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 06:16:58 -0800 (PST)
In-Reply-To: <ff992259ca9324925ce680a11cae0245@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jean Pihet <jean.pihet@newoldbits.com>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

Santosh Shilimkar had written, on 12/20/2010 12:47 AM, the following:
[..]
>> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-
>> omap2/sleep34xx.S
>> index 2c20fcf..3fbd1e5 100644
>> --- a/arch/arm/mach-omap2/sleep34xx.S
>> +++ b/arch/arm/mach-omap2/sleep34xx.S
>> @@ -42,6 +42,7 @@
>>  				OMAP3430_PM_PREPWSTST)
>>  #define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD +
>> OMAP2_PM_PWSTCTRL
>>  #define CM_IDLEST1_CORE_V	OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)
>> +#define CM_IDLEST_CKGEN_V	OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST)
> We need to avoid these macro's calculating VA directly. But I guess
> it needs to be done more than just this line and hence can be done
> in a separate patch.
yes - with the cleanups planned for this file, we could probably add it 
to that set I guess.

-- 
Regards,
Nishanth Menon
