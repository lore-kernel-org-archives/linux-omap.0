From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: Re: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
Date: Thu, 18 Nov 2010 20:38:44 +0530
Message-ID: <AANLkTimD3pW33NKbOJy+XHuDmLykEFLyviwp2LqNFPzd@mail.gmail.com>
References: <1290091906-32539-1-git-send-email-j-pihet@ti.com>
	<1290091906-32539-2-git-send-email-j-pihet@ti.com>
	<d2e0f972ca73d80e4929b605a9c2475f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:60117 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757989Ab0KRPIq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 10:08:46 -0500
Received: by mail-fx0-f47.google.com with SMTP id 11so1642611fxm.20
        for <linux-omap@vger.kernel.org>; Thu, 18 Nov 2010 07:08:45 -0800 (PST)
In-Reply-To: <d2e0f972ca73d80e4929b605a9c2475f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org, Kevin Hillman <khilman@deeprootsystems.com>, Jean Pihet-XID <j-pihet@ti.com>

NIshant,

On Thu, Nov 18, 2010 at 8:27 PM, Nishanth Menon <nm@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Jean Pihet
>> Sent: Thursday, November 18, 2010 8:52 AM
>> To: linux-omap@vger.kernel.org
>> Cc: Vishwanath BS; Kevin Hillman; Jean Pihet
>> Subject: [PATCH 1/2] OMAP3 PM: move omap3 sleep to ddr
>>
>> From: Vishwanath BS <vishwanath.bs@ti.com>
>>
>> For historical reasons the OMAP3 sleep code is run from SRAM.
>> This code can run from DDR which provides better performance and
>> leaves the SRAM available for other uses.
>>
>> Tested on ZOOM3, OMAP3EVM, Beagleboard, n900
>> with full RET and OFF modes.
>
> Sorry, But I disagree with this patch.
>
> There is a silicon errata which cannot be handled with this - RTA dis=
able
> - errata i608
>
> You need to disable RTA while coming out of OFF - we cannot handle th=
is on
>
> GP devices if this is not done.
When you come out of Core off, SRAM contents are anyway lost. So you
have to run from DDR after ROM Code completes. This behavior has not
changed with this patch. I fail to understand your concern here.

Vishwa
>
>>
>> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
>> Cc: Kevin Hillman <khilman@deeprootsystems.com>
>>
>> Changed the commit comments.
>>
>> Cc: Jean Pihet <j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/pm34xx.c | =A0 =A09 +--------
>> =A01 files changed, 1 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index 75c0cd1..035ca47 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -65,8 +65,6 @@ struct power_state {
>>
>> =A0static LIST_HEAD(pwrst_list);
>>
>> -static void (*_omap_sram_idle)(u32 *addr, int save_state);
>> -
>> =A0static int (*_omap_save_secure_sram)(u32 *addr);
>>
>> =A0static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>> @@ -346,9 +344,6 @@ void omap_sram_idle(void)
>> =A0 =A0 =A0 int core_prev_state, per_prev_state;
>> =A0 =A0 =A0 u32 sdrc_pwr =3D 0;
>>
>> - =A0 =A0 if (!_omap_sram_idle)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> -
>> =A0 =A0 =A0 pwrdm_clear_all_prev_pwrst(mpu_pwrdm);
>> =A0 =A0 =A0 pwrdm_clear_all_prev_pwrst(neon_pwrdm);
>> =A0 =A0 =A0 pwrdm_clear_all_prev_pwrst(core_pwrdm);
>> @@ -422,7 +417,7 @@ void omap_sram_idle(void)
>> =A0 =A0 =A0 =A0* get saved. The restore path then reads from this
>> =A0 =A0 =A0 =A0* location and restores them back.
>> =A0 =A0 =A0 =A0*/
>> - =A0 =A0 _omap_sram_idle(omap3_arm_context, save_state);
>> + =A0 =A0 omap34xx_cpu_suspend(omap3_arm_context, save_state);
>> =A0 =A0 =A0 cpu_init();
>>
>> =A0 =A0 =A0 /* Restore normal SDRC POWER settings */
>> @@ -972,8 +967,6 @@ static int __init clkdms_setup(struct clockdomai=
n
>> *clkdm, void *unused)
>>
>> =A0void omap_push_sram_idle(void)
>> =A0{
>> - =A0 =A0 _omap_sram_idle =3D omap_sram_push(omap34xx_cpu_suspend,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 omap34xx_cpu_suspend_sz);
>> =A0 =A0 =A0 if (omap_type() !=3D OMAP2_DEVICE_TYPE_GP)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 _omap_save_secure_sram =3D
>> omap_sram_push(save_secure_ram_context,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 save_sec=
ure_ram_context_sz);
>> --
>> 1.7.2.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
