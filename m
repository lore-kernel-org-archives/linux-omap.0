From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
Date: Mon, 31 Jan 2011 11:36:49 +0100
Message-ID: <AANLkTinRZyVBu=c3cHBQ7OmJv3U8717_w8Haig4R=ZQh@mail.gmail.com>
References: <1294935563-14426-1-git-send-email-j-pihet@ti.com>
	<b52b65db02da68b3febc0c9cf1e99040@mail.gmail.com>
	<9215f5d7252a4b60f58c3e14a9d46f59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40907 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755303Ab1AaKgu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Jan 2011 05:36:50 -0500
Received: by qyk12 with SMTP id 12so5983255qyk.19
        for <linux-omap@vger.kernel.org>; Mon, 31 Jan 2011 02:36:49 -0800 (PST)
In-Reply-To: <9215f5d7252a4b60f58c3e14a9d46f59@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

Hi Santosh,

On Sun, Jan 30, 2011 at 6:57 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
>> Sent: Saturday, January 29, 2011 10:45 PM
>> To: jean.pihet@newoldbits.com; linux-omap@vger.kernel.org
>> Cc: Jean Pihet-XID
>> Subject: RE: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
>>
>> Jean,
>> > -----Original Message-----
>> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> > owner@vger.kernel.org] On Behalf Of jean.pihet@newoldbits.com
>> > Sent: Thursday, January 13, 2011 9:49 PM
>> > To: linux-omap@vger.kernel.org
>> > Cc: Jean Pihet
>> > Subject: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
>> >
>> > From: Jean Pihet <j-pihet@ti.com>
>> >
>> > Most of the ASM sleep code (in arch/arm/mach-omap2/sleep34xx.S)
>> > is copied to internal SRAM and run from there.
>> > However only a small part of the code really needs to run from
>> > internal SRAM.
>> >
>> > This fix lets most of the ASM idle code run from the DDR
>> > in order to minimize the SRAM usage. No performance
>> > loss or gain can be measured with a 32KHz clock period.
>> >
>> > The only pieces of code that are mandatory in SRAM
>> > are:
>> > - the i443 erratum WA,
>> > - the i581 erratum WA,
>> > - the security extension code.
>> >
>> > SRAM usage:
>> > - original code:
>> > =A0 . 560 bytes for omap3_sram_configure_core_dpll (used by DVFS),
>> > =A0 . 1368 bytes for omap_sram_idle (used by suspend/resume in
>> > RETention),
>> > =A0 . 124 bytes for es3_sdrc_fix (used by suspend/resume in OFF mo=
de
>> > on ES3.x),
>> > =A0 . 108 bytes for save_secure_ram_context (used on HS parts).
>> >
>> > With this fix the usage for suspend/resume in RETention goes down
>> > 312 bytes, so the
>> > gain in SRAM usage for suspend/resume is > 1KB.
>> >
>> > Tested on OMAP3EVM, Beagleboard (ES2.x) and N900 (ES3.1)
>> > in idle with full RET and OFF modes.
>> >
>> > Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> > ---
>> > =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0| =A0 19 ++-
>> > =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0| =A0 19 ++-
>> > =A0arch/arm/mach-omap2/sleep34xx.S | =A0299 ++++++++++++++++++++++=
+---
>> --
>> > -----------
>> > =A03 files changed, 200 insertions(+), 137 deletions(-)
>> >
>> [...]
>>
>> > diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-
>> > omap2/sleep34xx.S
>> > index 98d8232..ced85b5 100644
>> > --- a/arch/arm/mach-omap2/sleep34xx.S
>> > +++ b/arch/arm/mach-omap2/sleep34xx.S
>> > @@ -163,8 +163,10 @@ ENTRY(save_secure_ram_context_sz)
>> > =A0 *
>> > =A0 *
>> > =A0 * Notes:
>> > - * - this code gets copied to internal SRAM at boot and after
>> wake-
>> > up
>> > - * =A0 from OFF mode. The execution pointer in SRAM is
>> > _omap_sram_idle.
>> > + * - only the minimum set of functions gets copied to internal
>> SRAM
>> > at boot
>> > + * =A0 and after wake-up from OFF mode, cf. omap_push_sram_idle.
>> The
>> > function
>> > + * =A0 pointers in SDRAM or SRAM are called depending on the
>> desired
>> > low power
>> > + * =A0 target state.
>> > =A0 * - when the OMAP wakes up it continues at different execution
>> > points
>> > =A0 * =A0 depending on the low power mode (non-OFF vs OFF modes),
>> > =A0 * =A0 cf. 'Resume path for xxx mode' comments.
>> > @@ -181,9 +183,15 @@ ENTRY(omap34xx_cpu_suspend)
>> > =A0 =A0 =A0* =A0 3 - Both L1 and L2 lost
>> > =A0 =A0 =A0*/
>> >
>> > - =A0 /* Directly jump to WFI is the context save is not required =
*/
>> > - =A0 cmp =A0 =A0 r1, #0x0
>> > - =A0 beq =A0 =A0 omap3_do_wfi
>> > + =A0 /*
>> > + =A0 =A0* For OFF mode: save context and jump to WFI in SDRAM
>> > (omap3_do_wfi)
>> > + =A0 =A0* For non-OFF modes: jump to the WFI code in SRAM
>> > (omap3_do_wfi_sram)
>>
>> Why is this distinction? For non-low power modes
>> it should be even safer to issue WFI from DDR itself.
>>
>> Do I miss any errata here ?
=46or non-OFF modes the erratum ID i581 WA forces us to restore the SDR=
C
state before accessing the SDRAM, cf. wait_sdrc_ok that implements
that. Given that the non-OFF mode triggering WFI needs to be run from
SRAM.

> Looking further into code, I also noticed that the
> DDR self refresh is attempted for every WFI. This
> certainly isn't correct and should be attempted only
> if core OFF or RET is attempted. Putting DDR to
> self refresh comes with latency cost and you
> certainly don't want to incur that for lower C states
> where may be just MPU hits lower states.
The DDR self refresh is enabled at each WFI but not necessarily hit.
It is actually triggered by the CORE idle request which depends on the
settings, the dependencies, the HW states... For example the CORE
state depends on the MPU state so if the MPU stays ON running
instructions the CORE will stay ON as well.

Also the code in wait_sdrc_ok will exit quicker if the CORE DPLL is
already locked, e.g. if the CORE did not hit a low power state. Since
the actual CORE hit state is unknow after wake-up from WFI the
wait_sdrc_ok code always run at wake-up from MPU RET.

Does that makes sense?

>
> Regards,
> Santosh
>

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
