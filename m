From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH v8 00/24] gpio/omap: driver cleanup and fixes
Date: Wed, 30 Nov 2011 20:09:18 +0530
Message-ID: <CANrkHUYb1kM03yfp4ak=5biAMJGuXpkRMhg0TU2H6_0GAiZTTQ@mail.gmail.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
	<87obwsg9ua.fsf@ti.com>
	<CAC83ZvKd3iBrQS5wESnAok8W_a4z-3jZYz17wy376sZJw6sCWg@mail.gmail.com>
	<CAC83Zv++T96AZRHbEiS_UaGp=Dmu+zQ8se97oaBLhg_+eW-smA@mail.gmail.com>
	<87y5uz6juz.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:35616 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752433Ab1K3OjV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Nov 2011 09:39:21 -0500
Received: by faap14 with SMTP id p14so510452faa.3
        for <linux-omap@vger.kernel.org>; Wed, 30 Nov 2011 06:39:19 -0800 (PST)
In-Reply-To: <87y5uz6juz.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Tue, Nov 29, 2011 at 8:45 PM, Kevin Hilman <khilman@ti.com> wrote:
> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
>
>> On Fri, Nov 4, 2011 at 2:57 PM, DebBarma, Tarun Kanti
>> <tarun.kanti@ti.com> wrote:
>>> On Fri, Nov 4, 2011 at 3:14 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>>>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>>>
>>>>> This series is continuation of cleanup of OMAP GPIO driver and fi=
xes.
>>>>
>>>> Using this series on 3630/Zoom3, UART wakeups no longer work from
>>>> suspend. =A0That suggests that GPIO wakeups from retention/off are=
 not
>>>> working.
>>>>
>>>> Please test GPIO wakeups from retention/off. =A0One way is to use =
Zoom3
>>>> UART wakeup from suspend using by enabling UART wakeups and suspen=
ding:
>>>>
>>>> =A0 # echo enabled > /sys/devices/platform/serial8250.0/tty/ttyS0/=
power/wakeup
>>>> =A0 # echo mem > /sys/power/state
>>> Ok, I will test and make necessary fix.
>> I have done retention test of the latest series on Zoom3. When I try
>> running off mode
>> test it says support is not present because of an errata.
>
> Specifically, CORE off is not supported on that rev of 36xx due to an
> errata. =A0Can you try on a newer 36xx?
>
>> Here is the overall log:
>
> The rest of the dump seems to point to an MMC driver problem. =A0Plea=
se
> take this with the MMC driver folks.
Hi Tarun,

Can you try with this patch queued in mmc-next for MMC warning
http://article.gmane.org/gmane.linux.kernel.mmc/10961
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
