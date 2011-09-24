From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v7 00/26] gpio/omap: driver cleanup and fixes
Date: Sat, 24 Sep 2011 09:26:41 +0530
Message-ID: <CAC83ZvKu5Fo-c88L4WFPdvq91T=usaZY4mzTVVzDLw9HE7g9Kg@mail.gmail.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<87mxdwm8pk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:46297 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751290Ab1IXD4o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 23:56:44 -0400
Received: by bkbzs2 with SMTP id zs2so4838268bkb.0
        for <linux-omap@vger.kernel.org>; Fri, 23 Sep 2011 20:56:42 -0700 (PDT)
In-Reply-To: <87mxdwm8pk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, charu@ti.com

[...]
> After debugging this myself a bit, here's what I think may be going o=
n.
> This may not be the only problem but here's at least one of them.
>
> First, debounce clocks are disabled in the runtime_suspend callback.
>
> When a GPIO is freed and it's the last one in the bank, bank->mod_usa=
ge
> goes to zero.
>
> After that, pm_runtime_put_sync() is called, which will trigger the
> driver's ->runtime_suspend callback. =A0The ->runtime_suspend() callb=
ack
> checks bank->mod_usage as well, and if zero, doesn't do anything
> (notably, it doesn't disable debounce clocks.)
I need some clarification in reproducing/testing the fix on OMAP3430SDP=
=2E
The first thing I am trying to verify is the code flow of suspend.

1) With no debounce clock enabled, when I enable UART timeouts, I
automatically see
system going to retention. That is I don't have to type echo mem >
/sys/power/state
echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout

2) I am do not see the print in omap_gpio_suspend/resume(), but I see
the print in
*_prepare_for_idle()/*_resume_after_idle().

=46olks testing on Tablet2 platform said there is dedicated button to
suspend/resume.
Is there something equivalent?
--
Tarun
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
