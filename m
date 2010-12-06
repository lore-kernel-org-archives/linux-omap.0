From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2 1/3] ARM: omap: Enable low-level omap3 PM code to work
 with CONFIG_THUMB2_KERNEL
Date: Mon, 6 Dec 2010 18:41:31 +0000
Message-ID: <AANLkTi=E4wDRH6CtNhvX-iHmrDeWK8jrqyYJtiTPMrV8@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-2-git-send-email-dave.martin@linaro.org>
	<AANLkTi=OhchW6rqMmTP5dpUF7aKwy9iArETaHdwi5cjN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57034 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345Ab0LFSlc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 13:41:32 -0500
Received: by vws16 with SMTP id 16so2808605vws.19
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 10:41:31 -0800 (PST)
In-Reply-To: <AANLkTi=OhchW6rqMmTP5dpUF7aKwy9iArETaHdwi5cjN@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org

Hi,

On Mon, Dec 6, 2010 at 6:17 PM, Catalin Marinas <catalin.marinas@arm.co=
m> wrote:
> On 6 December 2010 17:35, Dave Martin <dave.martin@linaro.org> wrote:
>> =A0* Explicitly build a few parts of sleep34xx.S as ARM.
>>
>> =A0 =A0 =A0* lock_scratchpad_sem is kept as ARM because of the need =
to
>> =A0 =A0 =A0 =A0synchronise with hardware (?) using the SWP instructi=
on.
>>
>> =A0 =A0 =A0* save_secure_ram_context and omap34xx_cpu_suspend are bu=
ilt
>> =A0 =A0 =A0 =A0as ARM in case the Secure World firmware expects to d=
ecode
>> =A0 =A0 =A0 =A0the comment field from the SMC (aka smi) instructions=
=2E
>>
>> =A0 =A0 =A0 =A0This can be undone later if the firmware is confirmed=
 as
>> =A0 =A0 =A0 =A0able to decode the Thumb SMC encoding (or ignores the
>> =A0 =A0 =A0 =A0comment field).
>>
>> =A0 =A0 =A0* es3_sdrc_fix should presumably only be called from the
>> =A0 =A0 =A0 =A0low-level wakeup code. =A0To minimise the diff, switc=
hed this
>> =A0 =A0 =A0 =A0to ARM and demoted it to be a local symbol, since I b=
elieve
>> =A0 =A0 =A0 =A0it shouldn't be called from outside anyway.
>
> I haven't checked the code but does this always work? The kernel isn'=
t
> built with interworking enabled, so it's either ARM or Thumb-2.

Interworking is mandated by EABI, and when building for EABI there is
no such thing as non-interworking C code IIUC: i.e.,
-mno-thumb-interwork does nothing.  Certainly, calls via a function
pointer are assembled as BX instructions, and the linker fixes up
static function calls with the right instruction (BL/BX).

Provided the affected functions are only called from C code, and
providing that legacy tools/ABI aren't used, it should work.  I've
reviewed to make sure that this is the case, and the code as posted
executes correctly on Beagle xM (not including the omap4-specific
code, for which I have no board to test on).

CONFIG_THUMB2_KERNEL already depends on CONFIG_AEABI, so we should be
relatively safe on this point.  Without CONFIG_THUMB2_KERNEL,
everything is built as ARM, so we have no problem.

The two cases where we have to be careful are:

  * Where code assumes that f =3D=3D <base address of body of function =
f>,
which would lead to off-by-one errors by code which tries to copy
function bodies and derive pointers to the copies, due to the setting
of bit 0 of the address to indicate Thumb.  The patch series fix the
instances of this error present in the upstream OMAP BSP, except for
instances in code specific to OMAP2 and earlier which can't usefully
be built for Thumb-2 anyway.

  * Where bootloaders / firmware may jump directly into locations in
the kernel, and assume ARM (or don't interwork correctly), or where
the firmware may implicitly decode instructions from the caller as ARM
(e.g., to examine the SMC instruction comment field).  The most
straightforward way to avoid such problems is to make all such entry
points ARM.  But we could get rid of that if the platform maintainers
believe it's safe.


I did experiment with sticking with pure ARM in the low-level
assembler, with explicit veneers to switch instruction set, but that
gets rather messy and shouldn't really be necessary.  I suspect it
would be harder to maintain also.

Pure Thumb on the other hand is unlikely to be possible in every case:
the OMAP BSP uses SWP, and I've conservatively made the assumption
that bootloaders / firmware may assume they're jumping into ARM code,
and may try to decode SMC instructions as ARM instructions -- these
may not be true in practice, but these are harder to test, and I'm not
in a position to check _every_ bootloader/firmware/kernel combination
=2E..

Cheers
---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
