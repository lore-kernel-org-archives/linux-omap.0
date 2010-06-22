From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [pm-wip/uart][PATCH 0/5 v2] Serial HWMOD updation and uart4  support for 3630
Date: Tue, 22 Jun 2010 07:49:31 -0700
Message-ID: <878w67nmv8.fsf@deeprootsystems.com>
References: <2134.10.24.255.18.1276697618.squirrel@dbdmail.itg.ti.com>
	<87d3vpciim.fsf@deeprootsystems.com>
	<8739wk6vzd.fsf@deeprootsystems.com>
	<AANLkTimseY5PuiUj5vtc9LTFvr1eni89CpWjuPmDp078@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39832 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756481Ab0FVOzQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 10:55:16 -0400
Received: by pvh11 with SMTP id 11so416244pvh.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Jun 2010 07:55:14 -0700 (PDT)
In-Reply-To: <AANLkTimseY5PuiUj5vtc9LTFvr1eni89CpWjuPmDp078@mail.gmail.com> (Govindraj's message of "Tue\, 22 Jun 2010 19\:53\:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org

Govindraj <govindraj.ti@gmail.com> writes:

> On Fri, Jun 18, 2010 at 11:53 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Kevin Hilman <khilman@deeprootsystems.com> writes:
>>
>>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>>
>>>> Changes from v1:
>>>> * Incorporated : OMAP clock: Add uart4_ick/fck definitions for 363=
0
>>>> * using omap_mux_request_signal to retreive padconf offset
>>>> =A0 as per Tony's comments.
>>>> =A0 http://marc.info/?l=3Dlinux-omap&m=3D127609369220618&w=3D2
>>>> =A0 This patch series as a dependecy on the patch
>>>> =A0 for "omap_mux_request_signal" posted earlier
>>>> =A0 https://patchwork.kernel.org/patch/105962/
>>>> * Clean up certain comments.
>>>> =A0 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg3034=
8.html
>>>>
>>>> Patch series is based on remotes/origin/pm-wip/uart
>>>> branch from Kevin's PM tree.
>>>>
>>>> 1.) Add support for UART4 for 3630.
>>>> 2.) Modify Serial hwmod to avoid hwmod lookup using name string.
>>>>
>>>> Govindraj.R (5):
>>>> =A0 OMAP clock: Add uart4_ick/fck definitions for 3630
>>>> =A0 OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
>>>> =A0 OMAP3: serial: Fix uart4 handling for 3630
>>>> =A0 OMAP3: PM: Add prepare idle and resume idle call for uart4
>>>> =A0 Serial: Avoid using hwmod lookup using name string.
>>>
>>> Govindraj,
>>>
>>> Can you add this one to your series and test it on your boards?
>>>
>>
>> Actually, my patch doesn't really work either, so it needs some more=
 digging.
>>
>> Basically, there's a problem during static suspend on boards like Zo=
om3
>> that don't ever add/register any OMAP UARTs and just use the ones
>> on the debug board.
>>
>> Somehow, we have to keep from adding UARTs to the uart_list unless
>> they are actually registered to board files.
>
> for zoom boards we are not calling omap_serial_init from board files
>
> omap_serial_init ---> omap_serial_init_port which is the one that doe=
s
> an list_add_tail
>
> So in my understanding basically the list will be empty for zoom boar=
ds.

Well, it *should* be empty.

> Or is it the omap_serial_early_init call which populates certain data=
 for uart
> causing the issue.

Correct.   Using your last series as the baseline (ending at
Serial: Avoid using hwmod lookup using name string), the uart_list
uart_list is still populated for every hwmod, but it hasn't been
fully initialized since the board code hasn't called omap_serial_init()
or _init_port()

So, when the idle path calls into this code, it does strange things
(for example omap_uart_enable_irqs() tries to request/free IRQ 0 since
the IRQ has not bee initialized.

> IMHO if we are not enabling OMAP-UARTs by default then we should also=
 not call
> omap_serial_early_init

Well, we need to have a list of available UART hwmods so that if
somone eventually enables a UART, we are ready.

> But I dont see any good reason why are we disabling omap-uarts for zo=
om boards.
> Shouldn't we keep it enabled by default?

No, they should only be enabled if used.  That will speed up the
idle path by not managing UARTS.

> Currently OMAP-UARTs are getting disabled only with zoom defconfigs.

A similar problem exists on Rover where only a single UART is being ena=
bled
in the board file instead of all.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
