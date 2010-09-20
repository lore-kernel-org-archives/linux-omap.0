From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/11] OMAP: Serial: Add omap-serial driver with platform support
Date: Mon, 20 Sep 2010 09:21:19 -0700
Message-ID: <87wrqg2xog.fsf@deeprootsystems.com>
References: <13965.10.24.255.18.1284739547.squirrel@dbdmail.itg.ti.com>
	<87tylorl9i.fsf@deeprootsystems.com>
	<AANLkTik-+RC7y=dJnDdxzrqMFnTzRV-j8s5FtmMy8ZhE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52411 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab0ITQVX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Sep 2010 12:21:23 -0400
In-Reply-To: <AANLkTik-+RC7y=dJnDdxzrqMFnTzRV-j8s5FtmMy8ZhE@mail.gmail.com>
	(Govindraj's message of "Sat, 18 Sep 2010 14:47:22 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Govindraj <govindraj.ti@gmail.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Govindraj <govindraj.ti@gmail.com> writes:

> On Sat, Sep 18, 2010 at 5:11 AM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>>
>>> This patch series adds a serial driver to handle uarts on omap plat=
forms.
>>> Currenlty omap-uarts are handled with 8250 driver, since updating
>>> this driver with omap specific features will over load
>>> the 8250 driver with all omap-specific data thus a new driver
>>> is added to configure and support features like
>>> dma, h/w, s/w flowcontrol for omap-uarts.
>>> Also the patch series updates various low level platform specific
>>> serial data to support omap-uarts with hwmod framework and adds sup=
port
>>> for uart4 on OMAP3630.
>>
>> This series is missing a couple things to work more broadly on all
>> boards, specifically 3630-based boards.
>>
>> First, due to the current UART idle code base, you need to enable al=
l
>> OMAP UARTs 36xx. =A0Enabling less than all OMAP UARTs will break the
>> current idle code. =A0As we discussed, the next phase we will move t=
he
>> idle management from this serial.c hackery into the omap-serial driv=
er
>> iteself. =A0Until then, you need to call omap_serial_init() on
>> Zoom2/Zoom3. =A0Patch below[1]
>>
>> Also, you previously had a patch that updated omap_uart_idle_init() =
to
>> handle 36xx and specifically UART4. =A0Without that, struct
>> omap_uart_state is not setup correctly for UART4, and thus cannot be
>> properly idled on 3630.
>
> ok fine, I will I incorporate initialize all uarts patch for zoom boa=
rds.
>
> Are you referring to this patch?
> https://patchwork.kernel.org/patch/108066/
>
> Is this still needed if we have initialized all uarts?
> This patch might not needed if we have initialized all uarts right?

Right.  We don't need the above patchwork patch if all UARTs are
initialized.

The other patch I was referring to was the one that added UART4 support
to omap_uart_idle_init() (added the wk_en, wk_st, padconf etc.)  I had =
a
pending request for you to drop the muxmode from that patch, but the
rest of it was still needed.

>>
>> Also, it's been a while since I tested this on OMAP2. =A0Please re-t=
est on
>> OMAP2 with the whole series. =A0Also, please report here the other
>> platforms this was tested on. =A0The final needs to be tested on OMA=
P2, 3
>> and 4 before merge.
>
> Yes Sure,
>
> Just FYI this patch series was also tested on omap2,3,4.
>

OK, be sure to test Zoom3, because my testing on Zoom3 led to a crash a=
s
soon as idle was enabled due to the missing init of all UARTs.

Thanks,

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
