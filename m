From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 00/24] gpio/omap: driver cleanup and fixes
Date: Tue, 29 Nov 2011 07:15:00 -0800
Message-ID: <87y5uz6juz.fsf@ti.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
	<87obwsg9ua.fsf@ti.com>
	<CAC83ZvKd3iBrQS5wESnAok8W_a4z-3jZYz17wy376sZJw6sCWg@mail.gmail.com>
	<CAC83Zv++T96AZRHbEiS_UaGp=Dmu+zQ8se97oaBLhg_+eW-smA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:49501 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753679Ab1K2PPJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Nov 2011 10:15:09 -0500
Received: by mail-yw0-f51.google.com with SMTP id 1so4732393yws.24
        for <linux-omap@vger.kernel.org>; Tue, 29 Nov 2011 07:15:08 -0800 (PST)
In-Reply-To: <CAC83Zv++T96AZRHbEiS_UaGp=Dmu+zQ8se97oaBLhg_+eW-smA@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Fri, 25 Nov 2011 16:00:27 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Fri, Nov 4, 2011 at 2:57 PM, DebBarma, Tarun Kanti
> <tarun.kanti@ti.com> wrote:
>> On Fri, Nov 4, 2011 at 3:14 AM, Kevin Hilman <khilman@ti.com> wrote:
>>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>>
>>>> This series is continuation of cleanup of OMAP GPIO driver and fix=
es.
>>>
>>> Using this series on 3630/Zoom3, UART wakeups no longer work from
>>> suspend. =C2=A0That suggests that GPIO wakeups from retention/off a=
re not
>>> working.
>>>
>>> Please test GPIO wakeups from retention/off. =C2=A0One way is to us=
e Zoom3
>>> UART wakeup from suspend using by enabling UART wakeups and suspend=
ing:
>>>
>>> =C2=A0 # echo enabled > /sys/devices/platform/serial8250.0/tty/ttyS=
0/power/wakeup
>>> =C2=A0 # echo mem > /sys/power/state
>> Ok, I will test and make necessary fix.
> I have done retention test of the latest series on Zoom3. When I try
> running off mode
> test it says support is not present because of an errata.=20

Specifically, CORE off is not supported on that rev of 36xx due to an
errata.  Can you try on a newer 36xx?

> Here is the overall log:

The rest of the dump seems to point to an MMC driver problem.  Please
take this with the MMC driver folks.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
