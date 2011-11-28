From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v8 00/24] gpio/omap: driver cleanup and fixes
Date: Mon, 28 Nov 2011 13:53:11 +0530
Message-ID: <CAC83ZvKJRxGK-j16Yj9A60rSPNNV-4MMxUd9f7w7n-KJr2R+VQ@mail.gmail.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
	<87obwsg9ua.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:33230 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751070Ab1K1IXN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Nov 2011 03:23:13 -0500
Received: by qadz3 with SMTP id z3so260885qad.2
        for <linux-omap@vger.kernel.org>; Mon, 28 Nov 2011 00:23:11 -0800 (PST)
In-Reply-To: <87obwsg9ua.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Fri, Nov 4, 2011 at 3:14 AM, Kevin Hilman <khilman@ti.com> wrote:
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
>> This series is continuation of cleanup of OMAP GPIO driver and fixes=
=2E
>
> Using this series on 3630/Zoom3, UART wakeups no longer work from
> suspend. =A0That suggests that GPIO wakeups from retention/off are no=
t
> working.
>
> Please test GPIO wakeups from retention/off. =A0One way is to use Zoo=
m3
> UART wakeup from suspend using by enabling UART wakeups and suspendin=
g:
>
> =A0 # echo enabled > /sys/devices/platform/serial8250.0/tty/ttyS0/pow=
er/wakeup
> =A0 # echo mem > /sys/power/state
>
> Also, this series now has a handful of minor conflicts with stuff tha=
t
> is queued or merged for v3.2. =A0Please rebase onto
>
> =A0 git://github.com/khilman/linux-omap-pm.git for_3.3/gpio-base
I am not seeing for_3.3/gpio-base branch anymore.
Is there an alternate branch where I can post the patch?
--
Tarun
>
> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
