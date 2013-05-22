From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] arm: configs: omap2plus_defconfig: enable USB bits which
 work
Date: Wed, 22 May 2013 11:15:47 +0300
Message-ID: <519C7EB3.2040801@ti.com>
References: <1368494600-18953-1-git-send-email-balbi@ti.com> <87ip2ly7p7.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33350 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab3EVIPv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 May 2013 04:15:51 -0400
In-Reply-To: <87ip2ly7p7.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, kevin.hilman@linaro.org, Kishon Vijay Abraham I <kishon@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On 05/14/2013 05:09 PM, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
> 
>> those USB bits work fine, so we can enable them
>> safely. Plus, without USB_PHY EHCI wouldn't work
>> and it would take quite a few bogus error reports
>> until all users got the new changes.
>>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> ---
>>
>> comiple tested only. Would be great to have someone
>> testing on actual HW. Right now I don't have access
>> to my HW.
>>
>> cheers
>>
>>  arch/arm/configs/omap2plus_defconfig | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
>> index c1ef64b..a1fc0ca 100644
>> --- a/arch/arm/configs/omap2plus_defconfig
>> +++ b/arch/arm/configs/omap2plus_defconfig
>> @@ -74,6 +74,7 @@ CONFIG_CMA=y
>>  CONFIG_CONNECTOR=y
>>  CONFIG_DEVTMPFS=y
>>  CONFIG_DEVTMPFS_MOUNT=y
>> +CONFIG_OMAP_OCP2SCP=y
>>  CONFIG_MTD=y
>>  CONFIG_MTD_CMDLINE_PARTS=y
>>  CONFIG_MTD_CHAR=y
>> @@ -206,10 +207,18 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>>  CONFIG_USB_DEVICEFS=y
>>  CONFIG_USB_SUSPEND=y
>>  CONFIG_USB_MON=y
>> +CONFIG_USB_EHCI_HCD=y
> 
> NAK (on this particular change)
> 
> This cannot be enable by default yet as EHCI *still* breaks core
> retention[1] (which has been broken since at least v3.5, almost a year
> now.)

True. Due to broken smart idle/wakeup, EHCI host has to rely on
IO Daisy chaining mechanism for remote wakeup.

So this can't be fixed till we have daisy chaining working with device tree
boot. I do have an implementation that works with MACH boot but I don't see
any point in upstreaming those as we would be moving eventually to device tree
only boot.

cheers,
-roger
