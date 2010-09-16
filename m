From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v5 6/6] OMAP: WDT: Use PM runtime APIs instead of clk
 FW APIs
Date: Thu, 16 Sep 2010 15:57:22 +0200
Message-ID: <4C922242.8080602@ti.com>
References: <1284528403-6494-1-git-send-email-charu@ti.com> <1284528403-6494-7-git-send-email-charu@ti.com> <4C913D7B.10208@ti.com> <EAF47CD23C76F840A9E7FCE10091EFAB02CD260574@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58370 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754880Ab0IPN5b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 09:57:31 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CD260574@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "wim@iguana.be" <wim@iguana.be>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 9/16/2010 3:37 PM, Varadarajan, Charulatha wrote:
>
>
>> From: Cousson, Benoit
>> Sent: Thursday, September 16, 2010 3:11 AM
>>
>> On 9/15/2010 7:26 AM, Varadarajan, Charulatha wrote:
>>> Call runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync()
>>> for enabling/disabling the clocks, sysconfig settings instead of using
>>> clock FW APIs.
>>>
>>> Signed-off-by: Charulatha V<charu@ti.com>
>>> ---
>>>    drivers/watchdog/omap_wdt.c |   42 +++++++----------------------------
>> -------
>>>    1 files changed, 7 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
>>> index 76b58ab..dbbc580 100644
>>> --- a/drivers/watchdog/omap_wdt.c
>>> +++ b/drivers/watchdog/omap_wdt.c
>>> @@ -38,11 +38,11 @@
>>>    #include<linux/err.h>
>>>    #include<linux/platform_device.h>
>>>    #include<linux/moduleparam.h>
>>> -#include<linux/clk.h>
>>>    #include<linux/bitops.h>
>>>    #include<linux/io.h>
>>>    #include<linux/uaccess.h>
>>>    #include<linux/slab.h>
>>> +#include<linux/pm_runtime.h>
>>>    #include<mach/hardware.h>
>>>    #include<plat/prcm.h>
>>
>> Why do you have to access the PRCM from the driver?
>
> This has nothing to do with hwmod patch series.

Yes, I know, but since you removed some include, I was wondering if that 
one was still useful.

> The reason for using prcm header is to support
> GET_BOOT_STATUS ioctl which uses "omap_prcm_get_reset_sources()"

Thanks,
Benoit
