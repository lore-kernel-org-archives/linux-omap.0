From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [pm-wip/uart][PATCH 0/5 v2] Serial HWMOD updation and uart4
	support for 3630
Date: Tue, 22 Jun 2010 19:53:23 +0530
Message-ID: <AANLkTimseY5PuiUj5vtc9LTFvr1eni89CpWjuPmDp078@mail.gmail.com>
References: <2134.10.24.255.18.1276697618.squirrel@dbdmail.itg.ti.com>
	<87d3vpciim.fsf@deeprootsystems.com>
	<8739wk6vzd.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39631 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab0FVOXZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 10:23:25 -0400
Received: by gye5 with SMTP id 5so2945148gye.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Jun 2010 07:23:24 -0700 (PDT)
In-Reply-To: <8739wk6vzd.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org

On Fri, Jun 18, 2010 at 11:53 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Kevin Hilman <khilman@deeprootsystems.com> writes:
>
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> Changes from v1:
>>> * Incorporated : OMAP clock: Add uart4_ick/fck definitions for 3630
>>> * using omap_mux_request_signal to retreive padconf offset
>>> =A0 as per Tony's comments.
>>> =A0 http://marc.info/?l=3Dlinux-omap&m=3D127609369220618&w=3D2
>>> =A0 This patch series as a dependecy on the patch
>>> =A0 for "omap_mux_request_signal" posted earlier
>>> =A0 https://patchwork.kernel.org/patch/105962/
>>> * Clean up certain comments.
>>> =A0 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30348=
=2Ehtml
>>>
>>> Patch series is based on remotes/origin/pm-wip/uart
>>> branch from Kevin's PM tree.
>>>
>>> 1.) Add support for UART4 for 3630.
>>> 2.) Modify Serial hwmod to avoid hwmod lookup using name string.
>>>
>>> Govindraj.R (5):
>>> =A0 OMAP clock: Add uart4_ick/fck definitions for 3630
>>> =A0 OMAP3: PRCM: Consider UART4 for 3630 chip in prcm_setup_regs
>>> =A0 OMAP3: serial: Fix uart4 handling for 3630
>>> =A0 OMAP3: PM: Add prepare idle and resume idle call for uart4
>>> =A0 Serial: Avoid using hwmod lookup using name string.
>>
>> Govindraj,
>>
>> Can you add this one to your series and test it on your boards?
>>
>
> Actually, my patch doesn't really work either, so it needs some more =
digging.
>
> Basically, there's a problem during static suspend on boards like Zoo=
m3
> that don't ever add/register any OMAP UARTs and just use the ones
> on the debug board.
>
> Somehow, we have to keep from adding UARTs to the uart_list unless
> they are actually registered to board files.

for zoom boards we are not calling omap_serial_init from board files

omap_serial_init ---> omap_serial_init_port which is the one that does
an list_add_tail

So in my understanding basically the list will be empty for zoom boards=
=2E

Or is it the omap_serial_early_init call which populates certain data f=
or uart
causing the issue.

IMHO if we are not enabling OMAP-UARTs by default then we should also n=
ot call
omap_serial_early_init

But I dont see any good reason why are we disabling omap-uarts for zoom=
 boards.
Shouldn't we keep it enabled by default?

Currently OMAP-UARTs are getting disabled only with zoom defconfigs.

Regards,
Govindraj.R


>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
