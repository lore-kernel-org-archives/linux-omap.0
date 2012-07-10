From: Zumeng Chen <zumeng.chen@windriver.com>
Subject: Re: [PATCH 3/3] Watchdog: Omap: get the bootstatus for OMAP2Plus
Date: Tue, 10 Jul 2012 08:34:03 +0800
Message-ID: <4FFB787B.8010808@windriver.com>
References: <1341808779-25532-1-git-send-email-zumeng.chen@windriver.com> <1341808779-25532-4-git-send-email-zumeng.chen@windriver.com> <87ipdwx4zn.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:36698 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728Ab2GJAfH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 20:35:07 -0400
In-Reply-To: <87ipdwx4zn.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: shubhrajyoti@ti.com, wim@iguana.be, linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul.gortmaker@windriver.com

=E4=BA=8E 2012=E5=B9=B407=E6=9C=8810=E6=97=A5 00:40, Kevin Hilman =E5=86=
=99=E9=81=93:
> Zumeng Chen<zumeng.chen@windriver.com>  writes:
>
>> The offset of WKUP_MOD is not right for the PRM_RSTST of OMAP3. So h=
ere
>> put the right one to match to the actual physical addr 0x48307258, w=
hich
>> defined in PRCM Registers section.
>>
>> And there is a MPU_WD_RST bit in PRM_RSTST(0x48307258) holding the s=
ignal
>> from omap-wdt reboot, so that we can return WDIOF_CARDRESET if the b=
oard
>> wakes up from omap-wdt reboot for WDIOC_GETBOOTSTATUS ioctl.
>>
>> Signed-off-by: Zumeng Chen<zumeng.chen@windriver.com>
>> ---
>>   arch/arm/mach-omap2/prcm.c |    5 ++++-
>>   1 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
>> index 480f40a..4dcc706 100644
>> --- a/arch/arm/mach-omap2/prcm.c
>> +++ b/arch/arm/mach-omap2/prcm.c
>> @@ -49,8 +49,11 @@ void __iomem *prcm_mpu_base;
>>   u32 omap_prcm_get_reset_sources(void)
>>   {
>>   	/* XXX This presumably needs modification for 34XX */
> While you're fixing this for OMAP3, you can remove this comment as we=
ll.
No problem, I'll update it in V2. Thanks for your kind reminder :-)

Regards,
Zumeng
>
>> -	if (cpu_is_omap24xx() || cpu_is_omap34xx())
>> +	if (cpu_is_omap24xx())
>>   		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST)&  0x7f;
>> +	if (cpu_is_omap34xx())
>> +		return omap2_prm_read_mod_reg(OMAP3430_GR_MOD, OMAP2_RM_RSTST)&
>> +		       0x7f;
>>   	if (cpu_is_omap44xx())
>>   		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST)&  0x7f;
> Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
