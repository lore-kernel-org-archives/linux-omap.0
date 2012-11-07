From: R Sricharan <r.sricharan@ti.com>
Subject: Re: OMAP4/Panda: u-boot upgrade v2012.04.01 -> v2012.10 breaks RTC
 wakeups
Date: Wed, 7 Nov 2012 11:08:02 +0530
Message-ID: <5099F3BA.6090302@ti.com>
References: <87obja9r3x.fsf@deeprootsystems.com> <5099B0FB.3060203@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39425 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab2KGFiU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 00:38:20 -0500
In-Reply-To: <5099B0FB.3060203@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, u-boot@lists.denx.de, linux-omap <linux-omap@vger.kernel.org>, trini@ti.com

Hi Kevin,
  In the latest, pad mux and clocks for all
  non-essential modules at U-BOOT were removed.

  This might also cause the problem.
  We can bring this back in u-boot by adding the following macros
  and check if it works fine again.

   include/configs/omap4_common.h
   ------------------------------
   #define CONFIG_SYS_ENABLE_PADS_ALL
   #define CONFIG_SYS_CLOCKS_ENABLE_ALL


Regards,
  Sricharan


On Wednesday 07 November 2012 06:23 AM, Santosh Shilimkar wrote:
> + Sricharan,
>
> On Tuesday 06 November 2012 06:46 PM, Kevin Hilman wrote:
>> Hello,
>>
>> I just noticed that the kernel wakeup from suspend using RTC is broken
>> after I upgraded u-boot from v2012.04.01 to v2012.10 on my
>> OMAP4430/Panda and OMAP4460/Panda-ES.
>>
>> I haven't isolated the cause yet, but am hoping someone might have a
>> pointer about where to start digging.
>>
>> Kevin
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>


