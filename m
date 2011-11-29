From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 00/24] gpio/omap: driver cleanup and fixes
Date: Tue, 29 Nov 2011 07:17:52 -0800
Message-ID: <87ty5n6jq7.fsf@ti.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
	<87obwsg9ua.fsf@ti.com>
	<CAC83ZvKJRxGK-j16Yj9A60rSPNNV-4MMxUd9f7w7n-KJr2R+VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:48711 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753332Ab1K2PR4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Nov 2011 10:17:56 -0500
Received: by mail-iy0-f173.google.com with SMTP id k32so12190868iak.4
        for <linux-omap@vger.kernel.org>; Tue, 29 Nov 2011 07:17:55 -0800 (PST)
In-Reply-To: <CAC83ZvKJRxGK-j16Yj9A60rSPNNV-4MMxUd9f7w7n-KJr2R+VQ@mail.gmail.com>
	(Tarun Kanti DebBarma's message of "Mon, 28 Nov 2011 13:53:11 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

> On Fri, Nov 4, 2011 at 3:14 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>
>>> This series is continuation of cleanup of OMAP GPIO driver and fixe=
s.
>>
>> Using this series on 3630/Zoom3, UART wakeups no longer work from
>> suspend. =C2=A0That suggests that GPIO wakeups from retention/off ar=
e not
>> working.
>>
>> Please test GPIO wakeups from retention/off. =C2=A0One way is to use=
 Zoom3
>> UART wakeup from suspend using by enabling UART wakeups and suspendi=
ng:
>>
>> =C2=A0 # echo enabled > /sys/devices/platform/serial8250.0/tty/ttyS0=
/power/wakeup
>> =C2=A0 # echo mem > /sys/power/state
>>
>> Also, this series now has a handful of minor conflicts with stuff th=
at
>> is queued or merged for v3.2. =C2=A0Please rebase onto
>>
>> =C2=A0 git://github.com/khilman/linux-omap-pm.git for_3.3/gpio-base
> I am not seeing for_3.3/gpio-base branch anymore.
> Is there an alternate branch where I can post the patch?

v3.2-rc3

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
