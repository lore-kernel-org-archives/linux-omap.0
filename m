From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2 1/3] ARM: omap: Enable low-level omap3 PM code to work withCONFIG_THUMB2_KERNEL
Date: Tue, 7 Dec 2010 14:53:56 +0000
Message-ID: <AANLkTi=7MXKUwjyPgDBO9XV-CZw7RNOmWKj0JP_kB9aC@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-2-git-send-email-dave.martin@linaro.org>
	<8ff74b57e40b64459978eefba8f4c9ca@mail.gmail.com>
	<AANLkTikOSb5-wBSy_ZANVsHga7XmWPrwP=0Xs0eGOxb5@mail.gmail.com>
	<AANLkTimPiySTjzTw6owG8GWPv2OwoNQ=wyV4kdvP9EZu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43770 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab0LGOx5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 09:53:57 -0500
Received: by iwn9 with SMTP id 9so1646861iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 06:53:57 -0800 (PST)
In-Reply-To: <AANLkTimPiySTjzTw6owG8GWPv2OwoNQ=wyV4kdvP9EZu@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org

Hi,

On Tue, Dec 7, 2010 at 11:59 AM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
> Hi Dave,
>
> On Tue, Dec 7, 2010 at 11:16 AM, Dave Martin <dave.martin@linaro.org> wrote:
>> On Tue, Dec 7, 2010 at 6:31 AM, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> wrote:
>>> Dave,
>>>> -----Original Message-----
>>>> From: linaro-dev-bounces@lists.linaro.org [mailto:linaro-dev-
>>>> bounces@lists.linaro.org] On Behalf Of Dave Martin
>>>> Sent: Monday, December 06, 2010 11:06 PM
>>>> To: linux-arm-kernel@lists.infradead.org
>>>> Cc: Tony Lindgren; Dave Martin; linux-omap@vger.kernel.org; linaro-
>>>> dev@lists.linaro.org
>>>> Subject: [PATCH v2 1/3] ARM: omap: Enable low-level omap3 PM code to
>>> work
>>>> withCONFIG_THUMB2_KERNEL
>>>>
>>
>> [...]
>>
>>>
>>> No need to mention but this patch changes lot of things around
>>> power management code. You said " Tested on: omap3 (Beagle xM A2)"
>>>
>>> What did you test ? Is it just boot test ? For sure just boot
>>> test is not enough for this patch and needs to test the PM.
>>
>> That's a fair point--- yes, I've only tested boot / reboot / shutdown so far.
>>
> The ASM idle code is being reworked right now, which means the T2
> support will need to be reworked on top of the patches. Cf. [1] and
> [2].
[...]
On Tue, Dec 7, 2010 at 12:59 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
[...]
> For your information, the on-going changes are:
> - run (most of the) code from the DDR instead of the internal SRAM.
> - convert the ASM idle code to C-code,
>
> I am working on getting those changes submitted, it should be done this week.
>
> Unfortunately those changes have implications on your changes for T2.
> As far as I understood converting the code to C-code should solve the
> T2 problem as well. What do you think?
>
> In any case I will let you know. Could you test the changes when they
> are available?
[...]

In general, converting the code to C will solve a lot of potential
problems.  If you don't copy the code, that also simplifies matters.

Note that converting to C doesn't mean that code which attempts to
copy function bodies will work: you still need to handle the fact that
if f() is a C function symbol, then the value of the symbol f is
actually the function's base address + 1.  See my changes in sram.c,
pm34xx.c etc.

If there are still bits of ARM code (such as the resume re-entry
point?) some care will still be needed there.

Anyone maintaining low-level and assembler code may find the following
useful: https://wiki.ubuntu.com/ARM/Thumb2PortingHowto

>> If you have any thoughts about how to exercise the power management
>> functionality more completely, I'd be happy to have a go...
> Cf. [3] for more details on how to exercise the PM on the target. This
> wiki page is slightly outdated but the idea is still the same. Note
> that only cpuidle is currently supported correctly on l-o master.
>
> [1] http://marc.info/?l=linux-omap&m=129139584919242&w=2
> [2] http://marc.info/?l=linux-omap&m=129172034809447&w=2
> [3] http://elinux.org/OMAP_Power_Management

Thanks for this info

Humm, which reference tree should I be using?  I'm not convinced it
works properly/usefully in the linaro trees ... only OMAP_PM_NOOP is
provided, and when I echo mem >/sys/power/state, the platform does not
crash (at least, it doesn't lock up) but doesn't appear to suspend
properly either.  Also, I'm not seeing your debugs contents.


On a separate topic, I have some firmware questions you might be able to answer:
  * Does the secure firmware attempt to read the comment field from
SMC instructions?  And if so, does it assume the SMC is in ARM code?
  * Is the secure firmware able to cope with a Thumb resume re-entry point?

Currently, I've taken the conservative approach and assume that the
answer to both of these questions is "no".  But this means that a few
bits of code need to be built as ARM which could otherwise be Thumb.
It would be cleaner to get the amount of ARM code down to an absolute
minimum when building a Thumb kernel.



Some specific comments on your patches:

After the label "finished:" in sleep34xx.S
+	ldr r1, kernel_flush
+	mov lr, pc
+	bx  r1

If the code might be built as Thumb-2, this won't work correctly,
because the Thumb bit (bit 0) will not get set properly in lr.
Instead:

+	ldr r1, kernel_flush
+	blx r1

Even if you think this code isn't going to be built for Thumb-2, it's
specific to v7+ platforms, so I recommend you use the above change
anyway: it's more compact and will help avoid maintenance problems
further down the line...


+	str	r4, wait_dll_lock_counter
[...]
+	str	r4, kick_counter

PC-relative stores are illegal in Thumb-2.  Worse, current binutils
will assemble invalid code if you do this in the source and build for
Thumb-2.  For details and my fix, search for "PC-relative stores" on
http://lists.arm.linux.org.uk/lurker/message/20101130.133117.a98bf92f.en.html



+ENTRY(get_omap3630_restore_pointer)
+        stmfd   sp!, {lr}     @ save registers on stack
+	adr	r0, restore_3630

If restore_3630 is a Thumb symbol, this will go wrong, because the
"Thumb bit" won't get set in the address.  Instead, you would need to
use "adr r0, BSYM(restore_3630)", but only if restore_3630 is built as
Thumb-2 when the kernel is built with CONFIG_THUMB2_KERNEL.

Cheers
---Dave
