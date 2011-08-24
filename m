From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v4] OMAP4: hwmod data: I2C: add flag for context restore
Date: Wed, 24 Aug 2011 07:44:09 -0700
Message-ID: <87mxeyg98m.fsf@ti.com>
References: <1310906603-2673-1-git-send-email-shubhrajyoti@ti.com>
	<4E54D012.6050708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:49659 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751486Ab1HXOoO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 10:44:14 -0400
In-Reply-To: <4E54D012.6050708@ti.com> (shubhrajyoti@ti.com's message of "Wed,
	24 Aug 2011 15:48:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Shubhrajyoti <shubhrajyoti@ti.com> writes:

> On Sunday 17 July 2011 06:13 PM, Shubhrajyoti D wrote:
>> Restore of context is not done for OMAP4. This patch
>> adds the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE in the OMAP4
>> hwmod data which activates the restore for OMAP4.
>> Currently the OMAP4 does not hit device off still the
>> driver may have support for it.
> Could this patch be queued as well?

Paul is the maintainer for the hwmod data.   It is usually helpful to
ensure the maintainer is specifically added to the To line.

Kevin

>> Reviewed-by: Kevin Hilman<khilman@ti.com>
>> Signed-off-by: Shubhrajyoti D<shubhrajyoti@ti.com>
>> ---
>> Applies on top of patches from Andy Green
>> http://www.spinics.net/lists/linux-i2c/msg05632.html
>> Tested on OMAP4430
>>
>>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 ++-
>>   1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> index 0fe9556..5e2c748 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -2130,7 +2130,8 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
>>   };
>>
>>   static struct omap_i2c_dev_attr i2c_dev_attr = {
>> -	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE,
>> +	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE |
>> +			OMAP_I2C_FLAG_RESET_REGS_POSTIDLE,
>>   };
>>
>>   /* i2c1 */
