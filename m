From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] omap: Fix 35xx detection (Re: [PATCH] [RFC] omap: 3630:
 default cpu_is_omap3630 to zero)
Date: Tue, 13 Oct 2009 13:31:58 -0500
Message-ID: <4AD4C79E.4050601@ti.com>
References: <1255380685-26765-1-git-send-email-vikram.pandita@ti.com> <20091013171814.GT12700@atomide.com> <20091013173233.GU12700@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33906 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760720AbZJMScg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Oct 2009 14:32:36 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9DIVxQN013585
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 13:32:00 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n9DIVxvF021421
	for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 13:31:59 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9DIVxB7000897
	for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 13:31:59 -0500 (CDT)
In-Reply-To: <20091013173233.GU12700@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony Lindgren had written, on 10/13/2009 12:32 PM, the following:
> * Tony Lindgren <tony@atomide.com> [091013 10:18]:
>> * Vikram Pandita <vikram.pandita@ti.com> [091012 14:31]:
>>> make default cpu_is_omap3630() return zero
>>>
>>> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
>>> ---
>>>  arch/arm/plat-omap/include/mach/cpu.h |    2 ++
>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
>>> index da9e8f8..940946e 100644
>>> --- a/arch/arm/plat-omap/include/mach/cpu.h
>>> +++ b/arch/arm/plat-omap/include/mach/cpu.h
>>> @@ -322,6 +322,7 @@ IS_OMAP_TYPE(3430, 0x3430)
>>>  #define cpu_is_omap2423()		0
>>>  #define cpu_is_omap2430()		0
>>>  #define cpu_is_omap3430()		0
>>> +#define cpu_is_omap3630()		0
>>>  
>>>  /*
>>>   * Whether we have MULTI_OMAP1 or not, we still need to distinguish
>>> @@ -386,6 +387,7 @@ IS_OMAP_TYPE(3430, 0x3430)
>>>  						(omap3_has_sgx()) &	\
>>>  						(!omap3_has_iva()))
>>>  # define cpu_is_omap3530		(cpu_is_omap3430())
>>> +# undef cpu_is_omap3630()
>>>  # define cpu_is_omap3630()		is_omap363x()
wondering what the standard is:
  # define cpu_is_omap3430()		is_omap3430()
so is it
  #define cpu_is_omapXXXX() 		blah blah
or
  #define cpu_is_omapXXXX		blah blah
would have though it is  cpu_is_omapXXXX()

Regards,
Nishanth Menon
