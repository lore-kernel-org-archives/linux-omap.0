From: archit taneja <archit@ti.com>
Subject: Re: [PATCH] omap3: Adding vdd_sdi regulator supply to OMAP3EVM
Date: Mon, 21 Feb 2011 13:54:00 +0530
Message-ID: <4D622120.20209@ti.com>
References: <1297930274-16278-1-git-send-email-bryan.wu@canonical.com> <AANLkTim7Ks2n0CymKWSjpd2ND7ee1H_wKZDANBym7dnZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51597 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753048Ab1BUIWW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 03:22:22 -0500
In-Reply-To: <AANLkTim7Ks2n0CymKWSjpd2ND7ee1H_wKZDANBym7dnZ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "kernel-team@lists.ubuntu.com" <kernel-team@lists.ubuntu.com>

Hi,

On Monday 21 February 2011 12:32 PM, Bryan Wu wrote:
> Hi, would you guys take a look at this?
>
> Thanks,
> -Bryan
>
> On Thu, Feb 17, 2011 at 4:11 PM, Bryan Wu<bryan.wu@canonical.com>  wrote:
>> From: Mathieu J. Poirier<mathieu.poirier@canonical.com>
>>
>> https://bugs.launchpad.net/bugs/630885
>>
>> When booting, the omapdss subsystem is looking for a regulator named
>> "vdds_sdi". When the regulator is not found the initialisation sequence
>> is aborted resulting in omapfb not finding a display to work with.  This
>> patch allows the omapfb sub system to complete its initialisation
>> properly and enable LCD display. The problem was fixed by lumping a
>> "vdds_sdi" with the already existing "vdds_dsi" regulator. This fix
>> takes its root from work done on the Beagle board and the Pandora board.
>>
>> Signed-off-by: Mathieu Poirier<mathieu.poirier@canonical.com>
>> Signed-off-by: Andy Whitcroft<apw@canonical.com>
>> Signed-off-by: Bryan Wu<bryan.wu@canonical.com>
>> ---
>>   arch/arm/mach-omap2/board-omap3evm.c |   10 ++++++----
>>   1 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
>> index c2a0fca..8b8eb36 100644
>> --- a/arch/arm/mach-omap2/board-omap3evm.c
>> +++ b/arch/arm/mach-omap2/board-omap3evm.c
>> @@ -521,8 +521,10 @@ static struct regulator_init_data omap3_evm_vdac = {
>>   };
>>
>>   /* VPLL2 for digital video outputs */
>> -static struct regulator_consumer_supply omap3_evm_vpll2_supply =
>> -       REGULATOR_SUPPLY("vdds_dsi", "omapdss");
>> +static struct regulator_consumer_supply omap3_evm_vdds_supplies[] = {
>> +       REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
>> +       REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
>> +};

I agree that this is needed. Currently, in omap_dss_probe() in core.c we 
call sdi_init even if its not selected in menuconfig. The same goes for 
other modules.

There is no harm adding this as. But we will probably need a cleaner way 
to handle initialization of the DSS interface modules in the DSS2 code.

Regards,
Archit
