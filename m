From: "Pihet-XID, Jean" <j-pihet@ti.com>
Subject: Re: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
Date: Thu, 16 Jun 2011 17:30:58 +0200
Message-ID: <BANLkTimF4Wd7Kgg6a=wL_6b6Rj7uzvkxeg@mail.gmail.com>
References: <1294935563-14426-1-git-send-email-j-pihet@ti.com>
	<b52b65db02da68b3febc0c9cf1e99040@mail.gmail.com>
	<9215f5d7252a4b60f58c3e14a9d46f59@mail.gmail.com>
	<AANLkTinRZyVBu=c3cHBQ7OmJv3U8717_w8Haig4R=ZQh@mail.gmail.com>
	<86b8aab234e1451170c0937e2ab786e5@mail.gmail.com>
	<AANLkTinPxJigu8Nc5J04ciQ_c_Kw9R2xS7s1jaiqeM+F@mail.gmail.com>
	<782caeeca19758b50d370c17db11c78a@mail.gmail.com>
	<6bbd9e73b48eeb3f9f7615b19949f405@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:55837 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756166Ab1FPPbA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 11:31:00 -0400
Received: by iwn39 with SMTP id 39so1278264iwn.3
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 08:30:59 -0700 (PDT)
In-Reply-To: <6bbd9e73b48eeb3f9f7615b19949f405@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>
Cc: Jean Pihet <jean.pihet@newoldbits.com>, linux-omap@vger.kernel.org

Hi Santosh, Benoit, Kevin,

I would like to revive this discussion. Can you give some feedback on
the self-refresh problem that is proposed in the latest patch from
Santosh? Cf. below for more details.

On Fri, Feb 4, 2011 at 12:39 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Jean,
>> -----Original Message-----
>> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
>> Sent: Tuesday, February 01, 2011 5:01 PM
>> To: Jean Pihet
>> Cc: linux-omap@vger.kernel.org; Jean Pihet-XID
>> Subject: RE: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
>>
>> > -----Original Message-----
>> > From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
>> > Sent: Tuesday, February 01, 2011 4:53 PM
>> > To: Santosh Shilimkar
>> > Cc: linux-omap@vger.kernel.org; Jean Pihet-XID
>> > Subject: Re: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
>> >
>>
>> [...]
>> > >> Does that makes sense?
>> > >>
>> > > Actually not. Rather I will separate only the scenario's
>> > > where CORE low power targets are attempted and only have
>> > > that code run from SRAM.
>> > >
>> > > There are scenario's where CORE can be active because MODEM,
>> > > DSP and MPU can still hit RET, OFF. And here, the errata
>> > > isn't applicable.
>> > >
>> > > Unless I missed something here, I think in the code we check
>> > > the the CORE attempted state and based on that we can do a
>> > > normal WFI from DDR (no self rfersh) or WFI from
>> > > SRAM with self refresh enabled.
>> > No. Only the MPU attempted state is checked (this actually is the
>> > 'save_state' parameter passed to omap_cpu_suspend).
>> > So it makes sense to check the CORE attempted state in order to
>> > decide
>> > to run the WFI from internal SRAM or DDR.
>> >
>> > The MPU attempted state is used to decide whether to save the
>> > MPU/L1/L2 context.
>> >
>> Looks like you miss-understood my point. As I understand from
>> errata, as long as core clock domain can idle with core
>> dpll divider auto idle enabled, the errata is applicable.
>>
>> So the only check needed is to see if the core clockdomain
>> hw_auto or sw sleep is enabled.
>>
>> If it is suppose to be not idle(we force few C-states
>> where CORE inactive is avoided for faster response),
>> we can execute WFI from DDR with not enabling
>> self refresh.
Is this the way to go?

