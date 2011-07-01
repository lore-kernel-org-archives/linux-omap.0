From: Mohan V <mohanvforum@gmail.com>
Subject: Re: OMAP3: Enabling IO Daisy Chain
Date: Fri, 1 Jul 2011 08:35:26 +0530
Message-ID: <BANLkTik5KweiHis-TNjv8mTzSayieD+dgA@mail.gmail.com>
References: <BANLkTinw1Qz7Q7H0n+d=3WA93Hpzty_g5w@mail.gmail.com>
	<87oc1ec2sv.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34967 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab1GADF1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 23:05:27 -0400
Received: by vxb39 with SMTP id 39so2081400vxb.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Jun 2011 20:05:26 -0700 (PDT)
In-Reply-To: <87oc1ec2sv.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>

Kevin,

On Fri, Jul 1, 2011 at 5:03 AM, Kevin Hilman <khilman@ti.com> wrote:
> +Tero
>
> Mohan V <mohanvforum@gmail.com> writes:
>
>> Hello all,
>>
>> I am trying to correct the implementation of the enabling/disabling =
IO
>> daisy chain in omap3.
>
> Thanks for doing the investigation and proposing a fix!
>
>> I am following the steps as listed in the OMAP36xx TRM Sec. 3.5.7.2.=
2
>> for the same.
>
> Please add the TRM reference in the changelog (preferablly the public
> TRM reference, otherwise note it's the NDA TRM.)
>
Ok

>> Branch: linux-omap-pm: "pm" branch
>
> Patch should be generated against mainline. =A0There shouldn't be any
> dependencies on my PM branch.
>
>> config: omap2plus_defconfig
>>
>> Please find the below patch for the same.
>
> In the future, please send patches inline. =A0Any meta-comments that
> should not be in the git history can go after the '---' line in the
> changelog.
>
Ok

>> ------------------------------------------------------------
>>
>> From: Mohan <mohanv@ti.com>
>> Date: Thu, 30 Jun 2011 12:19:55 +0530
>> Subject: [PATCH] omap3: pm: correct enable/disable of daisy io chain
>>
>> Currently the enabling and disabling of IO Daisy chain is not
>> according to the TRM.
>> The below steps are followed to enable/disable the IO chain.
>>
>> Steps to enable IO chain:
>> (a) Set PM_WKEN_WKUP.EN_IO bit
>> (b) Set the PM_WKEN_WKUP.EN_IO_CHAIN bit
>> (c) Poll for PM_WKST_WKUP.ST_IO_CHAIN. When set to 1, clear it.
>>
>> Steps to disable IO chain:
>> [a] Clear PM_WKEN_WKUP.EN_IO_CHAIN bit
>> [b] Clear PM_WKEN_WKUP.EN_IO bit
>> [c] Clear PM_WKST_WKUP.ST_IO bit by writing 1 to it.
>
> Here, please report what platforms this was tested on. =A0It should a=
t
> least be tested using off-mode on 3430 and 3630.
>
> Also, I think we need to skip step 'c' of both, since that part will =
be
> handled later by the PRCM interrup handler. =A0If we clear them here,=
 by
> the time the PRCM interrupt handler runs, we won't be able to detect
> there was a wakeup.
>
Thanks Kevin. By skipping the step [c] in both cases, I am not seeing
the warnings.
I shall post an updated patch.

Regards,
Mohan

> Kevin
>
>> Signed-off-by: Mohan V <mohanv@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/pm34xx.c | =A0 =A07 ++++---
>> =A01 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index d8c00e4..7f0d371 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -91,7 +91,7 @@ static void omap3_enable_io_chain(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Do a readback to assure write has bee=
n done */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 prm_read_mod_reg(WKUP_MOD, PM_WKEN);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 while (!(prm_read_mod_reg(WKUP_MOD, PM_WKE=
N) &
>> + =A0 =A0 =A0 =A0 =A0 =A0 while (!(prm_read_mod_reg(WKUP_MOD, PM_WKS=
T) &
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP3430_ST_IO_CHAIN_=
MASK)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout++;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (timeout > 1000) {
>> @@ -99,9 +99,9 @@ static void omap3_enable_io_chain(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0"activation failed.\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prm_set_mod_reg_bits(OMAP3=
430_ST_IO_CHAIN_MASK,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0WKUP_MOD, PM_WKEN);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_=
MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0WKUP_MOD, PM_WKST);
>> =A0 =A0 =A0 }
>> =A0}
>>
>> @@ -572,6 +572,7 @@ void omap_sram_idle(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 core_next_state < PWRDM_=
POWER_ON) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 prm_clear_mod_reg_bits(OMAP3430_EN_IO_MA=
SK, WKUP_MOD, PM_WKEN);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_disable_io_chain();
>> + =A0 =A0 =A0 =A0 =A0 =A0 prm_set_mod_reg_bits(OMAP3430_ST_IO_MASK, =
WKUP_MOD, PM_WKST);
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 pwrdm_post_transition();
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
