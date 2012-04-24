From: "Raja, Govindraj" <govindraj.raja@ti.com>
Subject: Re: [PATCH 1/2] OMAP2+: UART: Fix incorrect population of default
 uart pads
Date: Tue, 24 Apr 2012 14:08:00 +0530
Message-ID: <CAMrsUdKnDaO7qV2NpNvTb3QdO-XeM_PF645Mc43RozFVex71hQ@mail.gmail.com>
References: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
 <1334065246-21294-2-git-send-email-govindraj.raja@ti.com> <87397uhv0q.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:59373 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755991Ab2DXIiX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Apr 2012 04:38:23 -0400
Received: by obceq6 with SMTP id eq6so697015obc.6
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 01:38:21 -0700 (PDT)
In-Reply-To: <87397uhv0q.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Russ Dill <russ.dill@gmail.com>

On Tue, Apr 24, 2012 at 5:15 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> From: "Govindraj.R" <govindraj.raja@ti.com>
>>
>> The following commit:
>> (7496ba3 =A0ARM: OMAP2+: UART: Add default mux for all uarts)
>> added default pads for all uarts. But not all boards tend to
>> use all uarts and most of unused uart pins are muxed for
>> other purpose. This commit breaks the modules which where trying
>> to use unused uart pins on their boards.
>>
>> So remove the default pads adding.
>
> I just noticed that this patch breaks runtime PM & wakeups for UART
> console (at least on 3530/Overo with ttyO2 console.)
>
> By removing the pads, the initial device_init_wakeup() is not called =
on
> port init. =A0Without this call serial_omap_pm() disables runtime PM
> because it checks device_may_wakeup().
>
> Since runtime PM was disabled, I manually re-enabled it and then enab=
led
> wakeups:
>
> =A0echo auto > /sys/devices/platform/omap_uart.2/power/control
> =A0echo enabled > /sys/devices/platform/omap_uart.2/tty/ttyO2/power/w=
akeup
>
> Then, after enabling auto-suspend timeouts, it seems wakeups are stil=
l
> not working since the console hangs.
>
> Reverting $SUBJECT patch gets things working again.

This was decided as part of discussion [1]

If we are _reconsidering_ taking this patch [2]
to dynamically probe uart pins and enable rx wakeup.

I can re-work on the patch[2] as per tony's comments[1]
and re-post it.

--
Thanks,
Govindraj.R

[1]:
http://www.spinics.net/lists/linux-omap/msg68226.html

[2]:
http://www.spinics.net/lists/linux-omap/msg67822.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
