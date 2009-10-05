From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] OMAP3: PM: Fix for Silicon bug on Context Restore on
 OMAP3430
Date: Mon, 5 Oct 2009 12:27:31 -0500
Message-ID: <4ACA2C83.9080400@ti.com>
References: <1254741761-31546-1-git-send-email-y> <87ljjpzs9p.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59721 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754070AbZJER2K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Oct 2009 13:28:10 -0400
In-Reply-To: <87ljjpzs9p.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gulati, Shweta" <shweta.gulati@ti.com>

Kevin Hilman had written, on 10/05/2009 12:04 PM, the following:
> y@india.ti.com writes:
> 
>> From: Shweta Gulati <shweta.gulati@ti.com>
> 
> Please add descriptive changelog, including Erratta number and
> summary of the bug.
> 
>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>> ---
>>  arch/arm/mach-omap2/pm34xx.c |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
>> index a9eda25..38f4781 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -140,6 +140,12 @@ static void omap3_core_save_context(void)
>>  	omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_OFF);
>>  	control_padconf_off |= START_PADCONF_SAVE;
>>  	omap_ctrl_writel(control_padconf_off, OMAP343X_CONTROL_PADCONF_OFF);
>> +	/* Due to Silicon Bug on context restore it is found
>> +	 * that the CONTROL_PAD_CONF_ETK14 register is not saved into
>> +	 * scratch pad memory sometimes. To rectify it delay acess by Mpu
>> +	 * for 300us for scm to finish saving task
>> +	 */
>> +	udelay(300);
> 
> Why 300 usecs?
300uSec could be optimized as I understand.

> Is ETK14 the only register not saved?
The bug as I understand is that the register is saved, but restore 
potentially can corrupt the values.
there is an alternative implementation possible:
a) we save the register in a seperate variable
b) we allow the restore issue to kick us (essentially allow it to be 
corrupted)
c) we over write the restored value with the saved value.
This has the risk of a glitch on the line (between the corrupted restore 
data to the time we restore with correct data).

-- 
Regards,
Nishanth Menon
