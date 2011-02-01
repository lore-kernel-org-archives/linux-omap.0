From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
Date: Tue, 1 Feb 2011 12:23:14 +0100
Message-ID: <AANLkTinPxJigu8Nc5J04ciQ_c_Kw9R2xS7s1jaiqeM+F@mail.gmail.com>
References: <1294935563-14426-1-git-send-email-j-pihet@ti.com>
	<b52b65db02da68b3febc0c9cf1e99040@mail.gmail.com>
	<9215f5d7252a4b60f58c3e14a9d46f59@mail.gmail.com>
	<AANLkTinRZyVBu=c3cHBQ7OmJv3U8717_w8Haig4R=ZQh@mail.gmail.com>
	<86b8aab234e1451170c0937e2ab786e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44185 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab1BALXP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 06:23:15 -0500
Received: by qwa26 with SMTP id 26so6567324qwa.19
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 03:23:14 -0800 (PST)
In-Reply-To: <86b8aab234e1451170c0937e2ab786e5@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

Hi Santosh,

On Mon, Jan 31, 2011 at 12:00 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
>> Sent: Monday, January 31, 2011 4:07 PM
>> To: Santosh Shilimkar
>> Cc: linux-omap@vger.kernel.org; Jean Pihet-XID
>> Subject: Re: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
>>
>> Hi Santosh,
> [.....]
>
>> >> > + =A0 =A0* For OFF mode: save context and jump to WFI in SDRAM
>> >> > (omap3_do_wfi)
>> >> > + =A0 =A0* For non-OFF modes: jump to the WFI code in SRAM
>> >> > (omap3_do_wfi_sram)
>> >>
>> >> Why is this distinction? For non-low power modes
>> >> it should be even safer to issue WFI from DDR itself.
>> >>
>> >> Do I miss any errata here ?
>> For non-OFF modes the erratum ID i581 WA forces us to restore the
>> SDRC
>> state before accessing the SDRAM, cf. wait_sdrc_ok that implements
>> that. Given that the non-OFF mode triggering WFI needs to be run
>> from
>> SRAM.
>>
> The errata is applicable when CORE hits low power states and DPLL
> can autoidle. Not sure how are linking this with all non-OFF modes.
>
>> > Looking further into code, I also noticed that the
>> > DDR self refresh is attempted for every WFI. This
>> > certainly isn't correct and should be attempted only
>> > if core OFF or RET is attempted. Putting DDR to
>> > self refresh comes with latency cost and you
>> > certainly don't want to incur that for lower C states
>> > where may be just MPU hits lower states.
>> The DDR self refresh is enabled at each WFI but not necessarily hit.
>> It is actually triggered by the CORE idle request which depends on
>> the
>> settings, the dependencies, the HW states... For example the CORE
>> state depends on the MPU state so if the MPU stays ON running
>> instructions the CORE will stay ON as well.
>>
>> Also the code in wait_sdrc_ok will exit quicker if the CORE DPLL is
>> already locked, e.g. if the CORE did not hit a low power state.
>> Since
>> the actual CORE hit state is unknow after wake-up from WFI the
>> wait_sdrc_ok code always run at wake-up from MPU RET.
>>
>> Does that makes sense?
>>
> Actually not. Rather I will separate only the scenario's
> where CORE low power targets are attempted and only have
> that code run from SRAM.
>
> There are scenario's where CORE can be active because MODEM,
> DSP and MPU can still hit RET, OFF. And here, the errata
> isn't applicable.
>
> Unless I missed something here, I think in the code we check
> the the CORE attempted state and based on that we can do a
> normal WFI from DDR (no self rfersh) or WFI from
> SRAM with self refresh enabled.
No. Only the MPU attempted state is checked (this actually is the
'save_state' parameter passed to omap_cpu_suspend).
So it makes sense to check the CORE attempted state in order to decide
to run the WFI from internal SRAM or DDR.

The MPU attempted state is used to decide whether to save the MPU/L1/L2=
 context.

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
