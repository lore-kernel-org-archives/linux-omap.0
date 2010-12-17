From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/7] OMAP2+: use global values for the SRAM PA addresses
Date: Fri, 17 Dec 2010 09:00:31 -0600
Message-ID: <4D0B7B0F.4060304@ti.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com>	<1292580506-4421-3-git-send-email-j-pihet@ti.com>	<4D0B66ED.8030302@ti.com> <AANLkTimYoa3baXbcwOOx-xXLXiEbKmiEWj1xR3xVCC=+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:51043 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755019Ab0LQPAl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 10:00:41 -0500
Received: by gwj22 with SMTP id 22so407210gwj.28
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 07:00:35 -0800 (PST)
In-Reply-To: <AANLkTimYoa3baXbcwOOx-xXLXiEbKmiEWj1xR3xVCC=+@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

Jean Pihet had written, on 12/17/2010 08:59 AM, the following:
>>>
>>> diff --git a/arch/arm/mach-omap2/sdrc.h b/arch/arm/mach-omap2/sdrc.h
>>> index 68f57bb..b3f8379 100644
>>> --- a/arch/arm/mach-omap2/sdrc.h
>>> +++ b/arch/arm/mach-omap2/sdrc.h
>>> @@ -74,5 +74,4 @@ static inline u32 sms_read_reg(u16 reg)
>>>  */
>>>  #define SDRC_MPURATE_LOOPS             96
>>>  -
>> spurious change.
> Cosmetic change!
yep, does not belong to this patch :)

>> http://pastebin.mozilla.org/889933
> Nice test script btw

you are welcome, hope it is useful.

-- 
Regards,
Nishanth Menon
