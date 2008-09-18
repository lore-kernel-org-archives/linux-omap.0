From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH PM-0] ARM: OMAP3: HSMMC: Ensure HSMMC is fully reset on boot
Date: Thu, 18 Sep 2008 16:33:34 +0300
Message-ID: <87r67ho9xt.fsf@deeprootsystems.com>
References: <1221740552-27110-1-git-send-email-khilman@deeprootsystems.com>
	<002501c9198c$8ff08430$LocalHost@wipultra1303>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:48474 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbYIRNdj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 09:33:39 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3371532fkq.5
        for <linux-omap@vger.kernel.org>; Thu, 18 Sep 2008 06:33:37 -0700 (PDT)
In-Reply-To: <002501c9198c$8ff08430$LocalHost@wipultra1303> (Madhusudhan Chikkature's message of "Thu\, 18 Sep 2008 18\:16\:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: linux-omap@vger.kernel.org

"Madhusudhan Chikkature" <madhu.cr@ti.com> writes:

> ----- Original Message ----- 
> From: "Kevin Hilman" <khilman@deeprootsystems.com>
> To: <linux-omap@vger.kernel.org>
> Cc: "Kevin Hilman" <khilman@deeprootsystems.com>
> Sent: Thursday, September 18, 2008 5:52 PM
> Subject: [PATCH PM-0] ARM: OMAP3: HSMMC: Ensure HSMMC is fully reset on boot
>
>
>> This ensures that an unused HSMMC block will not interfere with sleep.
>> 
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> ---
>> arch/arm/mach-omap2/hsmmc.c |    8 ++++++++
>> 1 files changed, 8 insertions(+), 0 deletions(-)
>> 
>> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
>> index 7334d86..03fe820 100644
>> --- a/arch/arm/mach-omap2/hsmmc.c
>> +++ b/arch/arm/mach-omap2/hsmmc.c
>> @@ -280,8 +280,16 @@ static struct omap_mmc_platform_data hsmmc_data = {
>>  },
>> };
>> 
>> +static void __init hsmmc_reset(void)
>> +{
>> +       omap_writel(MMCHS_SYSCONFIG_SWRESET, MMCHS1_SYSCONFIG);
>> +       omap_writel(MMCHS_SYSCONFIG_SWRESET, MMCHS2_SYSCONFIG);
>> +       omap_writel(MMCHS_SYSCONFIG_SWRESET, MMCHS3_SYSCONFIG);
>> +}
>> +
> Where is MMCHS1_SYSCONFIG defined?

Oops, I sent this prematurely, indeed it doesn't compile. :(

> After seting the softreset bit in SYSCONFIG, you might want to poll
> on the RESETDONE bit in SYSSTATUS to wait for the reset to complete.

OK, I'll add that.

> The interface and functional clocks should be provided before the
> reset is issued for reset to complete. At this point, I guess the
> clocks are not enabled yet.

They're not enabled by the kernel, but I believe they are enabled by
the bootloader.  Are you suggesting I add explicit clk_enable|disable
calls?

Kevin

