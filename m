From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv8 04/18] I2C: OMAP: I2C register restore only if context
 is lost
Date: Tue, 17 Apr 2012 11:20:24 +0530
Message-ID: <4F8D04A0.5080303@ti.com>
References: <1334235995-6727-1-git-send-email-shubhrajyoti@ti.com> <1334235995-6727-5-git-send-email-shubhrajyoti@ti.com> <20120416181355.GK6487@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:43509 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751267Ab2DQFub (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Apr 2012 01:50:31 -0400
Received: by obbun3 with SMTP id un3so4067791obb.40
        for <linux-omap@vger.kernel.org>; Mon, 16 Apr 2012 22:50:30 -0700 (PDT)
In-Reply-To: <20120416181355.GK6487@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, w.sang@pengutronix.de, Kevin Hilman <khilman@ti.com>

On Monday 16 April 2012 11:43 PM, Tony Lindgren wrote:
> * Shubhrajyoti D <shubhrajyoti@ti.com> [120412 06:10]:
>>  Currently i2c register restore is done always.
>>  Adding conditional restore.
>>  The i2c register restore is done only if the context is lost.
>>  Also remove the definition of SYSS_RESETDONE_MASK and use the
>>  one in omap_hwmod.h.
>>
>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> ---
>>  arch/arm/plat-omap/i2c.c      |    3 ++
>>  drivers/i2c/busses/i2c-omap.c |   52 ++++++++++++++++++++++++++--------------
>>  include/linux/i2c-omap.h      |    1 +
>>  3 files changed, 38 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
>> index db071bc..4ccab07 100644
>> --- a/arch/arm/plat-omap/i2c.c
>> +++ b/arch/arm/plat-omap/i2c.c
>> @@ -179,6 +179,9 @@ static inline int omap2_i2c_add_bus(int bus_id)
>>  	 */
>>  	if (cpu_is_omap34xx())
>>  		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
>> +
>> +	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
>> +
>>  	pdev = omap_device_build(name, bus_id, oh, pdata,
>>  			sizeof(struct omap_i2c_bus_platform_data),
>>  			NULL, 0, 0);
> This should be acked by Kevin, 
I should have cced Kevin.
> adding him to Cc.
Thanks.
> For the arch/arm/plat-omap/i2c.c part:
>
> Acked-by: Tony Lindgren <tony@atomide.com>
>
Thanks.


