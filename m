From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: omapdss wakeup issues
Date: Fri, 1 Mar 2013 14:25:05 +0100
Message-ID: <CABuKBe+==L3+3t0A0MxLWAu4HovG2vmfY3LXHVJakOw8=nP5MQ@mail.gmail.com>
References: <CALbNGRThXXuSE9Q9h7rcSHYm_s4nUcdGjC-xRFD23f0-Ncy3-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:43339 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab3CANZH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 08:25:07 -0500
Received: by mail-ee0-f41.google.com with SMTP id c13so2444087eek.0
        for <linux-omap@vger.kernel.org>; Fri, 01 Mar 2013 05:25:06 -0800 (PST)
In-Reply-To: <CALbNGRThXXuSE9Q9h7rcSHYm_s4nUcdGjC-xRFD23f0-Ncy3-w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?ISO-8859-1?Q?Andreas_M=FCller?= <schnitzeltony@googlemail.com>
Cc: linux-omap@vger.kernel.org

Hi Andreas,

2013/2/28 Andreas M=FCller <schnitzeltony@googlemail.com>:
> Hi,
>
> I am preparing 3.8 mainline for gumstix overo and have the following
> issue: waking Monitor connected by HDMI from power save makes Monitor
> complain for unsupported frequency and console says:
>
> | omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay
>
> Is this a known issue?

I'm not sure if it's the same issue, but you might give it a shot.
The problem is, that when changing the CPU frequency in OMAP3530, the
frequency of L3 is changed. This frequency is used in DSS.
The result is a fifo underflow on gfx.

=46irst check, if you use some dynamic cpufreq governor, which might be
changing the frequency.
A workaround (although not very nice) is to set fixed l3_main values
in mach-omap2/opp3xxx_data.c

Best regards,
Matthias

>
> Andreas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
---
motzblog.wordpress.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
