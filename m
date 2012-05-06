From: "R, Sricharan" <r.sricharan@ti.com>
Subject: Re: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
Date: Sun, 6 May 2012 13:06:25 +0530
Message-ID: <CAJ7qFSfkHGF7ehanZP=hyZ27HqSp1ONsT0tUV-wpLne9B4DEaQ@mail.gmail.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
	<1336029982-31898-3-git-send-email-r.sricharan@ti.com>
	<20120504223933.GX5613@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:45293 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751611Ab2EFHg2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 6 May 2012 03:36:28 -0400
Received: by lbbgm6 with SMTP id gm6so4116026lbb.33
        for <linux-omap@vger.kernel.org>; Sun, 06 May 2012 00:36:25 -0700 (PDT)
In-Reply-To: <20120504223933.GX5613@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, b-cousson@ti.com

Hi Tony,
[snip]
> OK this seems to be based on Santosh' Makefile cleanup.
>
 yes..

>>
>> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4) || \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 defined(CO=
NFIG_ARCH_OMAP5)
>>
>
> How about we add CONFIG_SOC_OMAP3PLUS in the clean-up series?
> Then this becomes just:
>
> #ifdef CONFIG_SOC_OMAP3PLUS
>
 Ok, thanks for the example later. I will do a cleanup patch and
rebase this one.


>> -# ifdef CONFIG_ARCH_OMAP4
>> +#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_OMAP5)
>> =A0extern int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 c=
doffs,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0u16 clkctrl_offs);
>
> And this would be:
>
> #ifdef CONFIG_SOC_OMAP4PLUS
>
 ok..

>
> Also, please change the whole series to use CONFIG_SOC_OMAP5 instead
> of CONFIG_ARCH_OMAP5. CONFIG_ARCH_OMAPXXXX stuff will go away except
> for CONFIG_ARCH_OMAP2PLUS. Sorry forgot to mention that earlier.
>
 ok. sure. will change this.


>> -#if defined(CONFIG_ARCH_OMAP4) && !(defined(CONFIG_ARCH_OMAP2) || =A0=
 =A0\
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 defined(CONFIG_ARCH_OMAP3))
>> +#if (defined(CONFIG_ARCH_OMAP5) || defined(CONFIG_ARCH_OMAP4)) && \
>> + =A0 =A0 =A0 =A0 =A0 =A0 !(defined(CONFIG_ARCH_OMAP2) || defined(CO=
NFIG_ARCH_OMAP3))
>> +
>> =A0static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
>> =A0{
>> =A0 =A0 =A0 WARN(1, "prm: omap2xxx/omap3xxx specific function and "
>
> Maybe these functions could be just set up as __weak to avoid the
> ifdeffery?
>
 sorry to understand,
 you mean make this weak and have a strong override for OMAP2 ?

>> =A0#define CK_443X =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 11)
>> =A0#define CK_TI816X =A0 =A0(1 << 12)
>> =A0#define CK_446X =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 13)
>> +#define CK_54XX =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 14)
>> =A0#define CK_1710 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 15) =A0 =A0 =A0 =
/* 1710 extra for rate selection */
>>
>>
>
> Are we going to have to patch tons of existing clocks just to add
> CK_54XX? If so, we should init clocks using SoC specific lists instea=
d.
>

>> diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat=
-omap/include/plat/clock.h
>> index d0ef57c..41858f4 100644
>> --- a/arch/arm/plat-omap/include/plat/clock.h
>> +++ b/arch/arm/plat-omap/include/plat/clock.h
>> @@ -61,6 +61,7 @@ struct clkops {
>> =A0#define RATE_IN_4460 =A0 =A0 =A0 =A0 (1 << 7)
>> =A0#define RATE_IN_AM33XX =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 8)
>> =A0#define RATE_IN_TI814X =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 9)
>> +#define RATE_IN_54XX =A0 =A0 =A0 =A0 (1 << 10)
>
> This too may have similar issues, but I guess that's really a differe=
nt
> patch series to sort out..
>
 ok. agree

>> -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
>> +#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4) \
>> + =A0 =A0 =A0 =A0 =A0 =A0 || defined(CONFIG_ARCH_OMAP5)
>> =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*autoidle_reg;
>> =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*idlest_reg;
>> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 autoidle_mas=
k;
>
>
> #ifdef CONFIG_SOC_OMAP3PLUS could be used here too
>
 ok..

Thanks,
 Sricharan
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
