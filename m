From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v8 00/24] gpio/omap: driver cleanup and fixes
Date: Fri, 4 Nov 2011 14:57:18 +0530
Message-ID: <CAC83ZvKd3iBrQS5wESnAok8W_a4z-3jZYz17wy376sZJw6sCWg@mail.gmail.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
	<87obwsg9ua.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:43256 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753979Ab1KDJ1U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Nov 2011 05:27:20 -0400
Received: by qadc1 with SMTP id c1so2448684qad.26
        for <linux-omap@vger.kernel.org>; Fri, 04 Nov 2011 02:27:18 -0700 (PDT)
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
Ok, I will test and make necessary fix.
>
> Also, this series now has a handful of minor conflicts with stuff tha=
t
> is queued or merged for v3.2. =A0Please rebase onto
>
> =A0 git://github.com/khilman/linux-omap-pm.git for_3.3/gpio-base
ok.
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
