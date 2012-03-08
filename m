From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
Date: Thu, 08 Mar 2012 10:27:17 -0800
Message-ID: <87sjhjaqyi.fsf@ti.com>
References: <20120202093600.12509.35052.stgit@dusk> <87ty39cc7s.fsf@ti.com>
	<alpine.DEB.2.00.1202021140060.586@utopia.booyaka.com>
	<alpine.DEB.2.00.1202021328450.586@utopia.booyaka.com>
	<CAKd1q9rq67gUyXn+rOL348YwaYQiqHR8UQCSd68fpxhZHHsYGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:58604 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754006Ab2CHS1R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 13:27:17 -0500
Received: by mail-gx0-f181.google.com with SMTP id i4so599590ggn.26
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 10:27:16 -0800 (PST)
In-Reply-To: <CAKd1q9rq67gUyXn+rOL348YwaYQiqHR8UQCSd68fpxhZHHsYGA@mail.gmail.com>
	(Luciano Coelho's message of "Thu, 8 Mar 2012 14:21:43 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Coelho, Luciano" <coelho@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

Hi Luca,

"Coelho, Luciano" <coelho@ti.com> writes:

[...]

> I can't get ttyO2 wakeup to work on my Blaze with 3.3-rc5.  It works
> fine with 3.2.  

I assume you mean wakeup from system-wide suspend (echo mem > /sys/power/state)?

Are you enabling UART wakeups?

They are disabled by default, so you need to:

echo enabled > /sys/devices/platform/omap/omap_uart.2/tty/ttyO2/power/wakeup

It may work in v3.2 due to the fact that the UART runtime PM had the
unintended side-effect of essentially disabling MPU and CORE PM.  With
that bug fixed and MPU & CORE actually hitting low power states, you'll
need to ensure UART wakeups are enabled.

If you're already enabling wakeups and this still isn't working, try
adding 'no_console_suspend' to the kernel cmdline, try a suspend/resume
and post the console output.

Thanks,

Kevin