>>
>> Rest of the scenario can follow the SRAM path.
>>
>> Hope this is clear to you.
>
> As per further discussion, I have updated your
> patch to address above by using core clockdomain
> state.
>
> Have tested OFF and RET with this new update and they
> work as expected. Feel free to update further if needed.
>
> ------
> From 49fe8164a40431807495638ec23639cc9bc53cb9 Mon Sep 17 00:00:00 200=
1
> From: Jean Pihet <j-pihet@ti.com>
> Date: Sat, 29 Jan 2011 20:51:19 +0530
> Subject: [PATCH] OMAP3: run the ASM sleep code from DDR
=2E..

>
> -omap3_do_wfi:
> +do_WFI:
> + =A0 =A0 =A0 ldr =A0 =A0 r4, cm_clkstctrl_core =A0 @ read the CLKSTC=
TRL_CORE
> + =A0 =A0 =A0 ldr =A0 =A0 r5, [r4] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ r=
ead the contents of
> CLKSTCTRL_CORE
> + =A0 =A0 =A0 and =A0 =A0 r5, r5, #0x3
> + =A0 =A0 =A0 cmp =A0 =A0 r5, #0x3
> + =A0 =A0 =A0 beq =A0 =A0 omap3_do_wfi =A0 =A0 =A0 =A0 =A0 =A0@ Jumpt=
 to SRAM function
> + =A0 =A0 =A0 mov =A0 =A0 r1, #0
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r1, c7, c10, 4
> + =A0 =A0 =A0 mcr =A0 =A0 p15, 0, r1, c7, c10, 5
> +
> + =A0 =A0 =A0 wfi =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 @ wait for interrupt
> +
> + =A0 =A0 =A0 ldmfd =A0 sp!, {r0-r12, pc} =A0 =A0 =A0 @ restore regs =
and return

This code has a few problems:
- there now are 2 wfi instructions, which I would like to avoid for
readability and maintainability,
- are the mcr instructions needed here? From
arch/arm/include/asm/system.h it seems those are not needed for
__LINUX_ARM_ARCH__ >=3D 7

=46urthermore the main point of discussion to me is: is it advised to g=
o
into wfi without self refresh requested? Can anyone confirm this?

> +
> +
> +/*
> + * Local variables
> + */
> +omap3_do_wfi_sram_addr:
> + =A0 =A0 =A0 .word omap3_do_wfi_sram
> +kernel_flush:
> + =A0 =A0 =A0 .word v7_flush_dcache_all
> +
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + * =3D=3D WFI instruction =3D> Enter idle =3D=3D
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + */
> +
> +/*
> + * Do WFI instruction
> + * Includes the resume path for non-OFF modes
> + *
> + * This code gets copied to internal SRAM and is accessible
> + * from both SDRAM and SRAM:
> + * - executed from SRAM for non-off modes (omap3_do_wfi_sram),
> + * - executed from SDRAM for OFF mode (omap3_do_wfi).
> + */
> +ENTRY(omap3_do_wfi)
> =A0 =A0 =A0 =A0ldr =A0 =A0 r4, sdrc_power =A0 =A0 =A0 =A0 =A0@ read t=
he SDRC_POWER register
> =A0 =A0 =A0 =A0ldr =A0 =A0 r5, [r4] =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0@ =
read the contents of SDRC_POWER
> =A0 =A0 =A0 =A0orr =A0 =A0 r5, r5, #0x40 =A0 =A0 =A0 =A0 =A0 @ enable=
 self refresh on idle req
> @@ -302,7 +348,7 @@ omap3_do_wfi:
>
> =A0/*
> =A0* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - * =3D=3D Resume path for non-OFF modes =3D=3D
> + * =3D=3D Resume path for OFF/RET modes =3D=3D
> =A0* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =A0*/
> =A0 =A0 =A0 =A0nop
> @@ -315,15 +361,113 @@ omap3_do_wfi:
> =A0 =A0 =A0 =A0nop
> =A0 =A0 =A0 =A0nop
> =A0 =A0 =A0 =A0nop
> - =A0 =A0 =A0 bl wait_sdrc_ok
=2E..

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
